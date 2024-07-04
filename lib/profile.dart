import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<void> _logOut() async {
    // Hapus data email dari SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');

    // Navigasi kembali ke halaman LoginScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nutrisoil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF2E5F4C),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Card(
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 38,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'John Doe',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.mail),
                title: Text('Ubah Email'),
                onTap: () {
                  // Navigasi ke halaman Ubah Email
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => UbahEmailScreen()),
                  // );
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.lock),
                title: Text('Ubah Kata Sandi'),
                onTap: () {
                  // Navigasi ke halaman Ubah Kata Sandi
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => UbahPasswordScreen()),
                  // );
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Keluar'),
                onTap: () {
                  // Panggil fungsi log out saat "Keluar" diklik
                  _logOut();
                },
              ),
              Divider(),
            ],
          ),
        ],
      ),
    );
  }
}
