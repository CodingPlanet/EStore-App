import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/customer/customerBillingModel.dart';
import '../model/customer/customerCreateModel.dart';
import '../model/customer/customerShippingModel.dart';
import '../utils/shared_preferences_string.dart';


class CustomerProvider with ChangeNotifier {
  late CreateCustomer createCustomer;
  bool isLoading = false;
  String emails='';
  String userName='';

  getCustomerDetailsPref() async{

    isLoading= true;
     SharedPreferences prefs = await SharedPreferences.getInstance();
    String createCustomerPref= prefs.getString(CUSTOMERDETAILS) ?? json.encode( CreateCustomer(
        "",
        "",
        "",
        "",
        "",
        Billing("", "", "", "", "", "", "", "", "", "", ""),
        Shipping("", "", "", "", "", "", "", "", "")
    ).toJson());
    var responseJson = json.decode(createCustomerPref);
    createCustomer=CreateCustomer.fromJson(responseJson);
    isLoading= false;
    notifyListeners();
  }

    getCustomerData(){
     // Future.delayed( Duration(seconds: 1), () async{
       emails=createCustomer.billing.email =createCustomer.email;
      String firstName =createCustomer.billing.first_name =createCustomer.first_name;
      String lastName =createCustomer.billing.last_name =createCustomer.last_name;
      userName= firstName +lastName;
      notifyListeners();

    // });
  }

    setCustomerDetailsPref(CreateCustomer createCustomer) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: unnecessary_null_comparison
    if(createCustomer==null)
      {
        prefs.remove(CUSTOMERDETAILS );
        notifyListeners();
      } else{
      prefs.setString(CUSTOMERDETAILS,json.encode(createCustomer.toJson()) );
      notifyListeners();
    }

  }
}
