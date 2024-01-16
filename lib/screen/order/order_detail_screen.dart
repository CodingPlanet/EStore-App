import 'package:ecom/model/order/OrderListModel.dart';
import 'package:ecom/provider/connectivity_provider.dart';
import 'package:ecom/screen/connectivity_screen.dart';
import 'package:ecom/utils/colors.dart';
import 'package:ecom/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OrderDetailsScreen extends StatefulWidget {

  String OrderId;
  Datum getOrderList;

  OrderDetailsScreen({required this.OrderId, required this.getOrderList});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String? updatedShippingAddress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    String billingAddress=widget.getOrderList.billing.address1==""?( widget.getOrderList.billing.address2==""?(
        widget.getOrderList.billing.city==""?(
            widget.getOrderList.billing.state==""?(
                widget.getOrderList.billing.postcode==""?(widget.getOrderList.billing.country==""?"": widget.getOrderList.billing.country):
                widget.getOrderList.billing.postcode
                    + ","+ widget.getOrderList.billing.country):
            widget.getOrderList.billing.state + ","+
                widget.getOrderList.billing.postcode + ","+ widget.getOrderList.billing.country):
        widget.getOrderList.billing.city + ","+ widget.getOrderList.billing.state + ","+
            widget.getOrderList.billing.postcode + ","+ widget.getOrderList.billing.country
    ): widget.getOrderList.billing.address2 + ","+
        widget.getOrderList.billing.city + ","+ widget.getOrderList.billing.state + ","+
        widget.getOrderList.billing.postcode + ","+ widget.getOrderList.billing.country)
        :(widget.getOrderList.billing.address1 +"," + widget.getOrderList.billing.address2 + ","+
        widget.getOrderList.billing.city + ","+ widget.getOrderList.billing.state + ","+
        widget.getOrderList.billing.postcode + ","+ widget.getOrderList.billing.country );

    String updatedBillingAddress = billingAddress==""?"":billingAddress.substring(0, billingAddress.length - 1);
     updatedBillingAddress = billingAddress.replaceFirst(RegExp(r',\s*$'), '');


    String shippingAddress=widget.getOrderList.shipping.address1==""?( widget.getOrderList.shipping.address2==""?(
        widget.getOrderList.shipping.city==""?(
            widget.getOrderList.shipping.state==""?(
                widget.getOrderList.shipping.postcode==""?(widget.getOrderList.shipping.country==""?"": widget.getOrderList.shipping.country):
                widget.getOrderList.shipping.postcode
                    + ","+ widget.getOrderList.shipping.country):
            widget.getOrderList.shipping.state + ","+
                widget.getOrderList.shipping.postcode + ","+ widget.getOrderList.shipping.country):
        widget.getOrderList.shipping.city + ","+ widget.getOrderList.shipping.state + ","+
            widget.getOrderList.shipping.postcode + ","+ widget.getOrderList.shipping.country
    ): widget.getOrderList.shipping.address2 + ","+
        widget.getOrderList.shipping.city + ","+ widget.getOrderList.shipping.state + ","+
        widget.getOrderList.shipping.postcode + ","+ widget.getOrderList.shipping.country)
        :(widget.getOrderList.shipping.address1 +"," + widget.getOrderList.shipping.address2 + ","+
        widget.getOrderList.shipping.city + ","+ widget.getOrderList.shipping.state + ","+
        widget.getOrderList.shipping.postcode + ","+ widget.getOrderList.shipping.country );
   updatedShippingAddress = shippingAddress==""?"":shippingAddress.substring(0, shippingAddress.length - 1);
    updatedShippingAddress = shippingAddress.replaceFirst(RegExp(r',\s*$'), '');

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor:APP_BAR_COLOR,
        automaticallyImplyLeading: false,
        leadingWidth: 0,
        title: Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  },
                child: Container(
                  child: Icon(
                    Icons.arrow_back,
                    color: ICON_COLOR,
                    size: size.width*0.055,
                  ),
                )
            ),
            SizedBox(width: size.width*0.04,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width*0.02),
              child: Text(
                ORDERS_DETAILS,
                style: TextStyle(
                    fontSize: 18,
                    color:APPBAR_TEXT_COLOR,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
      ),
      body:!context.read<ConnectivityProvider>().isConnected?connectivityData(context: context,OnTap: (){
        context.read<ConnectivityProvider>().checkConnection();
      }):

      SingleChildScrollView(
        child: Container(
          child: Column(

            children:[
              Container(
                width: size.width,
                child: Column(
                  children: [
                    SizedBox(height: size.height*0.01,),
                    Card(
                      margin: EdgeInsets.symmetric(horizontal: size.width*0.02,vertical: size.width*0.02),
                      color: CARD_BACKGROUND_COLOR,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width*0.02,vertical: size.width*0.03),
                        child: Row(
                          children: [
                            Container(
                              child: Text("Order ID:", style: TextStyle(
                                  fontSize: size.width*0.045,
                                  color:APPBAR_TEXT_COLOR,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),

                            Container(
                              child: Text("${widget.getOrderList.number}", style: TextStyle(
                                  fontSize: size.width*0.040,
                                  color:APPBAR_TEXT_COLOR,
                                  fontWeight: FontWeight.normal
                              ),),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Column(
                      children: [
                        ListView.builder(
                          itemCount: widget.getOrderList.items.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, int index) {
                            String price=  "${double.parse(widget.getOrderList.items[index].subTotal) /widget.getOrderList.items[index].qty }";
                            return     Card(
                                margin: EdgeInsets.symmetric(horizontal: size.width*0.02,vertical: size.width*0.02),
                              color: CARD_BACKGROUND_COLOR,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: size.width*0.02,vertical:size.height*0.02 ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: size.width*0.45,
                                          child: Text(
                                            "${widget.getOrderList.items[index].name}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: TextStyle(
                                                color: HEADING_TEXT_COLOR,
                                                fontSize:size.width*0.043,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),

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
                                        Text(
                                          "${price}",
                                          style: TextStyle(
                                              color: PRICE_COLOR,
                                              fontSize:size.width*0.040,
                                              fontWeight: FontWeight.normal
                                          ),
                                        ),
                                        SizedBox(height: size.height*0.01,),
                                      ],
                                    ),
                                    SizedBox(height: size.height*0.005,),
                                    Row(
                                      children: [
                                        Text(
                                          "Qty"+" : ",
                                          style: TextStyle(
                                              color: TEXT_COLOR,
                                              fontSize:size.width*0.040,
                                              fontWeight: FontWeight.normal
                                          ),
                                        ),
                                        Text(
                                          "${widget.getOrderList.items[index].qty}",
                                          style: TextStyle(
                                              color: PRICE_COLOR,
                                              fontSize:size.width*0.040,
                                              fontWeight: FontWeight.normal
                                          ),
                                        ),
                                        SizedBox(height: size.height*0.01,),
                                      ],
                                    ),
                                    SizedBox(height: size.height*0.002,),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    Card(
                      color: CARD_BACKGROUND_COLOR,
                      margin: EdgeInsets.symmetric(horizontal: size.width*0.02,vertical: size.width*0.02),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width*0.02,vertical: size.width*0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text("Shipping Details", style: TextStyle(
                                  fontSize: size.width*0.040,
                                  color:APPBAR_TEXT_COLOR,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                            Divider(),
                            widget.getOrderList.shipping.firstName=="" || widget.getOrderList.shipping.lastName==""?Container():
                            Container(
                              child: Text(
                                widget.getOrderList.shipping.firstName + widget.getOrderList.shipping.lastName,
                                style: TextStyle(
                                  fontSize: size.width*0.040,
                                  color:APPBAR_TEXT_COLOR,
                                  fontWeight: FontWeight.normal
                              ),),
                            ),

                            widget.getOrderList.shipping.phone==""?Container():
                            Container(
                              child: Text(widget.getOrderList.shipping.phone, style: TextStyle(
                                  fontSize: size.width*0.040,
                                  color:APPBAR_TEXT_COLOR,
                                  fontWeight: FontWeight.normal
                              ),),
                            ),

                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: CARD_BACKGROUND_COLOR,
                      margin: EdgeInsets.symmetric(horizontal: size.width*0.02,vertical: size.width*0.02),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width*0.02,vertical: size.width*0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text("Billing Details", style: TextStyle(
                                  fontSize: size.width*0.040,
                                  color:APPBAR_TEXT_COLOR,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                            Divider(),
                            widget.getOrderList.billing.firstName=="" || widget.getOrderList.billing.lastName==""?Container():
                            Container(
                              child: Text(
                                widget.getOrderList.billing.firstName + widget.getOrderList.billing.lastName,
                                style: TextStyle(
                                    fontSize: size.width*0.040,
                                    color:APPBAR_TEXT_COLOR,
                                    fontWeight: FontWeight.normal
                                ),),
                            ),
                            Container(
                              child: Text(
                                updatedBillingAddress.trimRight(),
                                style: TextStyle(
                                    fontSize: size.width*0.040,
                                    color:APPBAR_TEXT_COLOR,
                                    fontWeight: FontWeight.normal
                                ),),
                            ),
                            widget.getOrderList.billing.phone==""?Container():
                            Container(
                              child: Text(widget.getOrderList.billing.phone, style: TextStyle(
                                  fontSize: size.width*0.040,
                                  color:APPBAR_TEXT_COLOR,
                                  fontWeight: FontWeight.normal
                              ),),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Card(
                      color: CARD_BACKGROUND_COLOR,
                      margin: EdgeInsets.symmetric(horizontal: size.width*0.02,vertical: size.width*0.02),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width*0.02,vertical: size.width*0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text("Payment Method", style: TextStyle(
                                  fontSize: size.width*0.040,
                                  color:APPBAR_TEXT_COLOR,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                            Divider(),
                            Container(
                              child: Text("${widget.getOrderList.paymentMethod}", style: TextStyle(
                                  fontSize: size.width*0.040,
                                  color:APPBAR_TEXT_COLOR,
                                  fontWeight: FontWeight.normal
                              ),),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Card(
                      color: CARD_BACKGROUND_COLOR,
                      margin: EdgeInsets.symmetric(horizontal: size.width*0.02,vertical: size.width*0.02),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width*0.02,vertical: size.width*0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text("Price Detail", style: TextStyle(
                                  fontSize: size.width*0.040,
                                  color:APPBAR_TEXT_COLOR,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text("Price:", style: TextStyle(
                                      fontSize: size.width*0.040,
                                      color:APPBAR_TEXT_COLOR,
                                      fontWeight: FontWeight.normal
                                  ),),
                                ),
                                Container(
                                  child: Text("${widget.getOrderList.total}", style: TextStyle(
                                      fontSize: size.width*0.040,
                                      color:APPBAR_TEXT_COLOR,
                                      fontWeight: FontWeight.normal
                                  ),),
                                ),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text("Discount Total :", style: TextStyle(
                                      fontSize: size.width*0.040,
                                      color:APPBAR_TEXT_COLOR,
                                      fontWeight: FontWeight.normal
                                  ),),
                                ),
                                Container(
                                  child: Text("${widget.getOrderList.discountTotal}", style: TextStyle(
                                      fontSize: size.width*0.040,
                                      color:APPBAR_TEXT_COLOR,
                                      fontWeight: FontWeight.normal
                                  ),),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text("Total Price:", style: TextStyle(
                                      fontSize: size.width*0.040,
                                      color:APPBAR_TEXT_COLOR,
                                      fontWeight: FontWeight.normal
                                  ),),
                                ),
                                Container(
                                  child: Text("${widget.getOrderList.total}", style: TextStyle(
                                      fontSize: size.width*0.040,
                                      color:APPBAR_TEXT_COLOR,
                                      fontWeight: FontWeight.normal
                                  ),),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]
          ),
        ),
      ),

    );
  }

}
