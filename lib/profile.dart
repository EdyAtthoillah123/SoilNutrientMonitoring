import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Saya',
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
      body: Column(
        children: [
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/profile_wishal.jpg'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Wishal Azharyan Al Hisyam',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.email, color: Colors.black),
            title: Text('wishal123@gmail.com', style: TextStyle(color: Colors.black)),
            onTap: () {
              // Handle email tap
            },
          ),
          ListTile(
            leading: Icon(Icons.lock, color: Colors.black),
            title: Text('Lupa Kata Sandi', style: TextStyle(color: Colors.black)),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              // Handle forgot password tap
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.black),
            title: Text('Logout', style: TextStyle(color: Colors.black)),
            onTap: () {
              // Handle logout action
            },
          ),
        ],
      ),
    );
  }
}
