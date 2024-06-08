import 'package:flutter/material.dart';
import 'package:soil_nutrient/dashboard1.dart';
import 'package:soil_nutrient/dashboardtwo.dart';
import 'package:soil_nutrient/gantipassword.dart';
import 'package:soil_nutrient/info.dart';
import 'package:soil_nutrient/laporan.dart';
import 'package:soil_nutrient/laporantwo.dart';
import 'package:soil_nutrient/login.dart';
import 'package:soil_nutrient/profile.dart';
import 'package:soil_nutrient/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NutriSoil',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:LaporanTwo(),
    );
  }
}

