import 'dart:convert';
import 'package:ecom/widgets/extentionHelper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/coupon/getCoupons.dart';
import '../model/dashboard/getDashboardCategory.dart';
import '../model/dashboard/getDashboardProducts.dart';
import '../model/order/createOrderModel.dart';
import '../model/product/getProductsParent.dart';
import '../screen/splash_screen.dart';
import '../utils/enum/coupon.dart';
import '../utils/shared_preferences_string.dart';
import 'package:collection/collection.dart';

class CartProvider with ChangeNotifier {

  bool isApiLoading = false;
  int counter=0;
  late List<Line_items> cartList;
  List<Line_items> cartCounter=[];
  List<int> itemsId=[];
  List<int> qntNumber=[];
  CouponSelection couponSelection=CouponSelection.TextField;
  TextEditingController couponController = TextEditingController();
  double totalCost=0;
  String? itemPriceText;
  String? itemSubtotalText;
  double price=0.0;
  int REFRESH_DELAY=1;
  String? images;

  getLoadData(BuildContext context ,Line_items item , GetDashBoardProducts getProduct){
    getProduct=item.productDetail;
    Variations? variant=null;
    // ignore: unnecessary_null_comparison
    if(getProduct==null)
      return Container();

    variant=item.variation_id==-1?null:getProduct.variations.firstWhere((element) => element.id==item.variation_id, orElse : null);
    if(variant!=null)
      // ignore: unnecessary_null_comparison
      images=variant!=null?
      variant.images.length>0?variant.images[0].src:null
          :null;
    else
      // ignore: unnecessary_null_comparison
      images=getProduct!=null?
      getProduct.images.length>0?getProduct.images[0].src:null
          :null;
    if(variant!=null)
      price=variant.price==""?0:price=double.parse(variant.price);
    else
     price=getProduct.price==""?0:double.parse(getProduct.price);
    itemPriceText=  "${currencyCode} "+"${price}";
    itemSubtotalText= "${currencyCode} "+ "${price* item.quantity}";
    totalCost+=(price*item.quantity);
  }

  bool isValidTokenForProduct(GetAllCoupon _coupon,GetDashBoardProducts getproduct){
    List<int> valid=_coupon.product_ids;

    valid.removeWhere((couponProductId) =>
        _coupon.excluded_product_ids.contains(couponProductId)
    );
    int data=valid.firstWhere((element) => element==getproduct.id,orElse:() => 0);
    return data!=0 ;

  }

  bool isValidTokenForP_Category(GetAllCoupon _coupon,List<GetDashboardCategories> productCategories){
    List<int> validCategories=_coupon.product_categories;

    validCategories.removeWhere((couponCategoryId) =>
        _coupon.excluded_product_categories.contains(couponCategoryId)
    );
    GetDashboardCategories? data=productCategories.firstWhereOrNull((dashBoardCat) => dashBoardCat.id==
        validCategories.firstWhere((element) => element==dashBoardCat.id,orElse:() => 0)
    );
    return data!=null ;
  }

  Future<bool> addOrUpdateCartProductsPref(Line_items cartProduct) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currCartProductsPref=prefs.getString(CARTPRODUCTS) ?? "[]";

    List responseJson = json.decode(currCartProductsPref);
    List<Line_items> cartList=List<Line_items>.from(responseJson.map((data) => Line_items.fromJson(data)).toList());
    bool found=false;
    for(int pos=0;pos<cartList.length;pos++)
      if(cartList[pos].product_id==cartProduct.product_id) {
        cartList.update(pos, cartProduct);
        found=true;
        break;
      }
    if(!found)
      cartList.add(cartProduct);
    var data=cartList.map((data) => json.encode(data.toJson())).toList().toString();
    await prefs.setString(CARTPRODUCTS, data);
    notifyListeners();
    return true;
  }

   getCartProductsPref() async {
     isApiLoading=true;
     SharedPreferences prefs = await SharedPreferences.getInstance();
    String currCartProductsPref=prefs.getString(CARTPRODUCTS) ?? "[]";
    List responseJson = json.decode(currCartProductsPref);
    List<Line_items> cartList=List<Line_items>.from(responseJson.map((data) => Line_items.fromJson(data)).toList());
     cartCounter=cartList;
     isApiLoading=false;
     notifyListeners();
    return cartList;
  }

  Future<bool> delCartProductsPref(int product_id) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currCartProductsPref=prefs.getString(CARTPRODUCTS) ?? "[]";
    List responseJson = json.decode(currCartProductsPref);
    List<Line_items> cartList=List<Line_items>.from(responseJson.map((data) => Line_items.fromJson(data)).toList());
    cartList.removeWhere( (value) => value.product_id==product_id);
    var data=cartList.map((data) => json.encode(data.toJson())).toList().toString();
    await prefs.setString(CARTPRODUCTS, data);
    notifyListeners();
    return true;
  }

  Future<bool> delAllCartProductsPref( ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(CARTPRODUCTS, "[]");
    notifyListeners();
    return true;
  }

  Future<String> getTotalPrice(BuildContext  context){
    return Future.delayed( Duration(seconds: REFRESH_DELAY), () => totalCost.toString());
  }
}
