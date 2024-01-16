import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../model/dashboard/getDashboardProducts.dart';
import '../services/dashboard_service.dart';

class SearchProvider with ChangeNotifier {

  bool isApiLoading = false;
  TextEditingController searchController = TextEditingController();
  List<GetDashBoardProducts> filteredList=[];
  List<GetDashBoardProducts> searchItem=[];

  getSearchProduct({required BuildContext context,required String searchName}) async {
    isApiLoading = true;
    Response response = await DashboardService().searchProductData(context: context, productName: "${searchName}");
    if (response.statusCode == 200) {
      if(response.body == []){
        isApiLoading = false;
        notifyListeners();
      }else{
        final jsonData = json.decode(response.body);
        List<GetDashBoardProducts> rawJson = List<GetDashBoardProducts>.from(jsonData.map((data) => GetDashBoardProducts.fromJson(data)));
        filteredList=rawJson;
        searchItem = filteredList;
        isApiLoading = false;
        notifyListeners();
      }
    } else {
      print("unable to load members");
    }
    notifyListeners();
  }
}
