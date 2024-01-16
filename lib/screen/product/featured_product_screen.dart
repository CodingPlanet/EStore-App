import 'package:ecom/screen/product/product_details_screen.dart';
import 'package:ecom/utils/string.dart';
import 'package:flutter/material.dart';
import '../../model/product/getProductsParent.dart';
import '../../utils/colors.dart';
import '../../widgets/appbar_title.dart';
import '../splash_screen.dart';

// ignore: must_be_immutable
class FeaturedProductScreen extends StatefulWidget {
  List<GetProductsParent> Featured;
  FeaturedProductScreen({required this.Featured});

  @override
  State<FeaturedProductScreen> createState() => _FeaturedProductScreenState();
}

class _FeaturedProductScreenState extends State<FeaturedProductScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBarTitle().appbar(setState, context, FEATURED_PRODUCT,true),
      body:  Container(
          height: size.height,
          padding:  EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: size.height*0.03),
          child: SingleChildScrollView(
            child: Container(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  addRepaintBoundaries: true,
                  itemCount: widget.Featured.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: size.width*0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(productsParent: widget.Featured[index],)));
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    color: Color.fromARGB(231, 184, 182, 182),
                                    height: size.height*0.28,
                                    width: size.width*0.45,
                                    child: Image.network(
                                      widget.Featured[index].images[0].src,
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
                                    "${widget.Featured[index].title}",
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
                                      "${widget.Featured[index].price} ${currencyCode}",
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
                  },  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 3.0,
                  crossAxisSpacing: 9.0,
                  childAspectRatio: size.height*0.00095,
                ),
                )

            ),
          ),
        ),
    );
  }
}
