import 'package:ecom/model/dashboard/getDashboardProducts.dart';
import 'package:ecom/screen/product/product_details_screen.dart';
import 'package:ecom/utils/string.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../widgets/appbar_title.dart';
import '../splash_screen.dart';

// ignore: must_be_immutable
class TopSellingProductScreen extends StatefulWidget {
  List<GetDashBoardProducts> top_selling_products;
  TopSellingProductScreen({required this.top_selling_products});

  @override
  State<TopSellingProductScreen> createState() => _TopSellingProductScreenState();
}

class _TopSellingProductScreenState extends State<TopSellingProductScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBarTitle().appbar(setState, context, TOP_SELL,true),
      body:  Container(
        height: size.height,
        padding:  EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: size.height*0.03),
        child: SingleChildScrollView(
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            addRepaintBoundaries: true,
            itemCount: widget.top_selling_products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 3.0,
              crossAxisSpacing: 9.0,
              childAspectRatio: size.height*0.00095,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: size.width*0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(productsParent: widget.top_selling_products[index] ,)));
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Color.fromARGB(231, 184, 182, 182),
                              height: size.height*0.28,
                              width: size.width*0.45,
                              child: Image.network(
                                widget.top_selling_products[index].images[0].src,
                                fit: BoxFit.fill,
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.001,
                    ),
                    Container(
                      width: size.width*0.40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "${widget.top_selling_products[index].title}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: TITLE_COLOR,
                                  fontSize: size.width*0.043,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),

                          SizedBox(
                            width: size.width*0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${widget.top_selling_products[index].price} ${currencyCode}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: PRICE_COLOR,
                                    fontSize: size.width*0.043,
                                    fontWeight: FontWeight.normal
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.01,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
