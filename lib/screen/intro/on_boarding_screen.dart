import 'package:flutter/material.dart';
import 'introduction.dart';
import 'intro_screen_on_boarding.dart';
import '../splash_screen.dart';

class onBoardingScreen extends StatefulWidget {
  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  final List<Introduction> list = [
    Introduction(
      title: 'Select product',
      subTitle: 'Browse from more than 1 million products',
      imageUrl: 'Images/searchproduct.gif',
    ),
    Introduction(
      title: 'Add to cart',
      subTitle: 'Add the product you want to buy to the cart',
      imageUrl: 'Images/addtocart.gif',
    ),
    Introduction(
      title: 'Payment',
      subTitle: 'Make payment from multiple available options',
      imageUrl: 'Images/payment.gif',
    ),
    Introduction(
      title: 'Track',
      subTitle: 'Track your product with unique tracking id',
      imageUrl: 'Images/track.gif',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return IntroScreenOnBoarding(
      backgroudColor: Colors.white,
      introductionList: list,
      onTapSkipButton: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => splashScreen(),
          ),
        );
      },
    );
  }
}
