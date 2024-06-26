import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soil_nutrient/profile.dart';
import 'package:soil_nutrient/sensor.dart';
import 'Api/Api_Service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

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
    final response =
        await http.get(Uri.parse('http://192.168.112.97:8000/api/showland/'));

    if (response.statusCode == 200) {
      final List<dynamic> landsJson = json.decode(response.body)['lands'];
      setState(() {
        lands = landsJson.map((json) => Land.fromJson(json)).toList();
        isLoading = false;
      });
    } else {
      // Handle the error
      setState(() {
        isLoading = false;
      });
    }
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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
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
                leading: Icon(Icons.person_4_outlined),
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
                leading: Icon(Icons.info_outline),
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
                leading: Icon(Icons.help_outline),
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
        body: isLoading
            ? Center(child: CircularProgressIndicator())
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
                              MaterialPageRoute(builder: (context) => Sensor()),
                            );
                            print('Tombol ditekan!');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF2E5F4C),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 75, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text('Mulai'),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: lands.length,
                    itemBuilder: (context, index) {
                      final land = lands[index];
                      return Card(
                        margin: EdgeInsets.all(10),
                        color: Colors.white, // Background color of the card
                        elevation: 5, // Elevation of the card
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15), // Rounded corners
                        ),
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.all(15), // Padding inside the ListTile
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Land ID: ${land.id}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black, // ID text color
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: Colors
                                          .green[800], // Badge background color
                                      borderRadius: BorderRadius.circular(
                                          5), // Rounded corners for the badge
                                    ),
                                    child: Text(
                                      'Normal', // Badge text
                                      style: TextStyle(
                                        color: Colors.white, // Badge text color
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.grey, // Divider color
                                thickness: 1, // Divider thickness
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Lahan tidak mempunyai faktor pembatas yang berarti atau nyata  terhadap penggunaan berkelanjutan, atau hanya mempunyai faktor  pembatas yang bersifat minor dan tidak mereduksi produktivitas lahan  secara nyata. Rata Rata Unsur Hara Tanah'),
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
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(Colors
                                            .black), // Button background color
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white), // Button text color
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5), // Button border radius
                                      ),
                                    ),
                                  ),
                                  child: Text('Detail'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ));
  }
}
