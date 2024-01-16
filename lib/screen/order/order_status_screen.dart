import 'package:ecom/provider/cart_provider.dart';
import 'package:ecom/screen/dashboard/home_screen.dart';
import 'package:ecom/utils/colors.dart';
import 'package:ecom/utils/shared_preferences_string.dart';
import 'package:ecom/utils/string.dart';
import 'package:ecom/widgets/app_button.dart';
import 'package:ecom/widgets/appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class OrderStatusScreen extends StatefulWidget {

  String orderStatus;
  OrderStatusScreen({required this.orderStatus});

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarTitle().appbar(setState, context, widget.orderStatus=="completed"?
      ORDERS_COMPLETED_STATUS:widget.orderStatus=="on-hold"?ORDERS_ON_HOLD_STATUS:ORDERS_PROCESSING_STATUS,true),
      body: widget.orderStatus=="completed"?Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: size.width*0.40,
              width: size.width*0.40,
              child: Image.asset("Images/orderSuccess.png") ,
            ),
            SizedBox(height: size.height*0.05 ,),
            Container(
              child: Text("Order Confirmed", style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: size.height*0.025
              ),
              ),
            ),
            SizedBox(height: size.height*0.05 ,),
            GestureDetector(
              onTap: ()async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove(CARTPRODUCTS);
                final cartProvider = Provider.of<CartProvider>(context, listen: false);
                context.read<CartProvider>().cartList= await cartProvider.getCartProductsPref();

                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomeScreen()), (route) => false);

              },
              child: Container(
                height: size.height*0.12,
                padding: EdgeInsets.symmetric(horizontal: size.width*0.08),
                decoration: BoxDecoration(
                  color: CARD_BACKGROUND_COLOR,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Center(child: button(title: "Continue Shopping", context: context )),
              ),
            ),
          ],
        ),
      ):
      widget.orderStatus=="on-hold"?
      Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: size.width*0.40,
              width: size.width*0.40,
              child: Image.asset("Images/orderOnHold.png") ,
            ),
            SizedBox(height: size.height*0.05 ,),
            Container(
              child: Text("Order On-Hold" ,  style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: size.height*0.025
              ),
              ),

            ),
            SizedBox(height: size.height*0.05 ,),
            GestureDetector(
              onTap: ()async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove(CARTPRODUCTS);
                final cartProvider = Provider.of<CartProvider>(context, listen: false);
                context.read<CartProvider>().cartList= await cartProvider.getCartProductsPref();

                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomeScreen()), (route) => false);

              },
              child: Container(
                height: size.height*0.12,
                padding: EdgeInsets.symmetric(horizontal: size.width*0.08),
                decoration: BoxDecoration(
                  color: CARD_BACKGROUND_COLOR,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Center(child: button(title: "Continue Shopping", context: context )),
              ),
            ),

          ],
        ),
      ):Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: size.width*0.60,
              width: size.width*0.60,
              child: Image.asset("Images/orderProcessing.png") ,
            ),
            SizedBox(height: size.height*0.03 ,),
            Container(
              child: Text("Order processing", style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: size.height*0.025
              ),
              ),
            ),
            SizedBox(height: size.height*0.05 ,),
            GestureDetector(
              onTap: ()async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove(CARTPRODUCTS);
                final cartProvider = Provider.of<CartProvider>(context, listen: false);
                context.read<CartProvider>().cartList= await cartProvider.getCartProductsPref();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomeScreen()), (route) => false);
                },
              child: Container(
                height: size.height*0.12,
                padding: EdgeInsets.symmetric(horizontal: size.width*0.08),
                decoration: BoxDecoration(
                  color: CARD_BACKGROUND_COLOR,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Center(child: button(title: "Continue Shopping", context: context )),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
