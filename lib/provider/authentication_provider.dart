import 'dart:convert';
import 'package:ecom/screen/authentication/login_screen.dart';
import 'package:ecom/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data_provider/api_parameter.dart';
import '../screen/dashboard/home_screen.dart';
import '../services/authentication_service.dart';
import '../utils/shared_preferences_string.dart';
import 'address_provider.dart';

String? emailName ;
class AuthenticationProvider with ChangeNotifier {

  bool isApiLoading = false;
  bool obscureTexts = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isNetworkAvail = true;
  TextEditingController firstNameRegisterController = TextEditingController();
  TextEditingController lastNameRegisterController = TextEditingController();
  TextEditingController userNameRegisterController = TextEditingController();
  TextEditingController emailRegisterController = TextEditingController();
  TextEditingController passwordRegisterController = TextEditingController();
  TextEditingController emailForgotPasswordController = TextEditingController();
  String msg="";
  String? password;

  loginUser({required BuildContext context,required bool isUpdateAddress}) async {
    isApiLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String? passwords =  prefs.getString(PASSWORD1);
    String? email =  prefs.getString(EMAILS);


    var bodys = {
        USER_NAME: "${email}",
        PASS_WORD: "${passwords}",
      };
      var body = {
        USER_NAME: "${emailController.text}",
        PASS_WORD: "${passwordController.text}",
      };

      Response response = await AuthenticationService().loginData(body: isUpdateAddress?bodys:body);


     final loginModel = jsonDecode(response.body);
    print("loginApi:: ${response.statusCode} ${loginModel[ERROR]}");
    if (response.statusCode == 200) {
      if(loginModel[ERROR]){
        isApiLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(loginModel[MESSAGE])));
      }else{

        if(!isUpdateAddress){
          await prefs.setString(SHARED_PREFERENCES_EMAIL,loginModel[DATA][USER_LOGIN]);
          await prefs.setString(USERID,loginModel[DATA][IDS]);
          await prefs.setString(PASSWORD1, passwordController.text);
           password =  prefs.getString(PASSWORD1);
        }

        emailName= await  prefs.getString(SHARED_PREFERENCES_EMAIL);


        billingFirstName= loginModel[DATA][BILLING_FIRST_NAME];
        billingLastName=loginModel[DATA][BILLING_LAST_NAME];
        billingCompanyName=loginModel[DATA][BILLING_COMPANY];
        billingAddress1=loginModel[DATA][BILLING_ADDRESS_1];
        billingAddress2=loginModel[DATA][BILLING_ADDRESS_2];
        billingCity=loginModel[DATA][BILLING_CITY];
        billingPostalCode=loginModel[DATA][BILLING_POSTCODE];
        billingCountrys=loginModel[DATA][BILLING_COUNTRY];
        billingState=loginModel[DATA][BILLING_STATE];
        billingPhone=loginModel[DATA][BILLING_PHONE];
        billingEmail=loginModel[DATA][BILLING_EMAIL];

        shippingFirstName=loginModel[DATA][SHIPPING_FIRST_NAME];
        shippingLastName=loginModel[DATA][SHIPPING_LAST_NAME];
        shippingCompanyName=loginModel[DATA][SHIPPING_COMPANY];
        shippingAddress1=loginModel[DATA][SHIPPING_ADDRESS_1];
        shippingAddress2=loginModel[DATA][SHIPPING_ADDRESS_2];
        shippingCity=loginModel[DATA][SHIPPING_CITY];
        shippingPostalCode=loginModel[DATA][SHIPPING_POSTCODE];
        shippingCountrys=loginModel[DATA][SHIPPING_COUNTRY];
        shippingState=loginModel[DATA][SHIPPING_STATE];
        shippingPhone=loginModel[DATA][SHIPPING_PHONE];
        shippingEmail=loginModel[DATA][SHIPPING_EMAIL];

        if(isUpdateAddress){

        }else{

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(loginModel[MESSAGE])));
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
        }
      }
      isApiLoading = false;
    }
    else {
      isApiLoading = false;
      return response.body;
    }
    isApiLoading = false;
    notifyListeners();
  }

  registerUser({required BuildContext context,  required StateSetter setState}) async {
    isApiLoading = true;
    final prefs = await SharedPreferences.getInstance();
    var body = {
      EMAILS: "${emailRegisterController.text}",
      PASS_WORD: "${passwordRegisterController.text}",
    };

    Response response = await AuthenticationService().registerData(body: body);
    if (response.statusCode == 200) {
      final registerModel = jsonDecode(response.body);
      if(registerModel[ERROR]){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(registerModel[MESSAGE])));
      }else{
        await prefs.setString(SHARED_PREFERENCES_EMAIL,registerModel[DATA][USER_EMAIL]);
        await prefs.setString(PASSWORD1, passwordController.text);
        await prefs.setString(F_NAME,firstNameRegisterController.text);
        await prefs.setString(L_NAME,lastNameRegisterController.text);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(registerModel[MESSAGE])));
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
      }
      isApiLoading = false;
    }
    else {
      isApiLoading = false;
      return response.body;
    }
    isApiLoading = false;
    notifyListeners();
  }

  forgotPasswordData({required BuildContext context,  required StateSetter setState}) async {
    isApiLoading = true;
    var body = {
      EMAILS: "${emailForgotPasswordController.text}",
    };

    Response response = await AuthenticationService().forgotPassword(body: body);
    if (response.statusCode == 200) {

      final forgotPasswordModel = jsonDecode(response.body);
      if(forgotPasswordModel[ERROR]){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(forgotPasswordModel[MESSAGE])));
      }else{
        showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(forgotPasswordModel[MESSAGE] ,),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: ()async {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginScreen() ), (route) => false);
                    },
                  child: Text("Yes" ,),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text("No",),
                ),
              ],
            );
          },
        );
      }
      isApiLoading = false;
    }
    else {
      isApiLoading = false;
      return response.body;
    }
    isApiLoading = false;
    notifyListeners();
  }

  snackBarConnection(BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(INTERNET_CONNECTIVITY_MSG)));
       isApiLoading=false;
       notifyListeners();
  }
}
