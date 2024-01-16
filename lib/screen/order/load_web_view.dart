// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/src/provider.dart';
import '../../provider/order_provider.dart';


// ignore: must_be_immutable
class LoadWebView extends StatefulWidget {
  String url;
  int OrderId;

  LoadWebView({required this.url, required this.OrderId , Key? key})
      : super(key: key);

  @override
  _LoadWebViewState createState() => _LoadWebViewState();
}

class _LoadWebViewState extends State<LoadWebView>
    with SingleTickerProviderStateMixin {
  final GlobalKey webViewKey = GlobalKey();

  late PullToRefreshController _pullToRefreshController;
  CookieManager cookieManager = CookieManager.instance();
  InAppWebViewController? webViewController;
  double progress = 0;
  String url = '';
  bool isLoading = false;
  bool showErrorPage = false;
  bool slowInternetPage = false;
  bool noInternet = false;
  late AnimationController animationController;
  late Animation<double> animation;
  final expiresDate =
      DateTime.now().add(Duration(days: 7)).millisecondsSinceEpoch;
  var browserOptions;
  bool _validURL = false;
  bool canGoBack = false;
  bool isUserAgentCorrect = false;

  @override
  void initState() {
    super.initState();
    _validURL = Uri.tryParse(widget.url)?.isAbsolute ?? false;

    try {
      _pullToRefreshController = PullToRefreshController(
        options: PullToRefreshOptions(color: Colors.red),
        onRefresh: () async {
          if (Platform.isAndroid) {
            webViewController!.reload();
          } else if (Platform.isIOS) {
            webViewController!.loadUrl(
                urlRequest: URLRequest(url: await webViewController!.getUrl()));
          }
        },
      );
    } on Exception catch (e) {
      print(e);
    }

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..repeat();
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController)
      ..addListener(() {});

    webViewController?.evaluateJavascript(source: """
    window.navigator.userAgent = 'wp_estore';
    window.flutter_inappwebview.callHandler('test', '.footer-nav-area .alternative-search-options{
    display: none;
}
.search-form form {
    width: 100%;
    max-width: 100%;
    flex: 0 0 calc(100%);
}').then(function(result) {
      console.log(result);
    });
  """);
    webViewController?.injectCSSCode(source: '''
    <style>
        .footer-nav-area .alternative-search-options{
    display: none;
}
.search-form form {
    width: 100%;
    max-width: 100%;
    flex: 0 0 calc(100%);
}
    </style>

    ''');
    print('==$_validURL');
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {

    animationController.dispose();
    webViewController = null;
    super.dispose();
  }


  bool currentThemeIsDark = false;
  getTheme() async {
    List<UserScript> s = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(currentThemeIsDark != pref.getBool("isDarkTheme")!){
      currentThemeIsDark = !currentThemeIsDark;
      webViewController!.reload();
    }
    print("isDarkTheme " + pref.getBool("isDarkTheme")!.toString());
    if(pref.getBool("isDarkTheme")!) {
      s.add(UserScript(source: "document.getElementsByTagName('body')[0].setAttribute('theme-color', 'dark');", injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START));
    }else{
      s.add(UserScript(source: "document.getElementsByTagName('body')[0].setAttribute('theme-color', 'light');", injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START));
    }
    webViewController?.addUserScripts(userScripts: s);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (dragEndDetails) async {
        if (dragEndDetails.primaryVelocity! > 0) {
          if (await webViewController!.canGoBack()) {
            webViewController!.goBack();
          } else {}
        }
      },
      child: WillPopScope(
        onWillPop: () => _exitApp(context),
        child: Stack(
                alignment: AlignmentDirectional.topStart,
                clipBehavior: Clip.hardEdge,
                children: [
                  _validURL
                      ? InAppWebView(
                           initialUrlRequest:
                              URLRequest(url: Uri.parse(widget.url)),
                          pullToRefreshController: _pullToRefreshController,
                          gestureRecognizers: <
                              Factory<OneSequenceGestureRecognizer>>{
                            Factory<OneSequenceGestureRecognizer>(
                                () => EagerGestureRecognizer()),
                          },
                            initialOptions: InAppWebViewGroupOptions(
                              crossPlatform: InAppWebViewOptions(
                                userAgent: 'wp_estore', // Set your desired User Agent here
                              ),
                            ),

                          onWebViewCreated: (controller) async {
                            webViewController = controller;

                            webViewController?.evaluateJavascript(source: '''
                           window.navigator.userAgent = 'wp_estore';
                                ''');
                            await cookieManager.setCookie(
                              url: Uri.parse(widget.url),
                              name: "myCookie",
                              value: "myValue",
                              expiresDate: expiresDate,
                              isHttpOnly: false,
                              isSecure: true,
                            );
                          },

                          onLoadStart: (controller, url) async {
                            setState(() {
                              isLoading = true;
                              showErrorPage = false;
                              slowInternetPage = false;
                            });

                            setState(() {
                              this.url = url.toString();
                            });
                          },
                          onLoadStop: (controller, url) async {
                            _pullToRefreshController.endRefreshing();

                            setState(() {
                              this.url = url.toString();
                              isLoading = false;
                            });
                          },
                          onLoadError: (controller, url, code, message) async {
                            _pullToRefreshController.endRefreshing();
                            print("loadError ${url}");
                            print('---load error----==$code ---$message');
                            setState(() {
                              isLoading = false;
                              if (Platform.isAndroid &&
                                  code == -2 &&
                                  message == 'net::ERR_INTERNET_DISCONNECTED') {
                                noInternet = true;
                                return;
                              }
                              if (Platform.isIOS &&
                                  code == -1009 &&
                                  message ==
                                      'The Internet connection appears to be offline.') {
                                noInternet = true;
                                return;
                              }
                              if (code != 102) {
                                slowInternetPage = true;
                              }
                            });
                          },
                         onLoadHttpError:
                              (controller, url, statusCode, description) {
                            _pullToRefreshController.endRefreshing();
                            print(
                                '---load http error----$description==$statusCode');
                            setState(() {
                              showErrorPage = true;
                              isLoading = false;
                            });
                          },
                          onProgressChanged: (controller, progress) {

                            if (progress == 100) {
                              _pullToRefreshController.endRefreshing();
                              isLoading = false;
                            }
                            setState(() {
                              this.progress = progress / 100;
                            });
                          },
                          shouldOverrideUrlLoading:
                              (controller, navigationAction) async {
                             final orderProvider = Provider.of<OrderProvider>(context, listen: false);
                            orderProvider.OrderListData(context: context, OrderId: widget.OrderId, isShowOrderList: false);
                            return NavigationActionPolicy.ALLOW;
                          },
                          onCloseWindow: (controller) async {
                             },
                          onCreateWindow:
                              (controller, createWindowRequest) async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.width,
                                    child: InAppWebView(
                                      initialUrlRequest:
                                          URLRequest(url: Uri.parse(url)),
                                      windowId: createWindowRequest.windowId,
                                      initialOptions: InAppWebViewGroupOptions(
                                        android: AndroidInAppWebViewOptions(),
                                      ),
                                      onWebViewCreated:
                                          (InAppWebViewController controller) {
                                        webViewController = controller;
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                            return true;
                          },
                         onUpdateVisitedHistory:
                              (controller, url, androidIsReload) async {
                             final orderProvider = Provider.of<OrderProvider>(context, listen: false);
                                orderProvider.OrderListData(context: context, OrderId: widget.OrderId, isShowOrderList: false);

                           },
                          onConsoleMessage: (controller, message) {},
                        )
                      : Center(
                          child: Text(
                          'Url is not valid',
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(height: 0, width: 0),
                  progress < 1.0 && _validURL
                      ? SizeTransition(
                          sizeFactor: animation,
                          axis: Axis.horizontal,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 5.0,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.red,
                                  Colors.yellow,
                                  Colors.white,
                                ],
                                stops: const [0.1, 1.0, 0.1],
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
      ),
    );
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (!_validURL) {
      return Future.value(true);
    }
    if (await webViewController!.canGoBack()) {
      setState(() {
        noInternet = false;
      });
      webViewController!.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';
    var externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = '/storage/emulated/0/Download';
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    path = '$externalStorageDirPath/$uniqueFileName';
    return path;
  }
}
