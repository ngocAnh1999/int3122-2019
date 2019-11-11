import 'package:flutter/material.dart';
import 'package:mobile/core/components/root_page.dart';
// import 'package:mobile/core/gen_data.dart';
import 'package:mobile/core/services/authentication.dart';
// import 'package:mobile/views/LoginPage.dart';
import 'package:mobile/views/screen/HomeScreen.dart';
// import 'package:mobile/views/screen/LoginScreen.dart';
import 'package:mobile/views/screen/SplashScreen.dart';

import 'core/constant/Constant.dart';
// import 'core/gen_data.dart';

void main() => runApp(MaterialApp(
  title: 'English Beater',
  home: SplashScreen(),
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primarySwatch: Colors.blue,
    accentColor: Color(0xFF761322),
  ),
  routes: <String, WidgetBuilder>{
    SPLASH_SCREEN: (BuildContext context) => SplashScreen(),
    HOME_SCREEN: (BuildContext context) => HomeScreen(),
    LOGIN_SCREEN: (BuildContext context) => RootPage(auth: new Auth()),

    // GRID_ITEM_DETAILS_SCREEN: (BuildContext context) => GridItemDetails(),
  },
));

//void main() => runApp(MaterialApp(
//  title: "Test Firebase",
//  home: TestGenData(),
//  debugShowCheckedModeBanner: false,
//  theme: ThemeData(
//    primaryColor: Colors.blue,
//    accentColor: Color(0xFF761322),
//  ),
//)
//);