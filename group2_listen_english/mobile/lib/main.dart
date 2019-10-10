import 'package:flutter/material.dart';
import 'package:mobile/views/screen/HomeScreen.dart';
import 'package:mobile/views/screen/SplashScreen.dart';

import 'core/constant/Constant.dart';

void main() => runApp(MaterialApp(
  title: 'GridView Demo',
  home: SplashScreen(),
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primarySwatch: Colors.blue,
    accentColor: Color(0xFF761322),
  ),
  routes: <String, WidgetBuilder>{
    SPLASH_SCREEN: (BuildContext context) => SplashScreen(),
    HOME_SCREEN: (BuildContext context) => HomeScreen(),
    // GRID_ITEM_DETAILS_SCREEN: (BuildContext context) => GridItemDetails(),
  },
));