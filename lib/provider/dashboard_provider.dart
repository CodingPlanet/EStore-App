import 'dart:convert';
import 'package:ecom/data_provider/api_parameter.dart';
import 'package:ecom/model/dashboard/CategoryByProductModel.dart';
import 'package:ecom/model/dashboard/categoryModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../model/dashboard/getDashboard.dart';
import '../services/dashboard_service.dart';
import '../utils/paginator.dart';

class DashboardProvider with ChangeNotifier {

  bool isApiLoading = false;
  bool obscureTexts = true;
  bool isNetworkAvail = true;
  List<Datum> categoryList=[];
  List<dynamic> sliderList=[];
  late List<CategoryByProductModel>  categoryByproduct;

  getDashboard(int page, BuildContext context) async {

    Response response = await DashboardService().dashboardData(context: context,page: page);

    if (response.statusCode == 200) {
      dashboard_page++;
      var responseJson = json.decode(response.body);
      return GetDashboard.fromJson(responseJson);
    } else {
      return null;
    }
  }

  getCategory( BuildContext context) async {

    Response response = await DashboardService().categoryData(context: context);

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      if (responseJson[ERROR]) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseJson[MESSAGE])));
      } else {
        var result = categoryModelFromJson(response.body);
         categoryList= result.data;
         notifyListeners();
           return categoryList;

     }
    }else {
      return null;
    }
    notifyListeners();
  }

  getCategoryByProduct({required BuildContext context, required int id}) async {

    isApiLoading=true;
    Response response = await DashboardService().categoryByProductData(context: context, Id: id);

    final responseJson = categoryByProductModelFromJson(response.body);

    if (response.statusCode == 200) {
      isApiLoading=false;
      categoryByproduct=responseJson;
      notifyListeners();
    }else {
      return null;
    }
    notifyListeners();
  }

  getSlider( BuildContext context) async {

    isApiLoading=true;

    Response response = await DashboardService().sliderData(context: context);

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      if (responseJson[ERROR]) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseJson[MESSAGE])));
      } else {
        sliderList= responseJson[DATA];
        isApiLoading=false;
        notifyListeners();
        return sliderList;
      }
    }else {
      isApiLoading=false;
      notifyListeners();
      return null;
    }
    notifyListeners();
  }
}
