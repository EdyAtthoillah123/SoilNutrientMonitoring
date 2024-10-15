import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'Api/Api_Connect.dart';
import 'homepage.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Sensor extends StatefulWidget {
  final BluetoothDevice device; // Tambahkan properti device

  Sensor({required this.device}); // Tambahkan konstruktor

  @override
  SensorState createState() => SensorState();
}

class SensorState extends State<Sensor> {
  static const String TEMP_CHARACTERISTIC_UUID = "68a6e0f2-5429-496c-883a-ac5d8a87de9b";
  static const String MOISTURE_CHARACTERISTIC_UUID = "e54f29d4-1b0e-4d44-bd4e-43f5d5c40f50";
  static const String PH_CHARACTERISTIC_UUID = "551a162b-e2e0-4c3a-ab36-6d6668a6e5ad";
  static const String NITROGEN_CHARACTERISTIC_UUID = "8ffef044-1203-41e2-8281-e65626b6ad97";
  static const String PHOSPHOR_CHARACTERISTIC_UUID = "1195044f-9b1a-4834-a387-2c1bed672102";
  static const String POTASSIUM_CHARACTERISTIC_UUID = "4db8ef1d-dd96-4a9c-89c7-d1338f30372f";
  // final apiUrl = Uri.parse(ApiConnect.createdetailland);

  static const String SERVICE_UUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String _temperature = "?";
  String _moisture = "?";
  String _ph = "?";
  String _nitrogen = "?";
  String _phosphor = "?";
  String _potassium = "?";

  late BluetoothCharacteristic _temperatureCharacteristic;
  late BluetoothCharacteristic _moistureCharacteristic;
  late BluetoothCharacteristic _phCharacteristic;
  late BluetoothCharacteristic _nitrogenCharacteristic;
  late BluetoothCharacteristic _phosphorCharacteristic;
  late BluetoothCharacteristic _potassiumCharacteristic;

  final apiUrl =
      Uri.parse(ApiConnect.createdetailland); // Update with your actual API URL
  bool _isLoading = false; // Add loading state
  int _countdown = 15; // Duration for measurement countdown
  Timer? _countdownTimer; // Timer for countdown

  @override
  void initState() {
    super.initState();
    _findCharacteristics();
    _printPreferences();
  }

  Future<void> _findCharacteristics() async {
    List<BluetoothService> services =
        await widget.device.discoverServices(); // Akses widget.device
    for (BluetoothService service in services) {
      if (service.uuid.toString() == SERVICE_UUID) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.uuid.toString() == TEMP_CHARACTERISTIC_UUID) {
            _temperatureCharacteristic = characteristic;
            _startListeningToTemperatureCharacteristic();
          } else if (characteristic.uuid.toString() ==
              MOISTURE_CHARACTERISTIC_UUID) {
            _moistureCharacteristic = characteristic;
            _startListeningToMoistureCharacteristic();
          } else if (characteristic.uuid.toString() == PH_CHARACTERISTIC_UUID) {
            _phCharacteristic = characteristic;
            _startListeningToPhCharacteristic();
          } else if (characteristic.uuid.toString() ==
              NITROGEN_CHARACTERISTIC_UUID) {
            _nitrogenCharacteristic = characteristic;
            _startListeningToNitrogenCharacteristic();
          } else if (characteristic.uuid.toString() ==
              PHOSPHOR_CHARACTERISTIC_UUID) {
            _phosphorCharacteristic = characteristic;
            _startListeningToPhosphorCharacteristic();
          } else if (characteristic.uuid.toString() ==
              POTASSIUM_CHARACTERISTIC_UUID) {
            _potassiumCharacteristic = characteristic;
            _startListeningToPotassiumCharacteristic();
          }
        }
      }
    }
  }

  Future<void> _printPreferences() async {
    final SharedPreferences prefs = await _prefs;
    String? temperature = prefs.getString('temperature');
    String? moisture = prefs.getString('moisture');
    String? ph = prefs.getString('ph');
    String? nitrogen = prefs.getString('nitrogen');
    String? phosphor = prefs.getString('phosphor');
    String? potassium = prefs.getString('potassium');

    print('Temperature: $temperature');
    print('Moisture: $moisture');
    print('pH: $ph');
    print('Nitrogen: $nitrogen');
    print('Phosphor: $phosphor');
    print('Potassium: $potassium');
  }

  void _startListeningToTemperatureCharacteristic() {
    _temperatureCharacteristic.setNotifyValue(true);
    _temperatureCharacteristic.value.listen((value) {
      String data = utf8.decode(value);
      _temperatureDataParser(data);
    });
  }

  void _startListeningToMoistureCharacteristic() {
    _moistureCharacteristic.setNotifyValue(true);
    _moistureCharacteristic.value.listen((value) {
      String data = utf8.decode(value);
      _moistureDataParser(data);
    });
  }

  void _startListeningToPhCharacteristic() {
    _phCharacteristic.setNotifyValue(true);
    _phCharacteristic.value.listen((value) {
      String data = utf8.decode(value);
      _phDataParser(data);
    });
  }

  void _startListeningToNitrogenCharacteristic() {
    _nitrogenCharacteristic.setNotifyValue(true);
    _nitrogenCharacteristic.value.listen((value) {
      String data = utf8.decode(value);
      _nitrogenDataParser(data);
    });
  }

  void _startListeningToPhosphorCharacteristic() {
    _phosphorCharacteristic.setNotifyValue(true);
    _phosphorCharacteristic.value.listen((value) {
      String data = utf8.decode(value);
      _phosphorDataParser(data);
    });
  }

  void _startListeningToPotassiumCharacteristic() {
    _potassiumCharacteristic.setNotifyValue(true);
    _potassiumCharacteristic.value.listen((value) {
      String data = utf8.decode(value);
      _potassiumDataParser(data);
    });
  }

  void _temperatureDataParser(String data) {
    setState(() {
      _temperature = data + "°C";
    });
    _saveToPreferences('temperature', data);
  }

  void _moistureDataParser(String data) {
    setState(() {
      _moisture = data + "%";
    });
    _saveToPreferences('moisture', data);
  }

  void _phDataParser(String data) {
    setState(() {
      _ph = data;
    });
    _saveToPreferences('ph', data);
  }

  void _nitrogenDataParser(String data) {
    setState(() {
      _nitrogen = data + "mg/kg";
    });
    _saveToPreferences('nitrogen', data);
  }

  void _phosphorDataParser(String data) {
    setState(() {
      _phosphor = data + "mg/kg";
    });
    _saveToPreferences('phosphor', data);
  }

  void _potassiumDataParser(String data) {
    setState(() {
      _potassium = data + "mg/kg";
    });
    _saveToPreferences('potassium', data);
  }

  Future<void> _saveToPreferences(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(key, value);
  }

  Future<void> submitData() async {
    setState(() {
      _isLoading = true; // Set loading state to true
    });

    // Start countdown
    _countdown = 5; // Reset countdown to 5 seconds
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--; // Decrease countdown
        });
      } else {
        timer.cancel(); // Stop the timer
        _sendData(); // Call function to send data
      }
    });
  }

  Future<void> _sendData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? landId = prefs.getInt('idLahan'); // Retrieve the saved land ID

    if (landId == null) {
      Fluttertoast.showToast(msg: "ID lahan tidak ditemukan.");
      return; // Stop further execution if land ID is null
    }

    // Parse and clean sensor values
    double nitrogen = _parseDoubleSafely(_nitrogen.split('mg/kg')[0]);
    double phosphor = _parseDoubleSafely(_phosphor.split('mg/kg')[0]);
    double potassium = _parseDoubleSafely(_potassium.split('mg/kg')[0]);
    double ph = _parseDoubleSafely(_ph);
    double temperature = _parseDoubleSafely(_temperature.split('°C')[0]);
    double moisture = _parseDoubleSafely(_moisture.split('%')[0]);

    final response = await http.post(
      apiUrl,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'land': landId, // Include land ID in the request
        'nitrogen': nitrogen,
        'fosfor': phosphor,
        'kalium': potassium,
        'ph': ph,
        'temperature': temperature,
        'moisture': moisture,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Fluttertoast.showToast(msg: "Data berhasil dikirim!");

      // Hapus land ID dari SharedPreferences
      await prefs.remove('idLahan');

      // Navigasi ke halaman Home
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Home()), // Ganti HalamanTujuan dengan halaman yang diinginkan
      ); //
    } else {
      print("Response code: ${response.statusCode}");
      print("Response body: ${response.body}");
      Fluttertoast.showToast(msg: "Gagal mengirim data: ${response.body}");
    }

    setState(() {
      _isLoading = false; // Reset loading state
      _countdown = 5; // Reset countdown for next submission
    });
  }

  @override
  Widget build(BuildContext context) {
    // Cetak nilai-nilai untuk debugging
    print(
        'Temperature: $_temperature'); // Untuk cek apakah nilai String dari sensor benar
    print(
        'Parsed Temperature: ${_parseDoubleSafely(_temperature)}'); // Cek hasil parsing ke double
    print(
        'Moisture: $_moisture'); // Untuk cek apakah nilai String dari sensor benar
    print(
        'Parsed Moisture: ${_parseDoubleSafely(_moisture)}'); // Cek hasil parsing ke double
    return Scaffold(
      appBar: AppBar(
        title: Text('Soil Nutrient Monitoring'),
        backgroundColor: Color(0xFF2E5F4C),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                padding: const EdgeInsets.all(10),
                children: <Widget>[
                  buildCardWithGauge(
                      'Suhu', _parseDoubleSafely(_temperature), 4),
                  buildCardWithGauge(
                      'Kelembapan', _parseDoubleSafely(_moisture), 5),
                  buildCardWithGauge('pH Tanah', _parseDoubleSafely(_ph), 3),
                  buildCardWithGauge(
                      'Nitrogen', _parseDoubleSafely(_nitrogen), 0),
                  buildCardWithGauge(
                      'Fosfor', _parseDoubleSafely(_phosphor), 1),
                  buildCardWithGauge(
                      'Kalium', _parseDoubleSafely(_potassium), 2),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading // Disable button when loading
                  ? null
                  : () {
                      submitData(); // Call the submit data function
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2E5F4C),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: _isLoading // Show countdown or loading indicator
                  ? Text('Saving... ($_countdown s)')
                  : Text('Simpan'),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  double _parseDoubleSafely(String value) {
    // Cek jika nilai kosong atau tanda tanya
    if (value.isEmpty || value == '?') {
      return 0.0; // Kembalikan 0.0 jika kosong atau tanda tanya
    }

    // Bersihkan semua karakter selain angka, titik desimal, dan tanda minus
    String cleanedValue = value.replaceAll(RegExp(r'[^0-9.-]'), '').trim();

    try {
      return double.parse(cleanedValue);
    } catch (e) {
      print('Error parsing value: $e');
      return 0.0; // Default value jika parsing gagal
    }
  }

  Color getBackgroundColor(int index) {
    if (index == 0) return Color.fromARGB(255, 253, 255, 224);
    if (index == 1) return Color.fromARGB(255, 209, 255, 229);
    if (index == 2) return Color.fromARGB(255, 209, 255, 229);
    if (index == 3) return Color.fromARGB(255, 253, 255, 224);
    if (index == 4) return Color.fromARGB(255, 253, 255, 224);
    if (index == 5) return Color.fromARGB(255, 209, 255, 229);
    return Color.fromARGB(255, 253, 255, 224);
  }

  Widget buildCardWithGauge(String title, double value, int index) {
    return Card(
      color: getBackgroundColor(index),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18)),
            Expanded(
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    ranges: <GaugeRange>[
                      GaugeRange(
                          startValue: 0, endValue: 100, color: Colors.green),
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(value: value),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Container(
                          child: Text(
                            value.toStringAsFixed(1),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        angle: 90,
                        positionFactor: 0.5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
