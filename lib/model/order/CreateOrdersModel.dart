// To parse this JSON data, do
//
//     final createOrdersModel = createOrdersModelFromJson(jsonString);

import 'dart:convert';

CreateOrdersModel createOrdersModelFromJson(String str) => CreateOrdersModel.fromJson(json.decode(str));

String createOrdersModelToJson(CreateOrdersModel data) => json.encode(data.toJson());

class CreateOrdersModel {
  bool error;
  String message;
  Data data;

  CreateOrdersModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory CreateOrdersModel.fromJson(Map<String, dynamic> json) => CreateOrdersModel(
    error: json["error"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  int id;
  String url;

  Data({
    required this.id,
    required this.url,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
  };
}
