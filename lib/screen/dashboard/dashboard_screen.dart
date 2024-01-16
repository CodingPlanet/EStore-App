import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom/provider/connectivity_provider.dart';
import 'package:ecom/screen/cart/cart_screen.dart';
import 'package:ecom/screen/category/category_by_product_screen.dart';
import 'package:ecom/screen/dashboard/search_screen.dart';
import 'package:ecom/screen/product/featured_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import '../../model/dashboard/getDashboardProducts.dart';
import '../../model/order/createOrderModel.dart';
import '../../model/product/getProductsParent.dart';
import '../../provider/cart_provider.dart';
import '../../provider/dashboard_provider.dart';
import '../../provider/wishlist_provider.dart';
import '../../utils/colors.dart';
import '../../utils/dashBoardBloc.dart';
import '../../utils/enum/screenStatus.dart';
import '../../utils/paginator.dart';
import '../../utils/string.dart';
import '../connectivity_screen.dart';
import '../product/product_details_screen.dart';
import '../product/top_selling_product_screen.dart';
import '../splash_screen.dart';
import 'package:collection/collection.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

var sizes;
class _DashboardScreenState extends State<DashboardScreen> {

  bool isCartItem=false;
   bool isWishListItem=false;
  late List<Line_items> cartList;
   late List<GetDashBoardProducts> favList;
  Variations? variation;


  @override
  void initState() {
    // TODO: implement initState
    context.read<ConnectivityProvider>().checkConnection();
    super.initState();
  }

  getData()async{
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final wishlistProvider = Provider.of<WishlistProvider>(context, listen: false);
    cartList= await cartProvider.getCartProductsPref();
    favList= await wishlistProvider.getWishlistPref();
    for(var i in favList){
       getWishListData(i.id.toString());
     }

  }

  getWishListData(String id)async{
    final wishlistProvider = Provider.of<WishlistProvider>(context,listen: false );
    favList= await wishlistProvider.getWishlistPref();

    isWishListItem = await favList.firstWhereOrNull((element) {
      return element.id.toString()==id;} )!=null;
  }

  getCartData(String id)async{
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartList= await cartProvider.getCartProductsPref();

    isCartItem = await cartList.firstWhereOrNull((element) {
      return element.product_id.toString()==id;} )!=null;
  }

  @override
  Widget build(BuildContext context) {

    sizes = MediaQuery.of(context).size;
    final  dashboardProvider  = Provider.of<DashboardProvider>(context , listen: true);

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: Text(HOME, style: GoogleFonts.ubuntu(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: (() {
          }),
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Image.asset(
              'Images/icon.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        actions: [

          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder:  (context)=>CartScreen(isArrowAppBar: true)));
            },
            child: Padding(
              padding: EdgeInsets.only(top: 13, right: 4),
              child: Badge(
                label:Consumer<CartProvider>(
                   builder: (context, value, child) {
                     return Text(
                       "${value.cartCounter.length}",
                       style: const TextStyle(
                           color: Colors.white, fontWeight: FontWeight.bold),
                     );
                   },
                 ),
                child:  Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),

          GestureDetector(
            onTap: (() {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
            }),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.search,color: ICON_COLOR),
            ),
          ),
        ],

        iconTheme: IconThemeData(color: Colors.grey[900]),
      ),
      body: !context.read<ConnectivityProvider>().isConnected?connectivityData(context: context,OnTap: (){
        final dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
        dashboardProvider.getDashboard(dashboard_page, context)
            .then((value) {
          if (value != null) {
            refreshNewDashboardData(value);
            dashboardBloc.refreshDashboards(true);
          }
        });
        dashboardProvider.getCategory(context);
        dashboardProvider.getSlider(context);
      }): SafeArea(
        child: NotificationListener(
          onNotification: _onScrollNotification,
          child: StreamBuilder(
            initialData: true,
            stream: dashboardBloc.getDashboardStreamController.stream,
            builder: (context, snapshot) {
              List<Widget> widgetList = []
                ..add(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        dashboardProvider.isApiLoading && (  dashboardProvider.sliderList!=0)?ListTileShimmer(isPurplishMode: false, hasBottomBox: false, isDarkMode: false,):
                        CarouselSlider.builder(
                          options: CarouselOptions(
                            height: 150,
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                          itemCount: dashboardProvider.sliderList.length,
                          itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) {
                            return Container(
                              width: sizes.width*0.95,
                              child: Image.network(dashboardProvider.sliderList[itemIndex],fit: BoxFit.fill),
                            );
                          }
                        ),
                        SizedBox(
                          height: sizes.height*0.02,
                        ),
                        CategoryProduct(),
                        SizedBox(height: sizes.height*0.02,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Summer Sale",
                                  overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: TITLE_COLOR,
                                        fontSize: sizes.width*0.045,
                                        fontWeight: FontWeight.bold
                                    ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, ),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      height: sizes.height*0.30,
                                      width: sizes.width*0.45,
                                      child: Image.asset(
                                        "Images/hrxpromo.webp",
                                        fit: BoxFit.fill,
                                        //   height: 300.0,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Align(
                                    // alignment: Alignment.topLeft,
                                    child: Container(
                                      height: sizes.height*0.30,
                                      width: sizes.width*0.45,
                                      child: Image.asset(
                                        "Images/wrongpromotion.webp",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: sizes.height*0.02,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Featured Brands",
                                 overflow: TextOverflow.ellipsis,
                                 style: TextStyle(
                                    color: TITLE_COLOR,
                                    fontSize: sizes.width*0.045,
                                    fontWeight: FontWeight.bold
                                ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: sizes.height*0.20,
                                        width: sizes.width*0.50,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 196, 18, 48),
                                          //borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            "Images/Levis-Logo.png",
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Container(
                                          height: sizes.height*0.20,
                                          width: sizes.width*0.45,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Image.asset(
                                            "Images/levisdiscount.webp",
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Levis's",
                                    style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w700, fontSize: 18.0),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Shirt,Jeans,Hoodie",
                                    style: GoogleFonts.openSans(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: sizes.height*0.02,),
                        TopSelling(),
                        SizedBox(height: sizes.height*0.02,),
                        FeaturedProduct(featured_products),
                         SizedBox(height: sizes.height*0.02,),
                      ],
                    )
                )..add(
                  AllProduct(),
                )..add(
                    status==ScreenStatus.bussy?Center(child: Container(child: CircularProgressIndicator(color: CIRCULAR_INDICATOR_COLOR,),height: 30,width: 30,) ):Container(height: 40,)
                );
              return ListView.builder(
                shrinkWrap: true,
                itemCount: widgetList.length,
                itemBuilder: (context, index) {
                  return widgetList[index];
                },
              );
            }
          ),
        ),
      ),
    );
  }



  Widget CategoryProduct() {
    final  dashboardProvider  = Provider.of<DashboardProvider>(context , listen: true);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: sizes.width*0.02),
           width: sizes.width*0.94,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text(
              //   CATEGORY,
              //   maxLines: 2,
              //   overflow: TextOverflow.ellipsis,
              //   style: TextStyle(
              //       color: TITLE_COLOR,
              //       fontSize: sizes.width*0.045,
              //       fontWeight: FontWeight.bold
              //   ),
              // ),
            ],
          ),
        ),
        SizedBox(height: sizes.height*0.007,),
        // ignore: unnecessary_null_comparison
        (dashboardProvider.categoryList!=null && dashboardProvider.categoryList.length!=0)?
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // ignore: unnecessary_null_comparison
            child: (dashboardProvider.categoryList!=null && dashboardProvider.categoryList.length!=0) ?Row(
              children: dashboardProvider.categoryList.map((e) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryByProductScreen(title: e.name,Id: e.termId.toString(),)));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: sizes.width*0.03),
                      child: Column(
                        children: [
                          e.image.runtimeType==String?
                          Container(
                            height: sizes.width*0.15,
                            width: sizes.width*0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[200],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.network(
                                e.image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ):
                          Container(
                            height: sizes.width*0.15,
                            width: sizes.width*0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[200],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(
                                'Images/icon.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(height: 4,),


                          Text(
                            e.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: TITLE_COLOR,
                                fontSize: sizes.width*0.040,
                                fontWeight: FontWeight.normal
                            ),
                          ),

                        ],
                      )),
                );

              }).toList(),
            ): ListTileShimmer(isPurplishMode: false, hasBottomBox: false, isDarkMode: false,),
          ),
        ): ListTileShimmer(isPurplishMode: false, hasBottomBox: false, isDarkMode: false,),
      ],
    );
  }

  Widget TopSelling() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: sizes.width*0.02),
          margin: EdgeInsets.symmetric(horizontal: sizes.width*0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                TOP_SELL,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: TITLE_COLOR,
                    fontSize: sizes.width*0.045,
                    fontWeight: FontWeight.bold
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> TopSellingProductScreen(top_selling_products: top_selling_products)));
                },
                  child: Icon(Icons.arrow_forward,color: ICON_COLOR))
            ],
          ),
        ),
        SizedBox(height: sizes.height*0.007,),
        // ignore: unnecessary_null_comparison
        (top_selling_products!=null && top_selling_products.length!=0) ?Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: top_selling_products.map((e) {
                return
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(productsParent: e,)));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: sizes.width*0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                color: Color.fromARGB(231, 184, 182, 182),
                                height: sizes.height*0.22,
                                width: sizes.width*0.40,
                                child: Image.network(
                                  e.images[0].src,
                                  fit: BoxFit.fill,
                                ),
                              )),
                          SizedBox(
                            height: sizes.height*0.001,
                          ),
                          Container(
                            width: sizes.width*0.40,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    e.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: TITLE_COLOR,
                                      fontSize: sizes.width*0.043,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Text(
                                  "${e.price} ${currencyCode}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                   style: TextStyle(
                                    color: Colors.red,
                                    fontSize: sizes.width*0.043,
                                    fontWeight: FontWeight.normal
                                ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
              }).toList(),
            ),
          ),
        ):ListTileShimmer(isPurplishMode: false, hasBottomBox: false, isDarkMode: false,),
      ],
    );
  }

  Widget FeaturedProduct(List<GetProductsParent> featured) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: sizes.width*0.02),
          margin: EdgeInsets.symmetric(horizontal: sizes.width*0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                FEATURED_PRODUCT,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: TITLE_COLOR,
                    fontSize: sizes.width*0.045,
                    fontWeight: FontWeight.bold
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> FeaturedProductScreen(Featured: featured,)));
                },
                  child: Icon(Icons.arrow_forward,color: ICON_COLOR))
            ],
          ),
        ),
        SizedBox(height: sizes.height*0.007,),
        // ignore: unnecessary_null_comparison
        (featured!=null && featured.length!=0)?Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: featured.map((e) {

                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(productsParent: e,)));
                    },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: sizes.width*0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Color.fromARGB(231, 184, 182, 182),
                              height: sizes.height*0.22,
                              width: sizes.width*0.40,
                              child: Image.network(
                                e.images[0].src,
                                fit: BoxFit.fill,
                              ),
                            )),
                        SizedBox(
                          height: sizes.height*0.001,
                        ),
                        Container(
                          width: sizes.width*0.40,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "${e.title}",
                                  overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: TITLE_COLOR,
                                        fontSize: sizes.width*0.043,
                                        fontWeight: FontWeight.bold
                                    ),
                                ),
                              ),

                              Text(
                                "${e.price} ${currencyCode}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: PRICE_COLOR,
                                    fontSize: sizes.width*0.043,
                                    fontWeight: FontWeight.normal
                                ),
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                );

              }).toList(),
            ),
          ),
        ): ListTileShimmer(isPurplishMode: false, hasBottomBox: false, isDarkMode: false,),
      ],
    );
  }

  Widget AllProduct() {
    return  Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: sizes.width*0.02),
          margin: EdgeInsets.symmetric(horizontal: sizes.width*0.02),
          alignment: Alignment.topLeft,
          child: Text(
            ALL_PRODUCT,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                fontSize: sizes.width*0.045,
                color: TITLE_COLOR,
            ),
          ),
        ),
        SizedBox(height: sizes.height*0.007,),
        // ignore: unnecessary_null_comparison
        (totalProducts!=null && totalProducts.length!=0) ?
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          addRepaintBoundaries: true,
          itemCount: totalProducts.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(productsParent: totalProducts[index],)));
                },
                child:
                HomeProductListItem().itemView(totalProducts[index],(){setState(() {});},context)
            );
          },  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 3.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: sizes.height*0.00085,
        ),
        ):
        ListTileShimmer(isPurplishMode: false, hasBottomBox: false, isDarkMode: false,),
      ],
    );
  }

  Widget ProductList(GetDashBoardProducts data,Function refresh ) {
    final wishlistProvider = Provider.of<WishlistProvider>(context,);
    final cartProvider = Provider.of<CartProvider>(context,);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: sizes.width*0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
              children:[
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(productsParent: data,)));
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Color.fromARGB(231, 184, 182, 182),
                        height: sizes.height*0.22,
                        width: sizes.width*0.45,
                        child: Image.network(
                          data.images[0].src,
                          fit: BoxFit.fill,
                        ),
                      )),
                ),

                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: sizes.width*0.02,vertical: sizes.height*0.01),
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
                              wishlistProvider.removeFromWishList(data.id).then((value) async{
                                getWishListData(data.id.toString());
                              });
                            }else{
                              wishlistProvider.addWishlistPref(data).then((value) async{
                                getWishListData(data.id.toString());
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
                )
              ]
          ),
          SizedBox(
            height: sizes.height*0.001,
          ),
          Container(
            width: sizes.width*0.40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "${data.title}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: TITLE_COLOR,
                        fontSize: sizes.width*0.043,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                SizedBox(
                  width: sizes.width*0.02,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${data.price} ${currencyCode}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: PRICE_COLOR,
                          fontSize: sizes.width*0.043,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        if(isCartItem){
                          cartProvider.delCartProductsPref(data.id).then((value) async{
                            getCartData(data.id.toString());

                          });
                        }else{
                          cartProvider.addOrUpdateCartProductsPref(Line_items(data.id, variation == null ? -1 :variation!.id, 1,data )).then((value) async{
                            getCartData(data.id.toString());
                          });
                        }
                      },
                      child: Container(
                        height: sizes.width*0.10,
                        padding: EdgeInsets.symmetric(horizontal: sizes.width*0.04),
                        decoration: BoxDecoration(
                          color: ICON_BACKGROUND_COLOR,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                            child: Icon(isCartItem?Icons.shopping_cart:Icons.shopping_cart_outlined,color:ICON_COLOR,)
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  ScreenStatus status=ScreenStatus.active;
  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      final before = notification.metrics.extentBefore;
      final max = notification.metrics.maxScrollExtent;
      if (before == max &&  status==ScreenStatus.active) {
        status=ScreenStatus.bussy;
        dashboardBloc.refreshDashboards(true);
        loadNewDashboardData(context: context).then((value) {
          status=ScreenStatus.active;
          dashboardBloc.refreshDashboards(true);
        });
      }else{
      }
    }
    return false;
  }
}



class HomeProductListItem {
  bool isWishListItem=false;
  late List<GetDashBoardProducts> favList;
  late List<Line_items> cartLists;
  bool isCartItems=false;

  getWishListDatas(String id,BuildContext context )async{
    final wishlistProvider = Provider.of<WishlistProvider>(context,listen: false );
    favList= await wishlistProvider.getWishlistPref();

    isWishListItem =  favList.firstWhereOrNull((element) {
      return element.id.toString()==id;} )!=null;
  }

  getCartDatas(String id,BuildContext context )async{
   final cartProvider = Provider.of<CartProvider>(context, listen: false);
   cartLists= await cartProvider.getCartProductsPref();

    isCartItems =  cartLists.firstWhereOrNull((element) {
      return element.product_id.toString()==id;} )!=null;
  }

  Widget itemView(GetDashBoardProducts data,Function refresh,BuildContext context) {

    final wishlistProvider = Provider.of<WishlistProvider>(context,listen: false );
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    Variations? variation;
    return StatefulBuilder(builder: (context, setState) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: sizes.width*0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Stack(
                  children:[
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(productsParent: data,)));
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Color.fromARGB(231, 184, 182, 182),
                            height: sizes.height*0.28,
                            width: sizes.width*0.45,
                            child: Image.network(
                              data.images[0].src,
                              fit: BoxFit.fill,
                            ),
                          )),
                    ),
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: sizes.width*0.02,vertical: sizes.height*0.01),
                        height: sizes.width*0.10,
                        width: sizes.width*0.10,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Center(
                          child: LikeButton(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              padding: EdgeInsets.only(left: 2.0),
                              mainAxisAlignment: MainAxisAlignment.center,
                              onTap: (value) async{
                                if(isWishListItem){
                                  wishlistProvider.removeFromWishList(data.id).then((value) {
                                    setState((){
                                      getWishListDatas(data.id.toString(),context);
                                    });
                                  });
                                }else{
                                  wishlistProvider.addWishlistPref(data).then((value) {
                                    setState((){
                                    });
                                    getWishListDatas(data.id.toString(),context);
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
                    )
                  ]
              ),
            ),
            SizedBox(
              height: sizes.height*0.001,
            ),
            Container(
              width: sizes.width*0.40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "${data.title}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: TITLE_COLOR,
                          fontSize: sizes.width*0.043,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                  SizedBox(
                    width: sizes.width*0.02,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${data.price} ${currencyCode}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: PRICE_COLOR,
                            fontSize: sizes.width*0.043,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          if(isCartItems){
                            cartProvider.delCartProductsPref(data.id).then((value) async{
                              setState((){
                                getCartDatas(data.id.toString(),context);
                              });

                            });
                          }else{
                            // ignore: unnecessary_null_comparison
                            cartProvider.addOrUpdateCartProductsPref(Line_items(data.id, variation == null ? -1 :variation.id, 1,data )).then((value) async{
                              setState((){
                                getCartDatas(data.id.toString(),context);
                              });
                            });
                          }
                        },
                        child: Container(
                          height: sizes.width*0.10,
                          padding: EdgeInsets.symmetric(horizontal: sizes.width*0.04),
                          decoration: BoxDecoration(
                            color: ICON_BACKGROUND_COLOR,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                              child: Icon(isCartItems?Icons.shopping_cart:Icons.shopping_cart_outlined,color:ICON_COLOR,)
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: sizes.height*0.01,
            ),

          ],
        ),
      );
    });
  }
}
