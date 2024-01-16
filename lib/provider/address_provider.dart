import 'dart:convert';
import 'package:ecom/provider/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data_provider/api_parameter.dart';
import '../services/address_service.dart';
import '../utils/shared_preferences_string.dart';

String? billingFirstName;
String? billingLastName;
String? billingCompanyName;
String? billingAddress1;
String? billingAddress2;
String? billingCity;
String? billingPostalCode;
String? billingCountrys;
String? billingState;
String? billingPhone;
String? billingEmail;


String? shippingFirstName;
String? shippingLastName;
String? shippingCompanyName;
String? shippingAddress1;
String? shippingAddress2;
String? shippingCity;
String? shippingPostalCode;
String? shippingCountrys;
String? shippingState;
String? shippingPhone;
String? shippingEmail;

class AddressProvider with ChangeNotifier {

  String? customerBillingFirstName =billingFirstName;
  String? customerBillingLastName=billingLastName;
  String? customerBillingCompanyName=billingCompanyName;
  String? customerBillingAddress1=billingAddress1;
  String? customerBillingAddress2=billingAddress2;
  String? customerBillingCity=billingCity;
  String? customerBillingPostalCode=billingPostalCode;
  String? customerBillingCountry=billingCountrys;
  String? customerBillingState=billingState;
  String? customerBillingPhone=billingPhone;
  String? customerBillingEmail=billingEmail;

  String? customerShippingFirstName=shippingFirstName;
  String? customerShippingLastName=shippingLastName;
  String? customerShippingCompanyName=shippingCompanyName;
  String? customerShippingAddress1=shippingAddress1;
  String? customerShippingAddress2=shippingAddress2;
  String? customerShippingCity=shippingCity;
  String? customerShippingPostalCode=shippingPostalCode;
  String? customerShippingCountry=shippingCountrys;
  String? customerShippingState=shippingState;
  String? customerShippingPhone=shippingPhone;
  String? customerShippingEmail=shippingEmail;

  TextEditingController billingFirstNameController =  TextEditingController(text: billingFirstName);
  TextEditingController billingLastNameController = new TextEditingController(text: billingLastName );
  TextEditingController billingCompanyController = new TextEditingController(text: billingCompanyName);
  TextEditingController billingAddress1AddressController = new TextEditingController(text: billingAddress1);
  TextEditingController billingAddress2AddressController = new TextEditingController(text: billingAddress2);
  TextEditingController billingCityController = new TextEditingController(text: billingCity);
  TextEditingController billingPostalCodeController = new TextEditingController(text: billingPostalCode);
  TextEditingController billingStateController = new TextEditingController(text: billingState);
  TextEditingController billingPhoneController = new TextEditingController(text: billingPhone);
  TextEditingController billingEmailController = new TextEditingController(text: billingEmail);

  TextEditingController shippingFirstNameController = new TextEditingController(text: shippingFirstName);
  TextEditingController shippingLastNameController = new TextEditingController(text: shippingLastName);
  TextEditingController shippingCompanyController = new TextEditingController(text: shippingCompanyName);
  TextEditingController shippingAddress1AddressController = new TextEditingController(text: shippingAddress1);
  TextEditingController shippingAddress2AddressController = new TextEditingController(text: shippingAddress2);
  TextEditingController shippingCityController = new TextEditingController(text: shippingCity);
  TextEditingController shippingPostalCodeController = new TextEditingController(text: shippingPostalCode);
  TextEditingController shippingStateController = new TextEditingController(text: shippingState);
  TextEditingController shippingPhoneController = new TextEditingController(text: shippingPhone);
  TextEditingController shippingEmailController = new TextEditingController(text: shippingEmail);
  bool isCheckedBillingAddress = false;
  bool isApiLoading=false;
  String? billingCountry;
  String? shippingCountry;

  UpdateAddress({required BuildContext context, required bool isChecked })async{
    isApiLoading=true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString(SHARED_PREFERENCES_EMAIL);
    String? password = prefs.getString(PASSWORD1);

    var Body={
      USER_NAME: "${email}",
      PASS_WORD: "${password}",
      BILLING_FIRST_NAME: "${billingFirstNameController.text}",
      BILLING_LAST_NAME: "${billingLastNameController.text}",
      BILLING_COMPANY: "${billingCompanyController.text}",
      BILLING_ADDRESS_1: "${billingAddress1AddressController.text}",
      BILLING_ADDRESS_2: "${billingAddress2AddressController.text}",
      BILLING_CITY: "${billingCityController.text}",
      BILLING_POSTCODE: "${billingPostalCodeController.text}",
      BILLING_COUNTRY: "${billingCountry}",
      BILLING_STATE: "${billingStateController.text}",
      BILLING_PHONE: "${billingPhoneController.text}",
      BILLING_EMAIL: "${billingEmailController.text}",

      SHIPPING_FIRST_NAME: "${shippingFirstNameController.text}",
      SHIPPING_LAST_NAME: "${shippingLastNameController.text}",
      SHIPPING_COMPANY: "${shippingCompanyController.text}",
      SHIPPING_ADDRESS_1: "${shippingAddress1AddressController.text}",
      SHIPPING_ADDRESS_2: "${shippingAddress2AddressController.text}",
      SHIPPING_CITY: "${shippingCityController.text}",
      SHIPPING_POSTCODE: "${shippingPostalCodeController.text}",
      SHIPPING_COUNTRY: "${shippingCountry}",
      SHIPPING_STATE: "${shippingStateController.text}",
      SHIPPING_PHONE: "${shippingPhoneController.text}",
      SHIPPING_EMAIL: "${shippingEmailController.text}",
    };
    var Bodys={
      USER_NAME: "${email}",
      PASS_WORD: "${password}",
      BILLING_FIRST_NAME: "${billingFirstNameController.text}",
      BILLING_LAST_NAME: "${billingLastNameController.text}",
      BILLING_COMPANY: "${billingCompanyController.text}",
      BILLING_ADDRESS_1: "${billingAddress1AddressController.text}",
      BILLING_ADDRESS_2: "${billingAddress2AddressController.text}",
      BILLING_CITY: "${billingCityController.text}",
      BILLING_POSTCODE: "${billingPostalCodeController.text}",
      BILLING_COUNTRY: "${billingCountry}",
      BILLING_STATE: "${billingStateController.text}",
      BILLING_PHONE: "${billingPhoneController.text}",
      BILLING_EMAIL: "${billingEmailController.text}",

      SHIPPING_FIRST_NAME: "${billingFirstNameController.text}",
      SHIPPING_LAST_NAME: "${billingLastNameController.text}",
      SHIPPING_COMPANY: "${billingCompanyController.text}",
      SHIPPING_ADDRESS_1: "${billingAddress1AddressController.text}",
      SHIPPING_ADDRESS_2: "${billingAddress2AddressController.text}",
      SHIPPING_CITY: "${billingCityController.text}",
      SHIPPING_POSTCODE: "${billingPostalCodeController.text}",
      SHIPPING_COUNTRY: "${billingCountry}",
      SHIPPING_STATE: "${billingStateController.text}",
      SHIPPING_PHONE: "${billingPhoneController.text}",
      SHIPPING_EMAIL: "${billingEmailController.text}",
    };

    Response response = await AddressService().UpdateAddressData(context: context, body: isChecked?Bodys:Body);

    if (response.statusCode == 200) {
      var responseJson = jsonDecode(response.body);
      if(responseJson[ERROR]){
        isApiLoading=false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseJson[MESSAGE])));
        notifyListeners();
      }else{
        isApiLoading=false;
        context.read<AuthenticationProvider>().loginUser(context: context,isUpdateAddress: true);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseJson[MESSAGE])));
        notifyListeners();
      }
    } else {
      return response;
    }
    notifyListeners();
  }
}
