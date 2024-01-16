import 'package:ecom/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/colors.dart';
import '../../utils/string.dart';
import '../cart/cart_screen.dart';
import 'dashboard_screen.dart';
import '../favourite/favourite_screen.dart';
import '../profile/profile.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  List pages = [
    DashboardScreen(),
    CartScreen(isArrowAppBar: false),
    FavouriteScreen(),
    ProfileScreen(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getData()async{
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    context.read<CartProvider>().cartList= await cartProvider.getCartProductsPref();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          backgroundColor: Colors.white,
          elevation: 0.0,
          unselectedItemColor: Colors.grey[900],
          showSelectedLabels: false,
          selectedItemColor: Colors.grey[900],
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined,color: ICON_COLOR,),
              label: HOME_BOTTOM_BAR,
              activeIcon: Icon(
                Icons.home_filled,
                color: ICON_COLOR,
              ),
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined,color: ICON_COLOR,),
              label: CART_BOTTOM_BAR,
              activeIcon: Icon(
                Icons.shopping_bag,
                color: ICON_COLOR,
              ),

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border, color: ICON_COLOR,),
              label: FAVOURITE_BOTTOM_BAR,
              activeIcon: Icon(
                Icons.favorite_rounded,
                color: ICON_COLOR,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_sharp,color: ICON_COLOR),
              label: PROFILE_BOTTOM_BAR,
              activeIcon: Icon(
                Icons.person,
                color: ICON_COLOR
              ),
            ),
          ]),
    );
  }
}
