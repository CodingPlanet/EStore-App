import 'package:flutter/material.dart';
import '../data_provider/api_constants.dart';
import '../data_provider/api_service.dart';

class DashboardService{

  ApiService apiService = ApiService();

  dashboardData({required BuildContext context,required int page})async{
    return await apiService.httpGet(url: ApiConstants.dashboardUrl+"/?paged=$page",context:context,isToken: false);
  }

  categoryData({required BuildContext context})async{
    return await apiService.httpPost(url: ApiConstants.categoryUrl, body: null);
  }

  categoryByProductData({required BuildContext context,required int Id})async{
    return await apiService.httpGet(url: ApiConstants.categoryByProductUrl+"/?id=${Id}",context:context,isToken: false);

  }

  searchProductData({required BuildContext context, required String productName })async{
    return await apiService.httpGet(url: ApiConstants.getSearchProductUrl+"/?search=${productName}",context:context,isToken: false);
  }

  sliderData({required BuildContext context})async{
    return await apiService.httpGet(url: ApiConstants.sliderUrl,context:context,isToken: false);
  }

}