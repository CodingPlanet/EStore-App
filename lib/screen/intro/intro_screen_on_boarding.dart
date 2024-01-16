import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/shared_preferences_string.dart';
import 'circle_progress_bar.dart';
import 'introduction.dart';

class IntroScreenOnBoarding extends StatefulWidget {
  final List<Introduction>? introductionList;
  final Color? backgroudColor;
  final Color? foregroundColor;
  final TextStyle? skipTextStyle;
  final Function()? onTapSkipButton;
  IntroScreenOnBoarding({
    Key? key,
    this.introductionList,
    this.onTapSkipButton,
    this.backgroudColor,
    this.foregroundColor,
    this.skipTextStyle = const TextStyle(fontSize: 20),
  }) : super(key: key);

  @override
  _IntroScreenOnBoardingState createState() => _IntroScreenOnBoardingState();
}

class _IntroScreenOnBoardingState extends State<IntroScreenOnBoarding> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  double progressPercent = 0;
  bool isIntroSlider = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          color: widget.backgroudColor ,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Container(
                //       alignment: Alignment.topRight,
                //       child: TextButton(
                //         onPressed: widget.onTapSkipButton,
                //         child: Text('Skip', style: widget.skipTextStyle),
                //       ),
                //     ),
                //   ],
                // ),
                Expanded(
                  child: Container(
                    height: 550.0,
                    child: PageView(
                      physics: ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: widget.introductionList!,
                    ),
                  ),
                ),
                _customProgress(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _customProgress() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          child: CircleProgressBar(
            backgroundColor: Colors.white,
            foregroundColor:
            widget.foregroundColor ?? Theme.of(context).primaryColor,
            value: ((_currentPage + 1) * 1.0 / widget.introductionList!.length),
          ),
        ),
        Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (widget.foregroundColor ?? Theme.of(context).primaryColor)
                .withOpacity(0.5),
          ),
          child: IconButton(
            onPressed: () async{
              print("_currentPage ${_currentPage}");

              _currentPage != widget.introductionList!.length - 1
                  ? _pageController.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
              )
                  : widget.onTapSkipButton!();
              if(_currentPage==3){
                isIntroSlider = true;
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool(isShowIntro, isIntroSlider);
                final bool? showIntro = prefs.getBool(isShowIntro);
                print("showIntro:: ${showIntro}");
              }
            },
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            iconSize: 15,
          ),
        )
      ],
    );
  }
}