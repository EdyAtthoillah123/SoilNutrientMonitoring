import 'package:flutter/material.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nutrisoil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF2E5F4C), // Warna latar belakang AppBar
        titleTextStyle: TextStyle(
          color: Colors.white, // Warna teks AppBar
          fontSize: 20, // Ukuran teks
          fontWeight: FontWeight.bold, // Ketebalan teks
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Warna ikon panah kembali
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Card(
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10), // Padding di dalam ListTile
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 38, // Setengah dari ukuran yang Anda inginkan (76 / 2)
                      backgroundImage: AssetImage(
                          'assets/images/profile.png'), // Ganti dengan path gambar profil Anda
                    ),
                    SizedBox(height: 10),
                    Text(
                      'John Doe', // Ganti dengan nama pengguna yang sesuai
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
                  // Navigasi ke layar login ketika "Keluar" di tap
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
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
