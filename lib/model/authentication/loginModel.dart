// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool error;
  String message;
  Data data;

  LoginModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    error: json["error"],
    message: json["message"],
    data: Data.fromJson(json["data"] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String id;
  String userLogin;
  String userNicename;
  String userEmail;
  String userUrl;
  DateTime userRegistered;
  String userActivationKey;
  String userStatus;
  String displayName;
  String billingFirstName;
  String billingLastName;
  String billingCompany;
  String billingAddress1;
  String billingAddress2;
  String billingCity;
  String billingPostcode;
  String billingCountry;
  String billingState;
  String billingPhone;
  String billingEmail;
  String shippingFirstName;
  String shippingLastName;
  String shippingCompany;
  String shippingAddress1;
  String shippingAddress2;
  String shippingCity;
  String shippingPostcode;
  String shippingCountry;
  String shippingState;
  String shippingPhone;
  String shippingEmail;

  Data({
    required this.id,
    required this.userLogin,
    required this.userNicename,
    required this.userEmail,
    required this.userUrl,
    required this.userRegistered,
    required this.userActivationKey,
    required this.userStatus,
    required this.displayName,
    required this.billingFirstName,
    required this.billingLastName,
    required this.billingCompany,
    required this.billingAddress1,
    required this.billingAddress2,
    required this.billingCity,
    required this.billingPostcode,
    required this.billingCountry,
    required this.billingState,
    required this.billingPhone,
    required this.billingEmail,
    required this.shippingFirstName,
    required this.shippingLastName,
    required this.shippingCompany,
    required this.shippingAddress1,
    required this.shippingAddress2,
    required this.shippingCity,
    required this.shippingPostcode,
    required this.shippingCountry,
    required this.shippingState,
    required this.shippingPhone,
    required this.shippingEmail,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["ID"],
    userLogin: json["user_login"],
    userNicename: json["user_nicename"],
    userEmail: json["user_email"],
    userUrl: json["user_url"],
    userRegistered: DateTime.parse(json["user_registered"]),
    userActivationKey: json["user_activation_key"],
    userStatus: json["user_status"],
    displayName: json["display_name"],
    billingFirstName: json["billing_first_name"],
    billingLastName: json["billing_last_name"],
    billingCompany: json["billing_company"],
    billingAddress1: json["billing_address_1"],
    billingAddress2: json["billing_address_2"],
    billingCity: json["billing_city"],
    billingPostcode: json["billing_postcode"],
    billingCountry: json["billing_country"],
    billingState: json["billing_state"],
    billingPhone: json["billing_phone"],
    billingEmail: json["billing_email"],
    shippingFirstName: json["shipping_first_name"],
    shippingLastName: json["shipping_last_name"],
    shippingCompany: json["shipping_company"],
    shippingAddress1: json["shipping_address_1"],
    shippingAddress2: json["shipping_address_2"],
    shippingCity: json["shipping_city"],
    shippingPostcode: json["shipping_postcode"],
    shippingCountry: json["shipping_country"],
    shippingState: json["shipping_state"],
    shippingPhone: json["shipping_phone"],
    shippingEmail: json["shipping_email"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "user_login": userLogin,
    "user_nicename": userNicename,
    "user_email": userEmail,
    "user_url": userUrl,
    "user_registered": userRegistered.toIso8601String(),
    "user_activation_key": userActivationKey,
    "user_status": userStatus,
    "display_name": displayName,
    "billing_first_name": billingFirstName,
    "billing_last_name": billingLastName,
    "billing_company": billingCompany,
    "billing_address_1": billingAddress1,
    "billing_address_2": billingAddress2,
    "billing_city": billingCity,
    "billing_postcode": billingPostcode,
    "billing_country": billingCountry,
    "billing_state": billingState,
    "billing_phone": billingPhone,
    "billing_email": billingEmail,
    "shipping_first_name": shippingFirstName,
    "shipping_last_name": shippingLastName,
    "shipping_company": shippingCompany,
    "shipping_address_1": shippingAddress1,
    "shipping_address_2": shippingAddress2,
    "shipping_city": shippingCity,
    "shipping_postcode": shippingPostcode,
    "shipping_country": shippingCountry,
    "shipping_state": shippingState,
    "shipping_phone": shippingPhone,
    "shipping_email": shippingEmail,
  };
}
