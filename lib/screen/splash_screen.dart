import 'dart:async';
import 'package:animations/animations.dart';
import 'package:ecom/provider/authentication_provider.dart';
import 'package:ecom/provider/connectivity_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/dashboard/getDashboardCategory.dart';
import '../model/dashboard/getDashboardProducts.dart';
import '../provider/dashboard_provider.dart';
import '../utils/dashBoardBloc.dart';
import '../utils/paginator.dart';
import '../utils/shared_preferences_string.dart';
import 'dashboard/home_screen.dart';

class MyCustomWidget extends StatefulWidget {
  @override
  _MyCustomWidgetState createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Suppose this is an app in your Phone\'s Screen page.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            OpenContainer(
              closedBuilder: (_, openContainer) {
                return Container(
                  height: 80,
                  width: 80,
                  child: Center(
                    child: Text(
                      'App Logo',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                );
              },
              openColor: Colors.white,
              closedElevation: 20,
              closedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              transitionDuration: Duration(milliseconds: 700),
              openBuilder: (_, closeContainer) {
                return splashScreen();
              },
            ),
          ],
        ),
      ),
    );
  }
}

 List<GetDashBoardProducts> featured_products=[];
 List<GetDashBoardProducts> top_selling_products=[];
  List<GetDashBoardProducts> totalProducts=[];
 List<GetDashboardCategories>? totalCategories;

String currencyCode="";
SharedPreferences? prefs;

class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  bool _a = false;
  String? emailNameText;
  String? passwordText;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 700), () {
      setState(() {
        _a = !_a;
      });
    });
    getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  getData()async{


    final prefs = await SharedPreferences.getInstance();
    emailNameText = await prefs.getString(SHARED_PREFERENCES_EMAIL);
    passwordText =  prefs.getString(PASSWORD1);
    nextData();

  }
  nextData(){
    Timer(Duration(milliseconds: 2000), () {
      context.read<ConnectivityProvider>().checkConnection();
      final dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
      dashboardProvider.getDashboard(dashboard_page, context)
          .then((value) {
        if (value != null) {
          refreshNewDashboardData(value);
          dashboardBloc.refreshDashboards(true);
        }
      });
      dashboardProvider.getCategory(context);
      dashboardProvider.getSlider(context);
      if(emailName !="" || emailName !="null" || emailName !=null && passwordText!="" || passwordText!="null" || passwordText !=null ){
        context.read<AuthenticationProvider>().loginUser(context: context,isUpdateAddress: true);
      }else{
        print("NullValue::");
      }
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushReplacement(SlideTransitionAnimation(HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width + 10;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 2500),
            curve: Curves.fastLinearToSlowEaseIn,
            width: _a ? _width : 0,
            height: _height,
            color: Colors.white,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('Images/logo.gif'),
                Align(
                  child: Text(
                    'eStore',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  'Woocommerce Flutter Application',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SlideTransitionAnimation extends PageRouteBuilder {
  final Widget page;

  SlideTransitionAnimation(this.page)
      : super(
            pageBuilder: (context, animation, anotherAnimation) => page,
            transitionDuration: Duration(milliseconds: 2000),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
              );
              return SlideTransition(
                position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                    .animate(animation),
                textDirection: TextDirection.rtl,
                child: page,
              );
            }
      );
}
