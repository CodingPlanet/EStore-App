import 'package:ecom/data_provider/api_constants.dart';
import 'package:ecom/data_provider/api_service.dart';
import 'package:flutter/material.dart';

class AddressService{

  ApiService apiService = ApiService();

  UpdateAddressData({required BuildContext context,required var body })async{
    return await apiService.httpPost(url: ApiConstants.updateAddressUrl, body: body,);
  }

}