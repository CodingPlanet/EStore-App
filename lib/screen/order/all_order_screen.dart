import 'package:ecom/provider/connectivity_provider.dart';
import 'package:ecom/provider/order_provider.dart';
import 'package:ecom/screen/connectivity_screen.dart';
import 'package:ecom/screen/order/order_detail_screen.dart';
import 'package:ecom/utils/colors.dart';
import 'package:ecom/utils/string.dart';
import 'package:ecom/widgets/appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({Key? key}) : super(key: key);

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData(){
    context.read<ConnectivityProvider>().checkConnection();
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    orderProvider.OrderListData(context: context, OrderId: 0, isShowOrderList: true);
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final orderProviders = Provider.of<OrderProvider>(context);
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Scaffold(
            backgroundColor: BACKGROUND_COLOR,
            appBar: AppBarTitle().appbar(setState, context, ORDERS_LIST,true),
            body: !context.read<ConnectivityProvider>().isConnected?connectivityData(context: context,OnTap: (){
              getData();
            }):
            orderProviders.isApiLoading?Center(child: CircularProgressIndicator(
              color: CIRCULAR_INDICATOR_COLOR,))
                :
            orderProviders.getOrderData.isEmpty?
            Center(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                    ORDER_EMPTY,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        color: TEXT_COLOR,
                        fontSize: size.width*0.045,
                        fontWeight: FontWeight.w400
                    )
                ),
              ),
            ): SingleChildScrollView(
              child: Container(
                width: size.width,
                margin: EdgeInsets.only(top: size.height*0.01),
                child: Column(
                  children: orderProviders.getOrderData.map((e) {
                    return   GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderDetailsScreen(OrderId: e.id.toString(),getOrderList:e ,)));
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(horizontal: size.width*0.02,vertical: size.width*0.02),
                        color: CARD_BACKGROUND_COLOR,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width*0.02,vertical: size.width*0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text("Order#: ${e.number}", style: TextStyle(
                                              fontSize: size.width*0.045,
                                              color:APPBAR_TEXT_COLOR,
                                              fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                        SizedBox(height: size.height*0.01,),
                                        Container(
                                          child: Text("${e.dateCreated.date}", style: TextStyle(
                                              fontSize: size.width*0.040,
                                              color:APPBAR_TEXT_COLOR,
                                              fontWeight: FontWeight.normal
                                          ),),
                                        ),
                                        SizedBox(height: size.height*0.01,),
                                        Container(
                                          child: Text("Status: ${e.status}", style: TextStyle(
                                              fontSize: size.width*0.040,
                                              color:APPBAR_TEXT_COLOR,
                                              fontWeight: FontWeight.normal
                                          ),),
                                        ),
                                      ],
                                    ),
                                  ]

                              ),
                              Container(child: Icon(Icons.arrow_forward_ios,color: ICON_COLOR,size: size.width*0.060,),)
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        });
  }
}
