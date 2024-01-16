import 'package:ecom/provider/connectivity_provider.dart';
import 'package:ecom/provider/search_provider.dart';
import 'package:ecom/screen/connectivity_screen.dart';
import 'package:ecom/screen/product/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/colors.dart';
import '../splash_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  void initState() {
    super.initState();
    getData();
  }

   getData(){
     context.read<ConnectivityProvider>().checkConnection();
     final searchProvider = Provider.of<SearchProvider>(context, listen: false);
     searchProvider.searchController.text="";
     searchProvider.getSearchProduct(context: context,searchName: "");
   }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final searchProvider = Provider.of<SearchProvider>(context,);
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor:  Colors.white,
        leadingWidth: 35,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back,color: ICON_COLOR,)),
        title: Container(
          child: Stack(
          alignment: Alignment.centerRight,
          children: [
            TextFormField(
              controller: searchProvider.searchController,
              maxLines: 1,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 17),
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                isDense: true,
                hintText: "search here..",
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              ),

              onChanged: (values) {
                searchProvider.getSearchProduct(context: context,searchName: searchProvider.searchController.text).then((value) {
                });
              },
              cursorColor: Colors.black,
              autofocus: true,
              textInputAction: TextInputAction.next,
            ),
            searchProvider.searchController.text.isEmpty
                ? Container()
                : InkWell(
              onTap: () {
                searchProvider.searchController.text = "";
                getData();
                FocusScope.of(context)
                    .requestFocus(new FocusNode());
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02),
                child: Icon(
                  Icons.close,
                  color: ICON_COLOR,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    body:!context.read<ConnectivityProvider>().isConnected?connectivityData(context: context,OnTap: (){
      getData();
      }):
      StatefulBuilder(
          builder: (BuildContext contextx, StateSetter setStatex) {
            return ClipRRect(
              borderRadius:  BorderRadius.only(
                  topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
              child: Container(
                height: size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.width * (0.02),
                    ),

                    searchProvider.searchController.text.isEmpty
                        ? searchProvider.isApiLoading
                        ? Center(
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: size.height * 0.10),
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(color: CIRCULAR_INDICATOR_COLOR,)),
                    )
                        : Expanded(
                        child: SingleChildScrollView(
                        child: Container(
                            padding:  EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: size.height*0.02),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            addRepaintBoundaries: true,
                            itemCount: searchProvider.filteredList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: size.width*0.02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(productsParent: searchProvider.filteredList[index],)));
                                        },
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Container(
                                              color: Color.fromARGB(231, 184, 182, 182),
                                              height: size.height*0.28,
                                              width: size.width*0.45,
                                              child: Image.network(
                                                searchProvider.filteredList[index].images[0].src,
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
                                              "${searchProvider.filteredList[index].title}",
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
                                                searchProvider.filteredList[index].price.isEmpty?"0.0 ${currencyCode}":"${searchProvider.filteredList[index].price} ${currencyCode}",
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
                        )
                        : searchProvider.searchItem.length == 0
                        ? Container(
                          height: size.height*0.40,
                          alignment: Alignment.center,
                      child: Text(
                        "No Product Found",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: size.width * 0.040),
                      ),
                    )
                        : Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                            padding:  EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: size.height*0.02),
                          child:GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            addRepaintBoundaries: true,
                            itemCount: searchProvider.searchItem.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: size.width*0.02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Stack(
                                          children:[
                                            GestureDetector(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(productsParent: searchProvider.searchItem[index],)));
                                              },
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: Container(
                                                    color: Color.fromARGB(231, 184, 182, 182),
                                                    height: size.height*0.28,
                                                    width: size.width*0.45,
                                                    child: Image.network(
                                                      searchProvider.searchItem[index].images[0].src,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  )),
                                            ),
                                          ]
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
                                              "${searchProvider.searchItem[index].title}",
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
                                                searchProvider.searchItem[index].price.isEmpty?"0.0 ${currencyCode}":"${searchProvider.searchItem[index].price} ${currencyCode}",
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
                            crossAxisSpacing: 8.0,
                            childAspectRatio: size.height*0.00095,
                          ),
                          )

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}