import 'package:shared_preferences/shared_preferences.dart';

final String? userLogin = "user";
final String? token = "token";
final String? totalQuantity = "quantity";
String dark = "Dark";

final String CARTPRODUCTS="cardProducts";
final String WISHLIST="Wishlist";
final String CUSTOMERDETAILS="customerDetails";
final String SHARED_PREFERENCES_EMAIL="email";
final String USERID="userid";
final String EMAIL_Text="emailName";
final String PASSWORD1="password";
final String F_NAME="firstName";
final String L_NAME="lastName";
final String isShowIntro="sliders";

setPreferences(String key, String value) async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.setString(key, value);
}

Future<String> getPreferences(String key) async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   return prefs.getString(key)?? "";
}

setPreferencesInt(String key, int value) async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.setInt(key, value);
}

getPreferencesInt(String key) async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   return prefs.getInt(key) ?? 0;
}

setPreferencesBool(String key, bool value) async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.setBool(key, value);
}

Future<bool> getPreferencesBool(String key) async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   return prefs.getBool(key) ?? false;
}

