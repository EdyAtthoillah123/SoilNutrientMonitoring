import 'package:flutter/material.dart';
import 'package:soil_nutrient/profile.dart';
import 'package:soil_nutrient/sensor.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        // leading: Builder(
        //   builder: (BuildContext context) {
        //     return IconButton(
        //       icon: const Icon(Icons.menu),
        //       onPressed: () {
        //         Scaffold.of(context).openDrawer(); // Fungsi untuk membuka drawer
        //       },
        //     );
        //   },
        // ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                'John Doe', // Ganti dengan nama pengguna yang sesuai
              ),
              accountEmail: Text(
                'johndoe@example.com', // Ganti dengan alamat email yang sesuai
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/images/profile.png'), // Ganti dengan path gambar profil Anda
              ),
              decoration: BoxDecoration(
                color: Color(0xFF2E5F4C), // Warna latar belakang bagian atas
              ),
            ),
            ListTile(
              leading: Icon(Icons.person_4_outlined), // Ikon profil
              title: Text(
                'Profil Saya',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline), // Ikon info aplikasi
              title: Text(
                'Info Aplikasi',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                // Navigasi ke halaman informasi aplikasi
              },
            ),
            ListTile(
              leading: Icon(Icons.help_outline), // Ikon pusat bantuan
              title: Text(
                'Pusat Bantuan',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                // Navigasi ke halaman pusat bantuan
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the second screen when the button is pressed.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Sensor()),
            );
          },
          child: Text('Go to Second Screen'),
        ),
      ),
    );
  }
}
