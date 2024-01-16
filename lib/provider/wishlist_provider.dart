import 'dart:convert';
import 'package:ecom/widgets/extentionHelper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/dashboard/getDashboardProducts.dart';
import '../utils/shared_preferences_string.dart';

class WishlistProvider with ChangeNotifier {

  bool isApiLoading = false;
  bool obscureTexts = true;
  bool isNetworkAvail = true;
 String getWishListProducts="";

  addWishlistPref(GetDashBoardProducts product) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
    String wishListProductsPref=prefs.getString(WISHLIST) ?? "[]";
    List responseJson = json.decode(wishListProductsPref);
    List<GetDashBoardProducts> wishListProducts=List<GetDashBoardProducts>.from(responseJson.map((data) => GetDashBoardProducts.fromJson(data)).toList());
    bool found=false;
    for(int pos=0;pos<wishListProducts.length;pos++)
      if(wishListProducts[pos].id==product.id) {
        wishListProducts.update(pos, product);
        found=true;
        break;
      }
    if(!found)
      wishListProducts.add(product);
    var data=wishListProducts.map((data) => json.encode(data.toJson())).toList().toString();
    await setPreferences(WISHLIST, data);
    notifyListeners();
  }

  Future<bool> removeFromWishList(int productId) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    String currWishListProductsPref=prefs.getString(WISHLIST) ?? "[]";
    List responseJson = json.decode(currWishListProductsPref);
    List<GetDashBoardProducts> wishListList=List<GetDashBoardProducts>.from(responseJson.map((data) => GetDashBoardProducts.fromJson(data)).toList());
    wishListList.removeWhere( (value) => value.id==productId);
    var data=wishListList.map((data) => json.encode(data.toJson())).toList().toString();
    await prefs.setString(WISHLIST, data);
    notifyListeners();
    return true;
  }

  getWishlistPref()  async{
    isApiLoading =true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String wishListProductsPref= prefs.getString(WISHLIST) ?? "[]";
    List responseJson = json.decode(wishListProductsPref);
    List<GetDashBoardProducts> wishList=List<GetDashBoardProducts>.from(responseJson.map((data) => GetDashBoardProducts.fromJson(data)).toList());
    isApiLoading =false;
    notifyListeners();
    return wishList;
  }
}
