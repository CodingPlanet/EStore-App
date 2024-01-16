import 'dart:convert';
import 'package:ecom/services/change_password_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data_provider/api_parameter.dart';
import '../utils/shared_preferences_string.dart';
import '../utils/string.dart';


class ChangePasswordProvider with ChangeNotifier {

  bool isApiLoading = false;
  bool isHidden=true;
  bool isHidden1=true;
  bool isHidden2=true;
  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController NewPasswordController = new TextEditingController();
  TextEditingController ConfirmPassWordController = new TextEditingController();


  changePasswordData(BuildContext context)async{
    isApiLoading=true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    String? email = await prefs.getString(SHARED_PREFERENCES_EMAIL);
    var body={
      EMAILS:"${email}",
      PASS_WORD: "${oldPasswordController.text}",
      NEW_PASSWORD:"${NewPasswordController.text}"
    };
    Response response = await ChangePasswordService().changePassword(context: context, body: body);

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      if(responseJson[ERROR]){
        isApiLoading=false;
        showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(responseJson[MESSAGE] ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text("Ok"),
                ),
              ],
            );
          },
        );
      }else{
        isApiLoading=false;
        await prefs.setString(PASSWORD1, NewPasswordController.text);
        Navigator.pop(context, false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseJson[MESSAGE])));
        oldPasswordController.text="";
        NewPasswordController.text="";
        ConfirmPassWordController.text="";
        notifyListeners();
      }
    } else {
      return response;
    }
    notifyListeners();
  }

  validateConfirmPassword(String value,BuildContext context) {
    if (value.isEmpty) {
      return CONFIRM_PASSWORD_VALIDATION_TEXT;
    }
    if (value != NewPasswordController.text) {
      return PASSWORD_DO_NOT_MATCH_VALIDATION_TEXT;
    }
    notifyListeners();
    return null;
  }
}
