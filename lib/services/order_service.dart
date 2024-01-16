import 'package:ecom/data_provider/api_constants.dart';
import 'package:ecom/data_provider/api_service.dart';
import 'package:flutter/material.dart';

class OrderService{

  ApiService apiService = ApiService();

  OrderList({required BuildContext context,required var body })async{
    return await apiService.httpPost(url: ApiConstants.orderListUrl, body: body,);
  }

  CreateOrderData({required BuildContext context,required var body })async{
    return await apiService.httpPost(url: ApiConstants.createOrderUrl, body: body,);
  }

}