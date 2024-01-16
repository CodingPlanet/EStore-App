import 'package:ecom/provider/dashboard_provider.dart';
import 'package:ecom/screen/dashboard/dashboard_screen.dart';
import 'package:ecom/screen/splash_screen.dart';
import 'package:ecom/utils/colors.dart';
import 'package:ecom/widgets/appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CategoryByProductScreen extends StatefulWidget {

  String title;
  String Id;
  CategoryByProductScreen({required this.title, required this.Id});
  @override
  State<CategoryByProductScreen> createState() => _CategoryByProductScreenState();
}

class _CategoryByProductScreenState extends State<CategoryByProductScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    dashboardProvider.getCategoryByProduct(context: context, id: int.parse(widget.Id));
  }
  @override
  Widget build(BuildContext context) {
    final dashboardProviders = Provider.of<DashboardProvider>(context);
    return Scaffold(
      appBar: AppBarTitle().appbar(setState, context, widget.title,true),
      body: dashboardProviders.isApiLoading?Center(child: CircularProgressIndicator(
        color: CIRCULAR_INDICATOR_COLOR,
      )): dashboardProviders.categoryByproduct.length==0?Center(
        child: Container(
          child: Text("Category Not Available",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: TITLE_COLOR,
                fontSize: sizes.width*0.045,
                fontWeight: FontWeight.normal
            ),),
        ),
      ):Container(
        child: SingleChildScrollView(
          child: Container(
            padding:  EdgeInsets.only(left: sizes.width*0.02,top: sizes.height*0.025 ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              addRepaintBoundaries: true,
              itemCount: dashboardProviders.categoryByproduct.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                 //  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(productsParent: dashboardProviders.categoryByproduct[index] as GetDashBoardProducts,)));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: sizes.width*0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                color: Color.fromARGB(231, 184, 182, 182),
                                height: sizes.height*0.28,
                                width: sizes.width*0.42,
                                child: Image.network(
                                  dashboardProviders.categoryByproduct[index].images[0].src ==""?"":dashboardProviders.categoryByproduct[index].images[0].src,
                                  fit: BoxFit.fill,
                                ),
                              )),
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
                                  "${dashboardProviders.categoryByproduct[index].name}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: TITLE_COLOR,
                                      fontSize: sizes.width*0.043,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),

                              Text(
                                "${dashboardProviders.categoryByproduct[index].price} ${currencyCode}",
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
                        SizedBox(
                          height: sizes.height*0.01,
                        ),

                      ],
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 9.0,
              childAspectRatio: sizes.height*0.00099,
            ),
            ),
          ),
        ),
      ),
    );
  }
}


