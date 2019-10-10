// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

import 'package:flutter/material.dart';
import 'package:listen_english/src/constant/Constant.dart';
import 'package:listen_english/src/screen/GridItemDetails.dart';
import 'package:listen_english/src/screen/HomeScreen.dart';
import 'package:listen_english/src/screen/SplashScreen.dart';

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