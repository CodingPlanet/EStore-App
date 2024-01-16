// To parse this JSON data, do
//
//     final orderListWithoutItemModel = orderListWithoutItemModelFromJson(jsonString);

import 'dart:convert';

OrderListWithoutItemModel orderListWithoutItemModelFromJson(String str) => OrderListWithoutItemModel.fromJson(json.decode(str));

String orderListWithoutItemModelToJson(OrderListWithoutItemModel data) => json.encode(data.toJson());

class OrderListWithoutItemModel {
  bool error;
  String message;
  List<Datums> data;

  OrderListWithoutItemModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory OrderListWithoutItemModel.fromJson(Map<String, dynamic> json) => OrderListWithoutItemModel(
    error: json["error"],
    message: json["message"],
    data: List<Datums>.from(json["data"].map((x) => Datums.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datums {
  int id;
  int parentId;
  String status;
  String currency;
  String version;
  bool pricesIncludeTax;
  Date dateCreated;
  Date dateModified;
  String discountTotal;
  String discountTax;
  String shippingTotal;
  String shippingTax;
  String cartTax;
  String total;
  String totalTax;
  int customerId;
  String orderKey;
  Ing billing;
  Ing shipping;
  String paymentMethod;
  String paymentMethodTitle;
  String transactionId;
  String customerIpAddress;
  String customerUserAgent;
  String createdVia;
  String customerNote;
  dynamic dateCompleted;
  dynamic datePaid;
  String cartHash;
  bool orderStockReduced;
  bool downloadPermissionsGranted;
  bool newOrderEmailSent;
  bool recordedSales;
  bool recordedCouponUsageCounts;
  String number;
  List<dynamic> metaData;
  Map<String, LineItem> lineItems;
  List<dynamic> taxLines;
  List<dynamic> shippingLines;
  List<dynamic> feeLines;
  List<dynamic> couponLines;

  Datums({
    required this.id,
    required this.parentId,
    required this.status,
    required this.currency,
    required this.version,
    required this.pricesIncludeTax,
    required this.dateCreated,
    required this.dateModified,
    required this.discountTotal,
    required this.discountTax,
    required this.shippingTotal,
    required this.shippingTax,
    required this.cartTax,
    required this.total,
    required this.totalTax,
    required this.customerId,
    required this.orderKey,
    required this.billing,
    required this.shipping,
    required this.paymentMethod,
    required this.paymentMethodTitle,
    required this.transactionId,
    required this.customerIpAddress,
    required this.customerUserAgent,
    required this.createdVia,
    required this.customerNote,
    this.dateCompleted,
    this.datePaid,
    required this.cartHash,
    required this.orderStockReduced,
    required this.downloadPermissionsGranted,
    required this.newOrderEmailSent,
    required this.recordedSales,
    required this.recordedCouponUsageCounts,
    required this.number,
    required this.metaData,
    required this.lineItems,
    required this.taxLines,
    required this.shippingLines,
    required this.feeLines,
    required this.couponLines,
  });

  factory Datums.fromJson(Map<String, dynamic> json) => Datums(
    id: json["id"],
    parentId: json["parent_id"],
    status: json["status"],
    currency: json["currency"],
    version: json["version"],
    pricesIncludeTax: json["prices_include_tax"],
    dateCreated: Date.fromJson(json["date_created"]),
    dateModified: Date.fromJson(json["date_modified"]),
    discountTotal: json["discount_total"],
    discountTax: json["discount_tax"],
    shippingTotal: json["shipping_total"],
    shippingTax: json["shipping_tax"],
    cartTax: json["cart_tax"],
    total: json["total"],
    totalTax: json["total_tax"],
    customerId: json["customer_id"],
    orderKey: json["order_key"],
    billing: Ing.fromJson(json["billing"]),
    shipping: Ing.fromJson(json["shipping"]),
    paymentMethod: json["payment_method"],
    paymentMethodTitle: json["payment_method_title"],
    transactionId: json["transaction_id"],
    customerIpAddress: json["customer_ip_address"],
    customerUserAgent: json["customer_user_agent"],
    createdVia: json["created_via"],
    customerNote: json["customer_note"],
    dateCompleted: json["date_completed"],
    datePaid: json["date_paid"],
    cartHash: json["cart_hash"],
    orderStockReduced: json["order_stock_reduced"],
    downloadPermissionsGranted: json["download_permissions_granted"],
    newOrderEmailSent: json["new_order_email_sent"],
    recordedSales: json["recorded_sales"],
    recordedCouponUsageCounts: json["recorded_coupon_usage_counts"],
    number: json["number"],
    metaData: List<dynamic>.from(json["meta_data"].map((x) => x)),
    lineItems: Map.from(json["line_items"]).map((k, v) => MapEntry<String, LineItem>(k, LineItem.fromJson(v))),
    taxLines: List<dynamic>.from(json["tax_lines"].map((x) => x)),
    shippingLines: List<dynamic>.from(json["shipping_lines"].map((x) => x)),
    feeLines: List<dynamic>.from(json["fee_lines"].map((x) => x)),
    couponLines: List<dynamic>.from(json["coupon_lines"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "status": status,
    "currency": currency,
    "version": version,
    "prices_include_tax": pricesIncludeTax,
    "date_created": dateCreated.toJson(),
    "date_modified": dateModified.toJson(),
    "discount_total": discountTotal,
    "discount_tax": discountTax,
    "shipping_total": shippingTotal,
    "shipping_tax": shippingTax,
    "cart_tax": cartTax,
    "total": total,
    "total_tax": totalTax,
    "customer_id": customerId,
    "order_key": orderKey,
    "billing": billing.toJson(),
    "shipping": shipping.toJson(),
    "payment_method": paymentMethod,
    "payment_method_title": paymentMethodTitle,
    "transaction_id": transactionId,
    "customer_ip_address": customerIpAddress,
    "customer_user_agent": customerUserAgent,
    "created_via": createdVia,
    "customer_note": customerNote,
    "date_completed": dateCompleted,
    "date_paid": datePaid,
    "cart_hash": cartHash,
    "order_stock_reduced": orderStockReduced,
    "download_permissions_granted": downloadPermissionsGranted,
    "new_order_email_sent": newOrderEmailSent,
    "recorded_sales": recordedSales,
    "recorded_coupon_usage_counts": recordedCouponUsageCounts,
    "number": number,
    "meta_data": List<dynamic>.from(metaData.map((x) => x)),
    "line_items": Map.from(lineItems).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "tax_lines": List<dynamic>.from(taxLines.map((x) => x)),
    "shipping_lines": List<dynamic>.from(shippingLines.map((x) => x)),
    "fee_lines": List<dynamic>.from(feeLines.map((x) => x)),
    "coupon_lines": List<dynamic>.from(couponLines.map((x) => x)),
  };
}

class Ing {
  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String state;
  String postcode;
  String country;
  String? email;
  String phone;

  Ing({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    this.email,
    required this.phone,
  });

  factory Ing.fromJson(Map<String, dynamic> json) => Ing(
    firstName: json["first_name"],
    lastName: json["last_name"],
    company: json["company"],
    address1: json["address_1"],
    address2: json["address_2"],
    city: json["city"],
    state: json["state"],
    postcode: json["postcode"],
    country: json["country"],
    email: json["email"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "company": company,
    "address_1": address1,
    "address_2": address2,
    "city": city,
    "state": state,
    "postcode": postcode,
    "country": country,
    "email": email,
    "phone": phone,
  };
}

class Date {
  DateTime date;
  int timezoneType;
  String timezone;

  Date({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  factory Date.fromJson(Map<String, dynamic> json) => Date(
    date: DateTime.parse(json["date"]),
    timezoneType: json["timezone_type"],
    timezone: json["timezone"],
  );

  Map<String, dynamic> toJson() => {
    "date": date.toIso8601String(),
    "timezone_type": timezoneType,
    "timezone": timezone,
  };
}

class LineItem {
  LineItem();

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
  );

  Map<String, dynamic> toJson() => {
  };
}
