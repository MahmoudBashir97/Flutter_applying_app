import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:bloc_sqflite_flutter_example/Layouts/HomeLayout.dart';
import 'package:bloc_sqflite_flutter_example/NewsApp/Layout/news_app.dart';
import 'package:bloc_sqflite_flutter_example/NewsApp/network/dio_helper.dart';
import 'package:bloc_sqflite_flutter_example/bloc/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
    Bloc.observer = MyBlocObserver();
    DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.deepOrange,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.deepOrange,
            statusBarIconBrightness: Brightness.light
          ),
          backgroundColor: Colors.deepOrange,
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
          iconTheme: IconThemeData(
            color: Colors.white
          )
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepOrange,
          elevation: 4.0
        ),
      
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black26
      ),
      themeMode: ThemeMode.light,
      home: NewsLayout(),
    );
  }
}