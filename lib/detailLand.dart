import 'package:flutter/material.dart';
import 'package:soil_nutrient/homepage.dart';
import 'Api/Api_Service.dart';
import 'sensor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart'; // Import the package for Bluetooth
import 'package:shared_preferences/shared_preferences.dart';
import 'sensor.dart'; // Import your Sensor widget
import 'bluetooth_connect_screen.dart';

class DetailLandScreen extends StatefulWidget {
  final int landId;

  DetailLandScreen({required this.landId});

  @override
  _DetailLandScreenState createState() => _DetailLandScreenState();
}

class _DetailLandScreenState extends State<DetailLandScreen> {
  // final int landId

  // DetailLandScreen({required this.landId
  late Future<List<DetailLand>> futureDetailLands;
  bool measurementSelected1 = false;
  bool measurementSelected2 = false;
  bool measurementSelected3 = false;
  bool measurementSelected4 = false;
  bool measurementSelected5 = false;

  @override
  void initState() {
    super.initState();
    futureDetailLands = ApiService.fetchLandDetails(widget.landId);

    // Example: Assume we check the first detail for each measurement point
    futureDetailLands.then((details) {
      setState(() {
        measurementSelected1 = details.isNotEmpty;
        measurementSelected2 = details.length > 1;
        measurementSelected3 = details.length > 2;
        measurementSelected4 = details.length > 3;
        measurementSelected5 = details.length > 4;
      });
    });
  }

  Future<void> saveLandId(int landId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('idLahan', landId); // Simpan landId
  }

  void saveAndNavigate(int landId) async {
    await saveLandId(landId); // Save the land ID
    print(landId); // Optional: for debugging purposes
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BluetoothConnectScreen(
          landId: landId, // Pass the land ID to the new screen
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Gunakan Navigator.push jika ingin navigasi ke halaman tertentu
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Home()), // Ganti HalamanTujuan dengan halaman yang diinginkan
            );
          },
        ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            margin: EdgeInsets.all(15),
            elevation: 2,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Informasi Lahan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2E5F4C),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey),
                  buildMeasurementRow(
                      'Titik Pengukuran 1', measurementSelected1),
                  buildMeasurementRow(
                      'Titik Pengukuran 2', measurementSelected2),
                  buildMeasurementRow(
                      'Titik Pengukuran 3', measurementSelected3),
                  buildMeasurementRow(
                      'Titik Pengukuran 4', measurementSelected4),
                  buildMeasurementRow(
                      'Titik Pengukuran 5', measurementSelected5),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<DetailLand>>(
              future: futureDetailLands,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Data Masih belum ada'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No details found'));
                } else {
                  final details = snapshot.data!;
                  return ListView.builder(
                    itemCount: details.length,
                    itemBuilder: (context, index) {
                      final detail = details[index];
                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Titik Pengukuran ${index + 1}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF2E5F4C),
                                ),
                              ),
                              const Divider(color: Colors.grey),
                              detailRow('Nitrogen', detail.nitrogen,
                                  Icons.grass, 'mg/kg'),
                              detailRow('Fosfor', detail.fosfor, Icons.flare,
                                  'mg/kg'),
                              detailRow('Kalium', detail.kalium, Icons.ac_unit,
                                  'mg/kg'),
                              detailRow(
                                  'pH', detail.ph, Icons.bubble_chart, ''),
                              detailRow('Moisture', detail.moisture,
                                  Icons.water, '%'),
                              detailRow('Temperature', detail.temperature,
                                  Icons.thermostat, '°C'),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Pastikan 'widget.landId' diakses dari parent widget
          printLandId(); // Fungsi untuk mencetak landId yang tersimpan
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BluetoothConnectScreen(
                landId: widget
                    .landId, // Pastikan landId sesuai tipe yang diterima BluetoothConnectScreen
              ),
            ),
          );
        },
        backgroundColor: const Color(0xFF2E5F4C),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        shape: const CircleBorder(),
      ),
    );
  }

  void printLandId() async {
    int? landId = await getLandId(); // Ambil idLahan
    if (landId != null) {
      print('Land ID: $landId'); // Cetak Land ID
    } else {
      print('Land ID belum disimpan.');
    }
  }

  Future<int?> getLandId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('idLahan'); // Mengambil idLahan
  }

  Widget buildMeasurementRow(String text, bool isSelected) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: TextStyle(fontSize: 14)),
        if (isSelected) Icon(Icons.check, color: Colors.green),
        if (!isSelected) Icon(Icons.close, color: Colors.red),
      ],
    );
  }

  Widget buildCheckIcon(bool isSelected) {
    if (isSelected) {
      return Icon(Icons.check, color: Colors.green);
    } else {
      return Icon(Icons.close, color: Colors.red);
    }
  }

  Widget detailRow(String title, double? value, IconData icon, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF2E5F4C)),
          const SizedBox(width: 10),
          Text(
            '$title: ${value ?? '-'} $unit', // Display '-' if value is null
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
