import 'package:ecom/provider/address_provider.dart';
import 'package:ecom/provider/authentication_provider.dart';
import 'package:ecom/provider/change_password_provider.dart';
import 'package:ecom/provider/customer_provider.dart';
import 'package:ecom/provider/order_provider.dart';
import 'package:ecom/provider/search_provider.dart';
import 'package:ecom/provider/wishlist_provider.dart';
import 'package:ecom/screen/splash_screen.dart';
import 'package:ecom/utils/shared_preferences_string.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'provider/cart_provider.dart';
import 'provider/connectivity_provider.dart';
import 'provider/dashboard_provider.dart';
import 'screen/intro/on_boarding_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  runApp(
    MultiProvider(
      providers: [
        // Provider<ChangeNotifierProvider>(create: (_) => ChangeThemeNotifier()),
        // Provider<ChangeNotifierProvider>(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_)=> DashboardProvider()),
        ChangeNotifierProvider(create: (_)=> WishlistProvider()),
        ChangeNotifierProvider(create: (_)=> CartProvider()),
        ChangeNotifierProvider(create: (_)=> CustomerProvider()),
        ChangeNotifierProvider(create: (_)=> AuthenticationProvider()),
        ChangeNotifierProvider(create: (_)=> ChangePasswordProvider()),
        ChangeNotifierProvider(create: (_)=> SearchProvider()),
        ChangeNotifierProvider(create: (_)=> OrderProvider()),
        ChangeNotifierProvider(create: (_)=> ConnectivityProvider()),
        ChangeNotifierProvider(create: (_)=> AddressProvider()),
      ],
      child:  MyApp(),
    ),
  );

}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool showIntro = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
     showIntro = prefs.getBool(isShowIntro)!;
     print("showIntro:: ${showIntro}");
    // if(showIntro){
    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>splashScreen()));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estore',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: showIntro?splashScreen():onBoardingScreen(),
    );
  }
}
