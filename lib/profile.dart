import 'package:flutter/material.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nutrisoil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2E5F4C), // Warna latar belakang AppBar
        titleTextStyle: const TextStyle(
          color: Colors.white, // Warna teks AppBar
          fontSize: 20, // Ukuran teks
          fontWeight: FontWeight.bold, // Ketebalan teks
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Warna ikon panah kembali
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10), // Padding di dalam ListTile
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
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
          const SizedBox(height: 20),
          Column(
            children: <Widget>[
             ListTile(
                leading: const Icon(Icons.mail),
                title: const Text('Ubah Email'),
                onTap: () {
                  // Navigasi ke halaman Ubah Email
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => UbahEmailScreen()),
                  // );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Ubah Kata Sandi'),
                onTap: () {
                  // Navigasi ke halaman Ubah Kata Sandi
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => UbahPasswordScreen()),
                  // );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Keluar'),
                 onTap: () {
                  // Navigasi ke layar login ketika "Keluar" di tap
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
              ),
              const Divider(),
            ],
          ),
        ],
      ),
    );
  }
}
