import 'package:ecom/provider/connectivity_provider.dart';
import 'package:ecom/screen/connectivity_screen.dart';
import 'package:ecom/utils/colors.dart';
import 'package:ecom/widgets/appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/dashboard/getDashboardProducts.dart';
import '../../model/product/getProductsParent.dart';
import '../../provider/wishlist_provider.dart';
import '../../utils/string.dart';
import '../splash_screen.dart';


class FavouriteScreen extends StatefulWidget {
  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {

  late List<GetDashBoardProducts> favList;

  @override
  void initState() {
    // TODO: implement initState

    context.read<ConnectivityProvider>().checkConnection();
    getData();
    super.initState();

  }

  getData()async{

    final wishlistProvider = Provider.of<WishlistProvider>(context, listen: false);
    favList= await wishlistProvider.getWishlistPref();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return Scaffold(
      appBar: AppBarTitle().appbar(setState, context, WISHLIST,false),
      backgroundColor: BACKGROUND_COLOR,
      body: !context.read<ConnectivityProvider>().isConnected?connectivityData(context: context,OnTap: (){
        context.read<ConnectivityProvider>().checkConnection();
        getData();
      }): Container(
        child:wishlistProvider.isApiLoading?Center(child: CircularProgressIndicator(
          color: CIRCULAR_INDICATOR_COLOR,
        )): ListView(
            children: favList.length==0? [
              Container(
               height:600,
               alignment: Alignment.center,
                child: Text(
                  WISHLIST_EMPTY,
                  overflow: TextOverflow.fade,
                    style: TextStyle(
                        color: TEXT_COLOR,
                        fontSize: size.width*0.045,
                        fontWeight: FontWeight.w400
                    )
                ),
              )]:favList.map((product) {
              return wishlistProducts(product);
            }).toList()
        ),
      ),
    );
  }

  Widget wishlistProducts(GetProductsParent product ) {

    var size = MediaQuery.of(context).size;
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    // ignore: unnecessary_null_comparison
    if(product==null)
      return Container(child: Center(child: Text(WISHLIST_EMPTY),),);
    return Column(
      children: [
        SizedBox(height: size.width*0.03,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: size.width*0.03,vertical:size.width*0.01),
          decoration: BoxDecoration(
            color: CARD_BACKGROUND_COLOR,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.02,vertical: size.width*0.02),
                height: size.width*0.25,
                width: size.width*0.25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    product.images[0].src,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                width: size.width*0.60,
                padding: EdgeInsets.symmetric(vertical: size.height*0.023),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width*0.50,
                          child: Text(
                            product.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: TITLE_COLOR,
                                fontSize:size.width*0.045,
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
                                        child: Text(DELETE_WISHLIST_MSG,
                                          style: TextStyle(
                                              color: TITLE_COLOR,
                                              fontSize: 16
                                          ),
                                        )
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: ()async {
                                          Navigator.pop(context);
                                          wishlistProvider.removeFromWishList(product.id).then((value) {
                                            getData();
                                          });
                                        },
                                        child:
                                        Text( YES ,style: TextStyle(
                                            color: TEXT_COLOR,
                                            fontSize: 14
                                        ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                        child: Text(NO,style: TextStyle(
                                            color: TEXT_COLOR,
                                            fontSize: 14
                                        ),
                                        ),
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
                          "Price: ",
                          style: TextStyle(
                              color: TEXT_COLOR,
                              fontSize:size.width*0.043,
                              fontWeight: FontWeight.normal
                          ),
                        ),
                        Text(
                          product.price.isEmpty?"0.0 ${currencyCode}":product.price +" ${currencyCode}",
                          style: TextStyle(
                              color: PRICE_COLOR,
                              fontSize:size.width*0.043,
                              fontWeight: FontWeight.normal
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: size.width*0.01,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
