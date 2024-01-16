import 'package:ecom/provider/connectivity_provider.dart';
import 'package:ecom/screen/connectivity_screen.dart';
import 'package:ecom/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/colors.dart';
import '../../widgets/appbar_title.dart';

// ignore: must_be_immutable
class AboutUsScreen extends StatefulWidget {
  String Title;
  AboutUsScreen({required this.Title});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBarTitle().appbar(setState, context, widget.Title==ABOUT_US?ABOUT_US:widget.Title==PRIVACY_POLICY?PRIVACY_POLICY:TERM_CONDITION,true),
      body:  !context.read<ConnectivityProvider>().isConnected?connectivityData(context: context,OnTap: (){

        context.read<ConnectivityProvider>().checkConnection();
      }): SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: size.width*0.02, vertical: size.height*0.01),
          child: Text(widget.Title==ABOUT_US? ABOUT_US_TEXT:widget.Title==PRIVACY_POLICY?PRIVACY_POLICY_TEXT:TERM_CONDITION_TEXT,style: TextStyle(
            color: TEXT_COLOR,
            fontSize: size.width*0.040,
            fontWeight: FontWeight.w400
          ),),
        ),
      ),
    );
  }
}
