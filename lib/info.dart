import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Info',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png', // Ganti dengan path gambar logo Anda
              height: 400.0, 
              width: 400.0,
            ),
            SizedBox(height: 0), // Adjust space between image and text
            Text(
              'Versi 1.0',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
              ),
            ),
             SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
