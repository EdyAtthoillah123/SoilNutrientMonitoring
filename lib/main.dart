import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Cek apakah email sudah tersimpan di SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? storedEmail = prefs.getString('email');

  // Tentukan halaman awal berdasarkan keberadaan email di SharedPreferences
  Widget initialPage = storedEmail != null ? const Home() : const SplashScreen();

  runApp(MyApp(initialPage: initialPage));
}

class MyApp extends StatelessWidget {
  final Widget initialPage;

  // Tambahkan constructor dengan parameter initialPage yang diperlukan
  const MyApp({required this.initialPage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: initialPage,
    );
  }
}
