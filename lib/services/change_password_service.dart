import 'package:flutter/material.dart';
import '../data_provider/api_constants.dart';
import '../data_provider/api_service.dart';

class ChangePasswordService{

  ApiService apiService = ApiService();

  changePassword({required BuildContext context,required var body })async{
    return await apiService.httpPost(url: ApiConstants.changePasswordUrl, body: body,);
  }

}