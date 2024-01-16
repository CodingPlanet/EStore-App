import 'package:ecom/provider/connectivity_provider.dart';
import 'package:ecom/provider/order_provider.dart';
import 'package:ecom/screen/authentication/login_screen.dart';
import 'package:ecom/screen/connectivity_screen.dart';
import 'package:ecom/screen/profile/update_address_screen.dart';
import 'package:ecom/utils/shared_preferences_string.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/coupon/getCoupons.dart';
import '../../model/dashboard/getDashboardProducts.dart';
import '../../model/order/createOrderModel.dart';
import '../../provider/address_provider.dart';
import '../../provider/cart_provider.dart';
import '../../utils/colors.dart';
import '../../utils/string.dart';
import '../../widgets/appbar_title.dart';
import '../splash_screen.dart';

List<int> itemsIds=[];
List<int> qntNumbers=[];
class CartScreen extends StatefulWidget {
  final bool isArrowAppBar;
  CartScreen({required this.isArrowAppBar});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

List<GetAllCoupon>? coupons;

class _CartScreenState extends State<CartScreen> {

  String? email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData()async{
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    context.read<CartProvider>().cartList= await cartProvider.getCartProductsPref();
    final prefs = await SharedPreferences.getInstance();
    email = await prefs.getString(SHARED_PREFERENCES_EMAIL);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final cartProvider = Provider.of<CartProvider>(context);
    context.read<CartProvider>().totalCost=0.0;
    final orderProvider = Provider.of<OrderProvider>(context);

    Future.delayed(Duration(seconds: 2), () {
      itemsIds.clear();
      qntNumbers.clear();
      for(int i = 0; i < cartProvider.cartList.length; i++){
        itemsIds.add(cartProvider.cartList[i].product_id);
        qntNumbers.add(cartProvider.cartList[i].quantity);
      }
    });
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBarTitle().appbar(setState, context, CART,widget.isArrowAppBar?true:false),
      body: !context.read<ConnectivityProvider>().isConnected?connectivityData(context: context,OnTap: (){
        context.read<ConnectivityProvider>().checkConnection();
        getData();
      }):SafeArea(
          child: cartProvider.isApiLoading?Center(child: CircularProgressIndicator(
            color: CIRCULAR_INDICATOR_COLOR,
          )):
          Stack(
            children: [
              context.read<CartProvider>().cartList.length==0
                  ?
              Container(
                 height:500,
                alignment: Alignment.center,
                child: Text(
                    CART_EMPTY,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: TEXT_COLOR,
                    fontSize: size.width*0.045,
                    fontWeight: FontWeight.w400

                  )
                ),
              )
                  :
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: size.width*0.02,),

                    ListView.builder(
                      itemCount: context.read<CartProvider>().cartList.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, int index) {
                        return  products(context.read<CartProvider>().cartList[index], index);
                      },
                    ),

                    SizedBox(height: size.height*0.15,),

                  ],
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: size.height*0.16,
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.01,vertical: size.width*0.02),
                  decoration: BoxDecoration(
                    color: CARD_BACKGROUND_COLOR,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: size.height*0.02,),

                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal:size.width*0.02 ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Container(
                                width: size.width*0.45,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        TOTAL ,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: TextStyle(
                                            color: HEADING_TEXT_COLOR,
                                            fontSize:size.width*0.055,
                                            fontWeight: FontWeight.w300
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: size.height*0.003,),
                                    Flexible(child: FutureBuilder(
                                        future: context.read<CartProvider>().getTotalPrice(context),
                                        initialData: "Loading ..",
                                        builder: (BuildContext context, AsyncSnapshot<String> text) {
                                          return Text(
                                            "${currencyCode} "+text.data!,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: PRICE_COLOR,
                                                fontSize:size.width*0.055,
                                                fontWeight: FontWeight.bold
                                            ),
                                          );
                                        }),)


                                  ],
                                ),
                              ),

                              GestureDetector(
                                  onTap: (){
                                    email==null? Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen() )):
                                    context.read<CartProvider>().cartList.length==0? ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Cart Is Empty"))):
                                   billingCity==null || billingCity==""?Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateAddressScreen() )):
                                    orderProvider.CreateOrder(context: context, item: itemsIds, qtys: qntNumbers);
                                    },
                                  child: Container(
                                    height: size.height*0.08,
                                    padding: EdgeInsets.symmetric(horizontal: size.width*0.07,),
                                    decoration: BoxDecoration(
                                      color: BUTTON_COLOR,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                        child: Row(
                                          children: [
                                            Text(
                                              CHECKOUT ,
                                              overflow: TextOverflow.ellipsis,
                                              style:TextStyle(
                                                  color: Colors.white,
                                                  fontSize: size.width*0.050,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),

                                            SizedBox(width: size.width*0.01,),

                                            Icon(Icons.arrow_forward,color: Colors.white,size: 22,)
                                          ],
                                        )),
                                  )
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget products(Line_items item,int index) {

    var size = MediaQuery.of(context).size;
   final cartProvider = Provider.of<CartProvider>(context);
    GetDashBoardProducts getProduct=item.productDetail;
    context.read<CartProvider>().getLoadData(context, item,getProduct);
    return  Container(
        padding: EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: size.width*0.02),
      child: Column(
          children: [

            Container(
              width: size.width,
              decoration: BoxDecoration(
                color: CARD_BACKGROUND_COLOR,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.02,vertical: size.width*0.02),
                    height: size.height*0.17,
                    width: size.width*0.35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        getProduct.images[0].src,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                  Container(
                    width: size.width*0.55,
                    padding: EdgeInsets.symmetric(vertical: size.width*0.025),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width*0.45,
                              child: Text(
                                getProduct.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                    color: HEADING_TEXT_COLOR,
                                    fontSize:size.width*0.043,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),

                            GestureDetector(
                                onTap: (){
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10))),

                                        title: Container(
                                            alignment: Alignment.center,
                                            child: Text(DELETE_WISHLIST_MSG , style:TextStyle(color: TITLE_COLOR,fontSize: 16))
                                        ),
                                        actionsAlignment: MainAxisAlignment.spaceBetween,
                                        actions: [
                                          TextButton(
                                            onPressed: ()async {

                                              Navigator.pop(context);
                                              cartProvider.delCartProductsPref(getProduct.id).then((value) {
                                                getData();
                                              });
                                            },
                                            child: Text(YES ,style: TextStyle(color: TEXT_COLOR,fontSize: 14)),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, false);
                                            },
                                            child: Text(NO,style: TextStyle(color: TEXT_COLOR,fontSize: 14)),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                },
                                child: Icon(Icons.delete_outline,color: ICON_COLOR,)),
                          ],
                        ),

                        Row(
                          children: [
                            Text(
                              PRICE+" : ",
                              style: TextStyle(
                                  color: TEXT_COLOR,
                                  fontSize:size.width*0.040,
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                            Flexible(
                              child: Text(
                                context.read<CartProvider>().itemPriceText!,
                                maxLines: 2,
                                style: TextStyle(
                                    color: PRICE_COLOR,
                                    fontSize:size.width*0.040,
                                    fontWeight: FontWeight.normal
                                ),
                              ),
                            ),
                            SizedBox(height: size.height*0.01,),
                          ],
                        ),

                        SizedBox(height: size.height*0.005,),

                        Container(
                          child: Row(
                            children: [
                              Text(
                                SUBTOTAL+" : ",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: TEXT_COLOR,
                                    fontSize:size.width*0.040,
                                    fontWeight: FontWeight.normal
                                ),
                              ),

                              Flexible(
                                child: Text(
                                  context.read<CartProvider>().itemSubtotalText!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: PRICE_COLOR,
                                      fontSize:size.width*0.040,
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                              ),

                              SizedBox(height: size.height*0.01,),
                            ],
                          ),
                        ),

                        SizedBox(height: size.height*0.005,),

                        Row(
                          children: [
                            GestureDetector(
                                onTap:(){
                                  if(item.quantity<30)
                                    item.quantity+=1;
                                  cartProvider.addOrUpdateCartProductsPref(item).then((value){
                                  } );
                                  },
                                child: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey
                                        ),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Icon(Icons.add,color: ICON_COLOR,)
                                )),

                            SizedBox(width: size.width*0.03,),

                            Text("${item.quantity}",
                              style: TextStyle(
                                  color: TEXT_COLOR,
                                  fontSize:size.width*0.045,
                                  fontWeight: FontWeight.bold
                              ),),

                            SizedBox(width: size.width*0.03,),

                            GestureDetector(
                                onTap: (){
                                  if(item.quantity>1)
                                    item.quantity-=1;
                                  cartProvider.addOrUpdateCartProductsPref(item).then((isUpdated){
                                  });
                                },
                                child: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey
                                        ),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Icon(Icons.remove,color: ICON_COLOR,)))
                          ],
                        ),

                        SizedBox(height: size.height*0.005,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]
      ),
    );
  }
}
