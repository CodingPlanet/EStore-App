import 'package:flutter/material.dart';
import '../utils/colors.dart';

class AppBarTitle{
  appbar(StateSetter  setState ,BuildContext context , String title, bool isArrowShow){
    var size = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor:APP_BAR_COLOR,
      automaticallyImplyLeading: false,
      leadingWidth: 0,
       title: Row(
         children: [
           isArrowShow? Column(
             children: [
               GestureDetector(
                   onTap: () {
                     setState(() {
                       Navigator.pop(context);
                     });
                   },
                   child: Container(
                     child: Icon(
                       Icons.arrow_back,
                       color: ICON_COLOR,
                       size: size.width*0.055,
                     ),
                   )
               ),
               SizedBox(width: size.width*0.04,),
             ],
           ):Container(),

           Container(
             margin: EdgeInsets.symmetric(horizontal: size.width*0.02),
             child: Text(
               title,
               style: TextStyle(
                   fontSize: 18,
                   color:APPBAR_TEXT_COLOR,
                   fontWeight: FontWeight.bold
               ),
             ),
           ),
         ],
       ),
    );
  }
}