import 'package:flutter/material.dart';
import 'detailLand.dart';
import 'Api/Api_Service.dart';
import 'Api/Api_Connect.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'profile.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Land> lands = [];
  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchLands();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final location = _locationController.text;
      postLocation(location);
    }
  }

  Future<void> printLandId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? landId = prefs.getInt('idLahan'); // Retrieve the saved land ID
    print('Saved Land ID: $landId'); // Print the land ID
  }

  Future<void> postLocation(String location) async {
    final apiUrl = Uri.parse(ApiConnect.createland);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');

    print('Email: $email');
    print('Location: $location');

    final response = await http.post(
      apiUrl,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'lokasi': location,
        'email': email,
      }),
    );

    if (response.statusCode == 201) {
      Fluttertoast.showToast(
        msg: 'Berhasil Ditambahkan',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color.fromARGB(255, 172, 255, 174),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      fetchLands(); // Refresh list of lands
    } else {
      print('Error: ${response.body}'); // Log the response body for more info
      Fluttertoast.showToast(
        msg: 'Gagal Ditambahkan',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color.fromARGB(255, 255, 125, 116),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
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
      print(error);
    }
  }

  Future<void> _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  Widget detailRow(String title, dynamic value, IconData icon, String unit) {
    String formattedValue =
        value is double ? value.toStringAsFixed(3) : value.toString();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF2E5F4C)),
          SizedBox(width: 10),
          Text(
            '$title: $formattedValue $unit',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  void navigateToDetailScreen(int landId) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: DetailLandScreen(landId: landId),
          );
        },
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Tambah Lahan Baru',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Masukkan lokasi',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the location';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Align buttons to the right
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // Less rounded
                    ),
                  ),
                  child: Text(
                    'Batal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 16.0), // Spacer between buttons
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.of(context).pop();
                      _submitForm();
                      _locationController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E5F4C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4), // Less rounded
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white), // Set text color to white
                  ),
                ),
              ],
            ),
          ],
        );
      },
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
              accountName: Text(''),
              accountEmail: Text('User Soil Nutrients'),
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
                        onPressed: () => _showAddDialog(context),
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
                    Card(
                      margin: const EdgeInsets.only(
                          top: 20, bottom: 0, left: 16, right: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: const Color(0xFF2E5F4C),
                          width: 2,
                        ),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Semua Lahan',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => _showAddDialog(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2E5F4C),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.add),
                                  SizedBox(width: 5),
                                  Text(
                                    'Tambah',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: lands.length,
                        itemBuilder: (context, index) {
                          final land = lands[index];
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                  color: const Color(0xFF2E5F4C),
                                  width: 1,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  navigateToDetailScreen(land.id!);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Lahan ${land.id}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Location: ${land.lokasi}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Klasifikasi Lahan: ${land.recommendation}',
                                          style: TextStyle(fontSize: 14),
                                          overflow: TextOverflow
                                              .ellipsis, // Add this to handle overflow
                                          maxLines: 4, // Limit to 2 lines
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          detailRow(
                                            'Nitrogen',
                                            land.averageNitrogen,
                                            Icons.grass,
                                            'mg/kg',
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          detailRow(
                                            'Fosfor',
                                            land.averageFosfor,
                                            Icons.grass,
                                            'mg/kg',
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          detailRow(
                                            'Kalium',
                                            land.averageKalium,
                                            Icons.grass,
                                            'mg/kg',
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          detailRow(
                                            'Ph',
                                            land.averagePh,
                                            Icons.grass,
                                            '',
                                          ),
                                        ],
                                      ),
                                      detailRow(
                                          'Moisture',
                                          land.averageMoisture,
                                          Icons.water,
                                          '%'),
                                      detailRow(
                                          'Temperature',
                                          land.averageTemperature,
                                          Icons.thermostat,
                                          '°C'),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          onPressed: () {
                                            navigateToDetailScreen(land.id);
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            foregroundColor: Colors.white,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 16),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          child: Text(
                                            'Detail',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
