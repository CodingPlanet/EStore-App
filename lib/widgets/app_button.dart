import 'package:flutter/material.dart';
import '../utils/colors.dart';

Widget button({required String title, required BuildContext context}) {
  var size = MediaQuery.of(context).size;
  return Container(
     height: size.width*0.15,
     margin: EdgeInsets.symmetric(horizontal: size.width*0.02),
    decoration: BoxDecoration(
      color: BUTTON_COLOR,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Center(
        child: Text(
          title,
          overflow: TextOverflow.ellipsis,
          style:TextStyle(
            color: Colors.white,
            fontSize: size.width*0.045,
            fontWeight: FontWeight.bold
          ),
        )),
  );
}


Widget buttonWithoutColor(String title, context) {
  var size = MediaQuery.of(context).size;
  return Container(
    height: size.width*0.15,
    margin: EdgeInsets.symmetric(horizontal: size.width*0.02),
    decoration: BoxDecoration(
      border: Border.all(
        color: BUTTON_COLOR,
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Center(
        child: Text(
          title,
          overflow: TextOverflow.ellipsis,
          style:TextStyle(
              color: TEXT_COLOR,
              fontSize: size.width*0.045,
              fontWeight: FontWeight.bold
          ),
        )),
  );
}




