import 'dart:io';
import 'package:admin/components/searchproviders.dart';
import 'package:admin/pages/categories/choosecategories.dart';
import 'package:admin/pages/editimages/editimages.dart';
import 'package:admin/pages/message/choosecatmessage.dart';
import 'package:admin/pages/offers/addoffers.dart';
import 'package:admin/pages/offers/offers.dart';
import 'package:admin/pages/orders/chooseorders.dart';
import 'package:admin/pages/orders/ordersfood.dart';
// import 'package:admin/pages/orders/orderstaxi.dart';
import 'package:admin/pages/sendmoney.dart';
import 'package:admin/pages/taxi/addtaxi.dart';
import 'package:admin/pages/taxi/taxi.dart';
import 'package:admin/pages/test.dart';
import 'package:admin/pages/users/addusers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Import Pages
import './pages/home.dart';
import 'package:admin/pages/restaurants/restaurants.dart';
import './pages/login.dart';
import 'common.dart';
import 'package:admin/pages/categories/addcategories.dart';
import 'package:admin/pages/categories/catfood.dart';
import 'package:admin/pages/categories/editcategories.dart';
import 'package:admin/pages/items/additems.dart';
import 'package:admin/pages/items/edititems.dart';
import 'package:admin/pages/users/users.dart';
import 'package:admin/pages/items/items.dart';
import 'package:admin/pages/restaurants/addrestaurants.dart';
import 'package:admin/pages/settings.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)..maxConnectionsPerHost = 5;
  }
}

SharedPreferences sharedPrefs;
String userid;
void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedPrefs = await SharedPreferences.getInstance();
  userid = sharedPrefs.getString("id");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return Common();
        }),
        ChangeNotifierProvider(create: (context) {
          return SearchProvider();
        })
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              fontFamily: 'Cairo',
              primarySwatch: Colors.blue,
              textTheme: TextTheme(
                bodyText1: TextStyle(fontSize: 18),
                bodyText2: TextStyle(fontSize: 14, color: Colors.blue),
                headline1: TextStyle(color: Colors.blue, fontSize: 40),
                headline2: TextStyle(color: Colors.blue, fontSize: 25),
                headline3: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              )),
          home: userid == null ? Login() : HomeScreen(),
          // home: Test()  , 
          routes: {
            "home": (context) => HomeScreen(),
            "restaurants": (context) => Restaurants(),
            "addrestaurants": (context) => AddRestaurants(),
            "login": (context) => Login(),
            "users": (context) => Users(),
            "addusers": (context) => AddUsers(),
            "choosecat" : (context) => ChooseCat() ,
            "catfood": (context) => CatFood(),
            "addcategories": (context) => AddCategories(),
            "editcategories": (context) => EditCategories(),
            "items": (context) => Items(),
            "additems": (context) => AddItem(),
            "edititems": (context) => EditItem(),
            "settings": (context) => Settings(),
            "sendmoney": (context) => SendMoney(),
            "chooseorders" : (context)=> ChooseOrders()  , 
            "orders": (context) => OrdersFood(),
            "taxi": (context) => Taxi() , 
            "addtaxi" : (context) => AddTaxi(),  
            "choosecatmessage" : (context) => ChooseCatMessage(), 
            "offers" : (context) => Offers() , 
            "addoffers" : (context) => AddOffers() , 
            "editimages" : (context) => EditImages()
          }),
    );
  }
}
