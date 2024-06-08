import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nutrisoil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green, // Set the navbar color to green
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green, // Set the drawer header color to green
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.people_outline_rounded, color: Colors.black),
              title: Text('Profile Saya', style: TextStyle(color: Colors.black)),
              onTap: () {
                // Navigate to the home screen
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline_rounded, color: Colors.black),
              title: Text('Info Aplikasi', style: TextStyle(color: Colors.black)),
              onTap: () {
                // Navigate to the settings screen
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.question_mark_outlined, color: Colors.black),
              title: Text('Pusat Bantuan', style: TextStyle(color: Colors.black)),
              onTap: () {
                // Handle logout action
                Navigator.pop(context);
              },
            ),
             ListTile(
              leading: Icon(Icons.logout, color: Colors.black),
              title: Text('Logout', style: TextStyle(color: Colors.black)),
              onTap: () {
                // Handle logout action
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/dashboard-logo.png', // Path to your image asset
              height: 200.0, // Adjust height as needed
              width: 200.0, // Adjust width as needed
            ),
           
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Set the button color to green
              ),
              child: Text('Mulai', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
