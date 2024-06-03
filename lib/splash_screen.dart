import 'package:flutter/material.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override 
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  void _navigateToLogin() async {
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
  @override 
  Widget build(BuildContext context) {
    return Scaffold(  
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 0, 133, 11),
              Color.fromARGB(255, 124, 206, 16),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Vertically center the children
          crossAxisAlignment: CrossAxisAlignment.center,  // Horizontally center the children
          children: [
            Text(
              'Selamat Datang',
                style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset(
              'assets/images/logo.png', 
              height: 300.0, 
              width: 300.0,
            ),
            SizedBox(height: 20.0),  // Add some space between the logo and the progress indicator
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
