import 'dart:io';
import 'package:ecom/screen/order/all_order_screen.dart';
import 'package:ecom/screen/profile/about_us_screen.dart';
import 'package:ecom/screen/profile/update_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../provider/address_provider.dart';
import '../../provider/authentication_provider.dart';
import '../../utils/colors.dart';
import '../../utils/shared_preferences_string.dart';
import '../../utils/string.dart';
import '../../widgets/appbar_title.dart';
import '../authentication/login_screen.dart';
import 'change_password_screen.dart';
import 'package:share_plus/share_plus.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  TextEditingController userNameController =  TextEditingController();
  TextEditingController emailController =  TextEditingController();
  String name="";
  bool isClearData = false;
  String? emailText;

  @override
  void initState() {
    // TODO: implement initState

    getData();
    super.initState();
  }

  getData()async{
    final prefs = await SharedPreferences.getInstance();
    emailText = await prefs.getString(SHARED_PREFERENCES_EMAIL);
  }

  clearData()async{

    isClearData=true;
    final prefs = await SharedPreferences.getInstance();

    prefs.clear();

    setState(() {
      billingFirstName="";
      billingLastName="";
      billingCompanyName="";
      billingAddress1="";
      billingAddress2="";
      billingCity="";
      billingPostalCode="";
      billingCountrys="";
      billingState="";
      billingPhone="";
      billingEmail="";
      shippingFirstName="";
      shippingLastName="";
      shippingCompanyName="";
      shippingAddress1="";
      shippingAddress2="";
      shippingCity="";
      shippingPostalCode="";
      shippingCountrys="";
      shippingState="";
      shippingPhone="";
      shippingEmail="";
      isClearData=false;
    });




  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Scaffold(
            appBar: AppBarTitle().appbar(setState, context, PROFILE,false),
            backgroundColor: BACKGROUND_COLOR,
            body: SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            SizedBox(height: size.height*0.02,),
                            Container(
                              height: size.width*0.30,
                              width: size.width*0.30,
                              child: Image.asset("Images/profile.png") ,
                            ),
                            SizedBox(height: size.height*0.04,)
                          ],
                        ),
                      ),
                      Divider(),
                      emailName==null ? Container():
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (builder) => UpdateAddressScreen()));
                            },
                            child:  Container(
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: size.width*0.12,
                                        width: size.width*0.12,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle, color: ICON_BACKGROUND_COLOR),
                                        child: Center(
                                          child: Icon(
                                            Icons.person_outline_sharp,
                                            color: ICON_COLOR,
                                            size: size.width*0.070,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: size.width*0.07,),
                                      Container(
                                        child: Text(
                                          UPDATE_ADDRESS,
                                          style: TextStyle(
                                              color: TITLE_COLOR,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.chevron_right_rounded,color: ICON_COLOR,),
                                ],
                              ),
                            ),

                          ),
                          Divider(),
                        ],
                      ),

                      emailName==null? Container():
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (builder) => AllOrderScreen()));
                            },
                            child:  Container(
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: size.width*0.12,
                                        width: size.width*0.12,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle, color: ICON_BACKGROUND_COLOR),
                                        child: Center(
                                          child: Icon(
                                            Icons.shopping_cart_outlined,
                                            color: ICON_COLOR,
                                            size: size.width*0.070,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: size.width*0.07,),
                                      Container(
                                        child: Text(
                                          ORDERS_LIST,
                                          style: TextStyle(
                                              color: TITLE_COLOR,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.chevron_right_rounded,color: ICON_COLOR,),
                                ],
                              ),
                            ),

                          ),
                          Divider(),
                        ],
                      ),
                      emailName==null? Container():
                      Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (builder) => ChangePasswordScreen()));
                            },
                            child:Container(
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: size.width*0.12,
                                        width: size.width*0.12,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle, color: ICON_BACKGROUND_COLOR),
                                        child: Center(
                                          child: Icon(
                                            Icons.lock_open,
                                            color: ICON_COLOR,
                                            size: size.width*0.070,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: size.width*0.07,),
                                      Container(
                                        child: Text(
                                          CHANGE_PASSWORD,
                                          style: TextStyle(
                                              color: TITLE_COLOR,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.chevron_right_rounded,color: ICON_COLOR,),
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                        ],
                      ),

                      GestureDetector(
                        onTap: (){
                          print("click:::::");
                          Navigator.of(context).push(MaterialPageRoute(builder: (builder) => AboutUsScreen(Title: ABOUT_US,)));
                        },
                        child:Container(
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: size.width*0.12,
                                    width: size.width*0.12,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: ICON_BACKGROUND_COLOR),
                                    child: Center(
                                      child: Icon(
                                        Icons.info_outline,
                                        color: ICON_COLOR,
                                        size: size.width*0.070,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: size.width*0.07,),
                                  Text(
                                    ABOUT_US,
                                    style: TextStyle(
                                        color: TITLE_COLOR,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15
                                    ),
                                  ),
                                ],
                              ),
                              Icon(Icons.chevron_right_rounded,color: ICON_COLOR,),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (builder) => AboutUsScreen(Title: PRIVACY_POLICY,)));
                        },
                        child:Container(
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: size.width*0.12,
                                    width: size.width*0.12,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: ICON_BACKGROUND_COLOR),
                                    child: Center(
                                      child: Icon(
                                        Icons.file_copy_outlined,
                                        color: ICON_COLOR,
                                        size: size.width*0.070,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: size.width*0.07,),
                                  Container(
                                    child: Text(
                                      PRIVACY_POLICY,
                                      style: TextStyle(
                                          color: TITLE_COLOR,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Icon(Icons.chevron_right_rounded,color: ICON_COLOR,),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (builder) => AboutUsScreen(Title: TERM_CONDITION,)));
                        },
                        child:Container(
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: size.width*0.12,
                                    width: size.width*0.12,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: ICON_BACKGROUND_COLOR),
                                    child: Center(
                                      child: Icon(
                                        Icons.note_alt_outlined,
                                        color: ICON_COLOR,
                                        size: size.width*0.070,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: size.width*0.07,),
                                  Container(
                                    child: Text(
                                      TERM_CONDITION,
                                      style: TextStyle(
                                          color: TITLE_COLOR,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Icon(Icons.chevron_right_rounded,color: ICON_COLOR,),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      GestureDetector(
                        onTap: (){
                          Share.share(Platform.isAndroid?'https://play.google.com/store/apps/details?id=com.estore':'https://apps.apple.com/app/[your-app-name]/id[app-id]', subject: APP_NAME);
                        },
                        child:Container(
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: size.width*0.12,
                                    width: size.width*0.12,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: ICON_BACKGROUND_COLOR),
                                    child: Center(
                                      child: Icon(
                                        Icons.share_outlined,
                                        color: ICON_COLOR,
                                        size: size.width*0.070,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: size.width*0.07,),
                                  Container(
                                    child: Text(
                                      SHARE,
                                      style: TextStyle(
                                          color: TITLE_COLOR,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Icon(Icons.chevron_right_rounded,color: ICON_COLOR,),
                            ],
                          ),
                        ),
                      ),
                      Divider(),

                      GestureDetector(
                        onTap: () async{
                          emailName==null? Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen() )):
                          showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(LOGOUT_MSG ),
                                actions: [
                                  isClearData?CircularProgressIndicator(): GestureDetector(
                                    onTap: ()async {
                                      clearData();
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginScreen()), (route) => false);
                                    },
                                    child: Text(YES ),
                                  ),
                                  SizedBox(width: 10,),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context, false);
                                    },
                                    child: Text(NO),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child:Container(
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: size.width*0.12,
                                    width: size.width*0.12,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: ICON_BACKGROUND_COLOR),
                                    child: Center(
                                      child: Icon(
                                        Icons.login_outlined,
                                        color: ICON_COLOR,
                                        size: size.width*0.070,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: size.width*0.07,),
                                  Container(
                                    child: Text(
                                      emailName==null?LOGIN:LOGOUT,
                                      style: TextStyle(
                                          color: TITLE_COLOR,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Icon(Icons.chevron_right_rounded, color: ICON_COLOR,),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  )),
            ),
          );
        });

  }
}
