import 'package:ecom/provider/connectivity_provider.dart';
import 'package:ecom/screen/connectivity_screen.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import '../../model/dashboard/getDashboardProducts.dart';
import '../../model/order/createOrderModel.dart';
import '../../model/product/getProductsParent.dart';
import '../../provider/cart_provider.dart';
import '../../provider/wishlist_provider.dart';
import '../../utils/colors.dart';
import '../../utils/html_tag.dart';
import '../../utils/string.dart';
import 'package:collection/collection.dart';
import '../splash_screen.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatefulWidget {
  GetProductsParent productsParent;
  ProductDetailsScreen({required this.productsParent});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  Map<String, String> optionSelected = Map();
  Variations? variation;
   bool isCartItem=false;
   bool isWishListItem=false;
  late List<Line_items> cartList;
  late List<GetDashBoardProducts> favList;

  void initState() {
    super.initState();
    // TODO: implement initState
    getData();
  }

  getData()async{
    context.read<ConnectivityProvider>().checkConnection();
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final wishlistProvider = Provider.of<WishlistProvider>(context, listen: false);
    cartList= await cartProvider.getCartProductsPref();
    favList= await wishlistProvider.getWishlistPref();
    isCartItem = await cartList.firstWhereOrNull((element) => element.product_id==widget.productsParent.id )!=null;
    isWishListItem = await favList.firstWhereOrNull((element) => element.id==widget.productsParent.id )!=null;
  }

  @override
  Widget build(BuildContext context) {
    var sizes= MediaQuery.of(context).size;
    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: !context.read<ConnectivityProvider>().isConnected?connectivityData(context: context,OnTap: (){
        getData();
      }): SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                  children:[
                    Container(
                      width: sizes.width,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: sizes.height*0.35,
                                width: sizes.width,
                                child:Image.network(
                                  widget.productsParent.images[0].src,
                                  fit: BoxFit.cover,) ,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: sizes.width*0.02,vertical: sizes.height*0.01),
                                      child: Icon(
                                        Icons.arrow_back,
                                        size: sizes.height*0.03,
                                        color: ICON_COLOR,
                                      ),
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: sizes.width*0.02,vertical: sizes.height*0.02),
                                    height: sizes.width*0.10,
                                    width: sizes.width*0.10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: Colors.white),
                                    child: Center(
                                      child: LikeButton(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          padding: EdgeInsets.only(left: 2.0),
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          onTap: (value)async{

                                            if(isWishListItem){
                                              wishlistProvider.removeFromWishList(widget.productsParent.id).then((value) {
                                                getData();
                                              });
                                            }else{
                                              wishlistProvider.addWishlistPref(widget.productsParent as GetDashBoardProducts).then((value) {
                                                getData();
                                              });
                                            }
                                            return null;
                                          },
                                          size: 25.0,
                                          circleColor: CircleColor(
                                              start: Color(0xff00ddff),
                                              end: Color(0xff0099cc)),
                                          bubblesColor: BubblesColor(
                                            dotPrimaryColor: Color(0xff33b5e5),
                                            dotSecondaryColor: Color.fromARGB(255, 2, 35, 46),
                                          ),
                                          likeBuilder: (bool isLiked) {
                                            return Icon(
                                              isWishListItem
                                                  ? Icons.favorite_rounded:Icons.favorite_outline,
                                              color: isWishListItem ? Colors.red : Colors.red,
                                              size: 20.0,
                                            );
                                          }),
                                    ),
                                  ),

                                ],
                              ),
                              widget.productsParent.on_sale?
                              Positioned(
                                left: 1,
                                top: 70,
                                child: Container(
                                  height: sizes.height*0.04,
                                  width: sizes.width*0.15,
                                  child: Image.asset(
                                    "Images/sale.png",
                                    fit: BoxFit.fill,
                                    //   height: 300.0,
                                  ),
                                ),
                              ):
                              Container()
                            ],
                          ),
                          SizedBox(height: sizes.width*0.02,),
                          Container(
                             padding: EdgeInsets.symmetric(horizontal: sizes.width*0.02,vertical: sizes.width*0.02),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: sizes.width*0.55,
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        widget.productsParent.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: HEADING_TEXT_COLOR,
                                            fontSize:sizes.width*0.065,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    widget.productsParent.featured
                                        ?
                                    Row(
                                      children: [
                                        Icon(Icons.api, color: ICON_COLOR, size: 22,),
                                        SizedBox(width: sizes.width*0.02,),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            FEATURED_PRODUCT,
                                            style: TextStyle(
                                                color: TEXT_COLOR,
                                                fontSize:sizes.width*0.040,
                                                fontWeight: FontWeight.w300
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                        :
                                    Container(),
                                  ],
                                ),

                                // SizedBox(height: sizes.width*0.02,),
                                //
                                // Row(
                                //   children: [
                                //     Container(
                                //       child: Text(
                                //         ON_SALE +":",
                                //         style: TextStyle(
                                //             color: TITLE_COLOR,
                                //             fontSize:sizes.width*0.040,
                                //             fontWeight: FontWeight.w500
                                //         ),
                                //       ),
                                //     ),
                                //     Container(
                                //       child: Text(
                                //         widget.productsParent.on_sale?YES:NO,
                                //         style: TextStyle(
                                //             color: TEXT_COLOR,
                                //             fontSize:sizes.width*0.040,
                                //             fontWeight: FontWeight.w300
                                //         ),
                                //       ),
                                //     ),
                                //     SizedBox(height: sizes.width*0.02,),
                                //   ],
                                // ),


                                // Row(
                                //   children: [
                                //     Container(
                                //       child: Text(
                                //         AVAILABILITY+":",
                                //         style: TextStyle(
                                //             color: TITLE_COLOR,
                                //             fontSize:sizes.width*0.040,
                                //             fontWeight: FontWeight.w500
                                //         ),
                                //       ),
                                //     ),
                                //     Container(
                                //       child: Text(
                                //         widget.productsParent.in_stock?IN_STOCK:OUT_OF_STOCK,
                                //         style: TextStyle(
                                //             color: TEXT_COLOR,
                                //             fontSize:sizes.width*0.040,
                                //             fontWeight: FontWeight.w300
                                //         ),
                                //       ),
                                //     ),
                                //
                                //   ],
                                // ),
                                // SizedBox(height: sizes.width*0.02,),

                                Container(
                                    margin: EdgeInsets.only(top: 4),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        widget.productsParent.short_description==""?Container(): Column(
                                          children: [
                                            // Container(
                                            //   alignment: Alignment.topLeft,
                                            //   child: Text(
                                            //     SHORT_DESCRIPTION,
                                            //     style: TextStyle(
                                            //         color: HEADING_TEXT_COLOR,
                                            //         fontSize:sizes.width*0.050,
                                            //         fontWeight: FontWeight.bold
                                            //     ),
                                            //   ),
                                            // ),
                                            SizedBox(height: sizes.width*0.02,),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              width: sizes.width*0.70,
                                              child: Text(
                                                removeAllHtmlTags(widget.productsParent.short_description),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: TEXT_COLOR,
                                                    fontSize:sizes.width*0.040,
                                                    fontWeight: FontWeight.w300
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: sizes.width*0.02,),
                                          ],
                                        ),
                                        Flexible(
                                          child: Container(
                                            child: getReviews(widget.productsParent.average_rating,widget.productsParent.rating_count),
                                          ),
                                        ),
                                      ],
                                    )
                                ),

                                // Row(
                                //   children: [
                                //     Container(
                                //       child: Text(
                                //         SALES +":",
                                //         style: TextStyle(
                                //             color: TITLE_COLOR,
                                //             fontSize:sizes.width*0.040,
                                //             fontWeight: FontWeight.w500
                                //         ),
                                //       ),
                                //     ),
                                //     Container(
                                //       child: Text(
                                //         widget.productsParent.total_sales.toString(),
                                //         style: TextStyle(
                                //             color: TEXT_COLOR,
                                //             fontSize:sizes.width*0.040,
                                //             fontWeight: FontWeight.w300
                                //         ),
                                //       ),
                                //     ),
                                //     SizedBox(height: sizes.width*0.02,),
                                //   ],
                                // ),


                                Column(
                                  children: [
                                    widget.productsParent.attributes.length>0?Column(
                                      children: [
                                        Divider(thickness: 1,
                                          color: DIVIDER_COLOR,
                                        ),
                                        SizedBox(height: sizes.width*0.02,),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            VARIANTS,
                                            style: TextStyle(
                                                color: HEADING_TEXT_COLOR,
                                                fontSize:sizes.width*0.050,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: sizes.width*0.02,),

                                      ],
                                    ):Container(),
                                    Container(
                                      child: getAttributes(widget.productsParent),
                                    ),

                                    SizedBox(height: sizes.width*0.02,),
                                    Divider(thickness: 1,
                                      color: DIVIDER_COLOR,
                                    ),
                                    SizedBox(height: sizes.width*0.02,),
                                  ],
                                ),



                                widget.productsParent.description==""?Container(): Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        DESCRIPTION,
                                        style: TextStyle(
                                            color: HEADING_TEXT_COLOR,
                                            fontSize:sizes.width*0.050,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: sizes.width*0.02,),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        removeAllHtmlTags(widget.productsParent.description),
                                        maxLines: 9,
                                        style: TextStyle(
                                            color: TEXT_COLOR,
                                            fontSize:sizes.width*0.040,
                                            fontWeight: FontWeight.w300
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: sizes.height*0.15,),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ]
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: sizes.height*0.16,
                padding: EdgeInsets.symmetric(horizontal: sizes.width*0.02,vertical: sizes.width*0.02),
                decoration: BoxDecoration(
                  color: CARD_BACKGROUND_COLOR,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: sizes.height*0.02,),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal:sizes.width*0.03 ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    PRICE ,
                                    style: TextStyle(
                                        color: TITLE_COLOR,
                                        fontSize:sizes.width*0.050,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                SizedBox(height: sizes.height*0.005,),
                                Flexible(
                                  child: Row(
                                    children: [
                                      Text(
                                        "${widget.productsParent.price} ${currencyCode}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: PRICE_COLOR,
                                            fontSize:sizes.width*0.050,
                                            fontWeight: FontWeight.normal
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                                onTap: (){
                                  if(isCartItem){
                                    cartProvider.delCartProductsPref(widget.productsParent.id).then((value) {
                                      getData();
                                    });
                                  }else{
                                    cartProvider.addOrUpdateCartProductsPref(Line_items(widget.productsParent.id, variation == null ? -1 : variation!.id, 1,widget.productsParent as GetDashBoardProducts)).then((value) {
                                      getData();
                                    });
                                  }

                                },
                                child: Container(
                                  height: sizes.height*0.08,
                                  padding: EdgeInsets.symmetric(horizontal: sizes.width*0.07,),
                                  decoration: BoxDecoration(
                                    color: BUTTON_COLOR,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                      child: Text(
                                        isCartItem?REMOVE_TO_CART:ADD_TO_CART,
                                        overflow: TextOverflow.ellipsis,
                                        style:TextStyle(
                                            color: Colors.white,
                                            fontSize: sizes.width*0.050,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                  ),
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
        ),
      ),
    );
  }

  Widget getReviews( average_rating,rating_count){
    int rating =double.parse(average_rating).floor();
    return Row(
      children: <Widget>[
        rating==0?  Row(
          children: List.generate(5-rating, (index)  {
            return Icon(
              Icons.star_border,
              size: 16,
              color: ICON_COLOR,
            );
          }),
        ):Row(
            children: []..addAll(
                List.generate(rating, (index)  {
                  return Icon(
                    Icons.star,
                    size: 16,
                    color: ICON_COLOR,
                  );
                })
            )..addAll(
                List.generate(5-rating, (index)  {
                  return Icon(
                    Icons.star_border,
                    size: 16,
                    color: ICON_COLOR,
                  );
                })
            )..add( Text(
              '  ( ${rating_count} )',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: "Normal",
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: ICON_COLOR,
              ),
            ),)
        ),
      ],
    );
  }

  Widget getAttributes(GetProductsParent thisProduct) {
    List<ProductAttributes> attributes = thisProduct.attributes;
    var sizes= MediaQuery.of(context).size;

    // ignore: unnecessary_null_comparison
    return (attributes != null && attributes.length > 0) ? Card(
      child: Container(
          color: Color(0xffe0dfdf),
          padding: EdgeInsets.all(10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: []
                ..addAll(attributes.map((attr) {
                  return attr.visible ?
                  Container(
                    child: Wrap(
                        direction: Axis.vertical,
                        children: []..add(
                          Text(
                            attr.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: TEXT_COLOR,
                                fontSize: sizes.width*0.040,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )..add(
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: attr.options.map((options) {

                                  var foundOptionInVariant = false;
                                  if (optionSelected.length > 0 && !optionSelected.containsKey(attr.name)) {
                                    thisProduct.variations.forEach((variant) {

                                      var attributeFound = true;
                                      variant.attributes.forEach((varAttr) {

                                        var viewMatchVarAttr=(attr.name.toLowerCase()==varAttr.name.toLowerCase()&& (options.toLowerCase()==varAttr.option.toLowerCase()||varAttr.option==""));
                                        var selectedMatchVarAttr=(optionSelected.containsKey(varAttr.name)&& (varAttr.option.toLowerCase()== optionSelected[varAttr.name]!.toLowerCase()||varAttr.option==""));
                                        var nonSelectedVarAttr=!optionSelected.containsKey(varAttr.name)&& attr.name.toLowerCase()!= varAttr.name.toLowerCase();

                                        if(!viewMatchVarAttr&&!selectedMatchVarAttr&& !nonSelectedVarAttr){
                                          attributeFound=false;
                                        }
                                        else
                                          print("");

                                      });
                                      if(attributeFound)
                                        foundOptionInVariant=true;
                                      else
                                        print("");

                                    });

                                  }
                                  else  if ( optionSelected.containsKey(attr.name)) {
                                    var selectedMatchView=(optionSelected.containsKey(attr.name)&& (options.toLowerCase()== optionSelected[attr.name]!.toLowerCase() ));
                                    print("");
                                    if(selectedMatchView){
                                      foundOptionInVariant=true;
                                    }
                                  }
                                  else
                                    foundOptionInVariant = true;

                                  print("");
                                  return foundOptionInVariant ? GestureDetector(
                                    onTap: () {
                                      optionSelected[attr.name] = options;
                                      setState(() {});
                                    },
                                    child: Container(
                                      constraints: BoxConstraints(minWidth: 60),
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          border: Border.all(color: Colors.black, width: 1),
                                          color: (optionSelected.containsKey(attr.name) && optionSelected[attr.name] == options)
                                              ?  Color(0xff7c7878)
                                              : Colors.transparent
                                      ),
                                      child: Text(
                                        options,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: (optionSelected.containsKey(
                                                attr.name) &&
                                                optionSelected[attr.name] ==
                                                    options)
                                                ? Colors.white
                                                : TEXT_COLOR,
                                            fontSize: sizes.width*0.040,
                                            fontWeight: FontWeight.normal
                                        ),
                                      ),
                                    ),
                                  ) : Container();
                                }).toList(),
                              ),
                            )
                        )..add(
                              GestureDetector(
                                onTap: () {
                                  optionSelected = Map();
                                  setState(() {});
                                },
                                child: Container(
                                  width: sizes.width*0.85,
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    CLEAR,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: sizes.width*0.045,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              )
                          )
                    ),
                  ) : Container();
                }).toList()
                )

          )
      ),
    ) : Container();
  }
}


