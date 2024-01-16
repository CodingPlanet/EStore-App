import 'package:ecom/model/order/CreateOrdersModel.dart';
import 'package:ecom/model/order/OrderListModel.dart';
import 'package:ecom/screen/order/order_status_screen.dart';
import 'package:ecom/screen/order/webViewScreen.dart';
import 'package:ecom/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data_provider/api_parameter.dart';
import '../model/order/OrderListWithoutItemModel.dart';
import '../utils/shared_preferences_string.dart';
import '../utils/string.dart';
import 'address_provider.dart';

class OrderProvider with ChangeNotifier {

  bool isApiLoading = false;
  String? checkoutUrl;
  int? orderIds;

  List<Datum> getOrderData=[];
  List<Datums> getOrderWithoutItemData=[];

  OrderListData({required BuildContext context,required int OrderId, required bool isShowOrderList})async{
    isApiLoading=true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(USERID);

    var body={
      USER_ID: "${userId}",
    };

    var Body={
      ID:"${OrderId}",
      USER_ID: "${userId}",
    };

    Response response = await OrderService().OrderList(context: context, body: isShowOrderList? body:Body);

    if (response.statusCode == 200) {
      if(!isShowOrderList){
        var responseJson =  orderListWithoutItemModelFromJson(response.body);
        if(responseJson.error){
          isApiLoading=false;
          getOrderWithoutItemData =responseJson.data;
          if(!isShowOrderList){
            for(var i in getOrderWithoutItemData){
              if(i.status==FAILED){
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(FAILED_TEXT)));
              } else if(i.status==CANCELLED){
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(CANCELLED_TEXT)));
              }
              else if(i.status==ON_HOLD || i.status==PROCESSING || i.status==COMPLETED){
                Navigator.of(context).push(MaterialPageRoute(builder: (builder) => OrderStatusScreen(orderStatus: i.status==ON_HOLD?ON_HOLD: i.status==PROCESSING? PROCESSING:COMPLETED,)));
              }
            }
          }
          notifyListeners();
        }else{
          isApiLoading=false;
          Navigator.pop(context, false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseJson.message)));
          notifyListeners();
        }
      }else{
        var responseJsons = orderListModelFromJson(response.body);
        if(responseJsons.error){
          isApiLoading=false;
          getOrderData =responseJsons.data;
          notifyListeners();
        }else{
          isApiLoading=false;
          Navigator.pop(context, false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseJsons.message)));
          notifyListeners();
        }
      }
    } else {
      return response;
    }
    notifyListeners();
  }

  CreateOrder({required BuildContext context,required List<int> item , required List<int> qtys  })async{
    isApiLoading=true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(USERID);
    var Body={
      ID: "${userId}",
      ITEMS: "${item.toString().replaceAll("[", "").replaceAll("]", "")}",
      QTY: "${qtys.toString().replaceAll("[", "").replaceAll("]", "")}",
      BILLING_FIRST_NAME: "${billingFirstName}",
      BILLING_LAST_NAME: "${billingLastName}",
      BILLING_COMPANY: "${billingCompanyName}",
      BILLING_ADDRESS_1: "${billingAddress1}",
      BILLING_ADDRESS_2: "${billingAddress2}",
      BILLING_CITY: "${billingCity}",
      BILLING_POSTCODE: "${billingPostalCode}",
      BILLING_COUNTRY: "${billingCountrys}",
      BILLING_STATE: "${billingState}",
      BILLING_PHONE: "${billingPhone}",
      BILLING_EMAIL: "${billingEmail}",

      SHIPPING_FIRST_NAME: "${shippingFirstName}",
      SHIPPING_LAST_NAME: "${shippingLastName}",
      SHIPPING_COMPANY: "${shippingCompanyName}",
      SHIPPING_ADDRESS_1: "${shippingAddress1}",
      SHIPPING_ADDRESS_2: "${shippingAddress2}",
      SHIPPING_CITY: "${shippingCity}",
      SHIPPING_POSTCODE: "${shippingPostalCode}",
      SHIPPING_COUNTRY: "${shippingCountrys}",
      SHIPPING_STATE: "${shippingState}",
      SHIPPING_PHONE: "${shippingPhone}",
      SHIPPING_EMAIL: "${shippingEmail}",
    };
    Response response = await OrderService().CreateOrderData(context: context, body: Body);
    if (response.statusCode == 200) {
      var responseJson = createOrdersModelFromJson(response.body);
      if(responseJson.error){
        isApiLoading=false;
        checkoutUrl=responseJson.data.url;
        orderIds=responseJson.data.id;
        Navigator.push(context, MaterialPageRoute(builder: (context)=> WebViewScreen(url: checkoutUrl.toString(),OrderId: orderIds!,)));
        notifyListeners();
      }else{
        isApiLoading=false;
        Navigator.pop(context, false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseJson.message)));
        notifyListeners();
      }
    } else {
      return response;
    }
    notifyListeners();
  }
}
