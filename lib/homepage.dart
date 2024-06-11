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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo di atas tombol
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Image.asset(
                'assets/images/sensor.png', // Ganti dengan path logo Anda
                width: 250, // Ubah ukuran logo sesuai kebutuhan Anda
                height: 250, // Ubah ukuran logo sesuai kebutuhan Anda
              ),
            ),
            // Tombol "Mulai"
            ElevatedButton(
              
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Sensor()),
                );
                // Tambahkan aksi yang Anda inginkan saat tombol ditekan
                print('Tombol ditekan!');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2E5F4C), // Warna latar belakang tombol
                foregroundColor: Colors.white, // Warna teks tombol
                padding: EdgeInsets.symmetric(
                    horizontal: 75, vertical: 15), // Ukuran tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Border radius 5px
                ),
              ),
              child: Text('Mulai'),
            ),
          ],
        ),
      ),
    );
  }
}
