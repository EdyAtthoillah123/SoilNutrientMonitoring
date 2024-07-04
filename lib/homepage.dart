import 'package:flutter/material.dart';
import 'package:soil_nutrient/profile.dart';
import 'Api/Api_Service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';


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

  Future<void> fetchLands() async {
    try {
      final fetchedLands = await ApiService.fetchLands();
      setState(() {
        lands = fetchedLands;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      // Handle the error appropriately
      print(error);
    }
  }

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
                // Navigate to the app info page
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
                // Navigate to the help center page
              },
            ),
             ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                 _logOut();
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const Sensor()),
                          // );
                          // print('Button pressed!');
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
                      padding: EdgeInsets.only(left: 10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                          child: Text(
                            "Rekap Pengukuran Lahan",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          borderRadius: BorderRadius.circular(5),
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
                                  Text('Temperature: ${land.averageTemperature}'),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        // Handle button press
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
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
