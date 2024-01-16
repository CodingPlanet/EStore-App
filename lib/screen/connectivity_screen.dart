import 'package:ecom/utils/string.dart';
import 'package:ecom/widgets/app_button.dart';
import 'package:flutter/material.dart';

connectivityData({required BuildContext context,required Function() OnTap}){
  var size = MediaQuery.of(context).size;
  return Container(
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: size.width*0.70,
          width: size.width*0.70,
          child: Image.asset("Images/noDataFound.png") ,
        ),

        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: size.width*0.07),
          child: Text(CONNECTION_SCREEN_MSG,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: size.height*0.025
          ),
          ),
        ),
        SizedBox(height: size.height*0.09 ,),
        GestureDetector(
          onTap: OnTap,
          child: Container(
            height: size.height*0.12,
            padding: EdgeInsets.symmetric(horizontal: size.width*0.20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Center(child: button(title: CONNECTION_BUTTON_TEXT, context: context )),
          ),
        ),
      ],
    ),
  );
}
