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
        color: Color.fromRGBO(46, 95, 76, 1.000),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Vertically center the children
          crossAxisAlignment:
              CrossAxisAlignment.center, // Horizontally center the children
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 167,
              width: 167,
            ),
            SizedBox(
                height:
                    20.0), // Add some space between the logo and the progress indicator
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white), // Atur warna indikator
              backgroundColor: Color.fromARGB(190, 255, 255, 255), // Atur warna latar belakang menjadi transparan
            ),
          ],
        ),
      ),
    );
  }
}
