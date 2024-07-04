import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soil_nutrient/bluetooth.dart';
import 'package:soil_nutrient/profile.dart';
import 'package:soil_nutrient/sensor.dart';
import 'Api/Api_Service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Land> lands = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLands();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nutrisoil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2E5F4C),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('John Doe'),
              accountEmail: Text('johndoe@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF2E5F4C),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_4_outlined),
              title: const Text(
                'Profil Saya',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profile()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text(
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
              leading: const Icon(Icons.help_outline),
              title: const Text(
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : lands.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Image.asset(
                          'assets/images/sensor.png',
                          width: 250,
                          height: 250,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Sensor()),
                          );
                          print('Tombol ditekan!');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E5F4C),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 75, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Mulai'),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 0.0),
                          child: Text(
                            "Fitur Nutrisoil",
                            style: TextStyle(
                              fontWeight: FontWeight.bold, // Tebalkan teks
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                            width:
                                10), // SizedBox untuk memberi jarak horizontal antara tombol
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0), // Padding atas dan bawah
                          child: ElevatedButton(
                            onPressed: () {
                              Route route = MaterialPageRoute(
                                builder: (context) => FlutterBlueApp(),
                              );
                              Navigator.push(context, route);
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  Colors.orange), // Warna background button
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Bentuk border button
                                ),
                              ),
                              minimumSize: WidgetStateProperty.all<Size>(
                                  const Size(
                                      50.0, 85.0)), // Ukuran minimum button
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Icon(
                                  Icons.bluetooth,
                                  color: Colors.white, // Warna icon
                                  size: 20.0,
                                ),
                                SizedBox(height: 5),
                                SizedBox(height: 5),
                                Text(
                                  "Connect",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white, // Warna teks putih
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                            width:
                                10), // SizedBox untuk memberi jarak horizontal antara tombol
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0), // Padding atas dan bawah
                          child: ElevatedButton(
                            onPressed: () {
                              // Tambahkan fungsi onPressed sesuai kebutuhan
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  Colors.orange), // Warna background button
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Bentuk border button
                                ),
                              ),
                              minimumSize: WidgetStateProperty.all<Size>(
                                  const Size(
                                      50.0, 85.0)), // Ukuran minimum button
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Icon(
                                  Icons.control_point_duplicate_sharp,
                                  color: Colors.white, // Warna icon
                                  size: 20.0,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Tambah",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white, // Warna teks putih
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 0.0),
                          child: Text(
                            "Rekap Pengukuran Lahan",
                            style: TextStyle(
                              fontWeight: FontWeight.bold, // Tebalkan teks
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: lands.length,
                        itemBuilder: (context, index) {
                          final land = lands[index];
                          return Card(
                            margin: const EdgeInsets.all(10),
                            color: Colors.white,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(15),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Lahan: ${land.id}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.green[800],
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: const Text(
                                          'Normal',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                      'Lahan tidak mempunyai faktor pembatas yang berarti atau nyata terhadap penggunaan berkelanjutan, atau hanya mempunyai faktor pembatas yang bersifat minor dan tidak mereduksi produktivitas lahan secara nyata. Rata Rata Unsur Hara Tanah'),
                                  Text('Natrium: ${land.averageNatrium}'),
                                  Text('Fosfor: ${land.averageFosfor}'),
                                  Text('Kalium: ${land.averageKalium}'),
                                  Text('pH: ${land.averagePh}'),
                                  Text('Moisture: ${land.averageMoisture}'),
                                  Text(
                                      'Temperature: ${land.averageTemperature}'),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        // Handle button press
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all<Color>(
                                                Colors.black),
                                        foregroundColor:
                                            WidgetStateProperty.all<Color>(
                                                Colors.white),
                                        shape: WidgetStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                      child: const Text('Detail'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
