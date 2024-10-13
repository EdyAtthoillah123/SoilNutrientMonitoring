import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'homepage.dart';
import 'Api/Api_Connect.dart';
import 'package:http/http.dart' as http;

class ConnectedDevicePage extends StatefulWidget {
  final BluetoothDevice device;

  const ConnectedDevicePage({Key? key, required this.device}) : super(key: key);

  @override
  _ConnectedDevicePageState createState() => _ConnectedDevicePageState();
}

class _ConnectedDevicePageState extends State<ConnectedDevicePage> {
  static const String TEMP_CHARACTERISTIC_UUID = "68a6e0f2-5429-496c-883a-ac5d8a87de9b";
  static const String MOISTURE_CHARACTERISTIC_UUID = "e54f29d4-1b0e-4d44-bd4e-43f5d5c40f50";
  static const String PH_CHARACTERISTIC_UUID = "551a162b-e2e0-4c3a-ab36-6d6668a6e5ad";
  static const String NITROGEN_CHARACTERISTIC_UUID = "8ffef044-1203-41e2-8281-e65626b6ad97";
  static const String PHOSPHOR_CHARACTERISTIC_UUID = "1195044f-9b1a-4834-a387-2c1bed672102";
  static const String POTASSIUM_CHARACTERISTIC_UUID = "4db8ef1d-dd96-4a9c-89c7-d1338f30372f";
  final apiUrl = Uri.parse(ApiConnect.createdetailland);

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

  @override
  void initState() {
    super.initState();
    _findCharacteristics();
    _printPreferences();
  }

  Future<void> _findCharacteristics() async {
    List<BluetoothService> services = await widget.device.discoverServices();
    for (BluetoothService service in services) {
      if (service.uuid.toString() == SERVICE_UUID) {
        for (BluetoothCharacteristic characteristic in service.characteristics) {
          if (characteristic.uuid.toString() == TEMP_CHARACTERISTIC_UUID) {
            _temperatureCharacteristic = characteristic;
            _startListeningToTemperatureCharacteristic();
          } else if (characteristic.uuid.toString() == MOISTURE_CHARACTERISTIC_UUID) {
            _moistureCharacteristic = characteristic;
            _startListeningToMoistureCharacteristic();
          } else if (characteristic.uuid.toString() == PH_CHARACTERISTIC_UUID) {
            _phCharacteristic = characteristic;
            _startListeningToPhCharacteristic();
          } else if (characteristic.uuid.toString() == NITROGEN_CHARACTERISTIC_UUID) {
            _nitrogenCharacteristic = characteristic;
            _startListeningToNitrogenCharacteristic();
          } else if (characteristic.uuid.toString() == PHOSPHOR_CHARACTERISTIC_UUID) {
            _phosphorCharacteristic = characteristic;
            _startListeningToPhosphorCharacteristic();
          } else if (characteristic.uuid.toString() == POTASSIUM_CHARACTERISTIC_UUID) {
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

   // New state variables
  bool _isLoading = false;
  int _countdown = 0;
  Timer? _countdownTimer;

  // Update the existing methods...

  Future<void> submitData() async {
    setState(() {
      _isLoading = true; // Set loading state to true
    });

    // Start countdown
    _countdown = 300; // Reset countdown to 15 seconds
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

    final response = await http.post(
      // Uri.parse('https://example.com/api/submit'), // Replace with your API URL
      apiUrl,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'land': landId, // Include land ID in the request
        'nitrogen': _nitrogen.split('mg/kg')[0],
        'fosfor': _phosphor.split('mg/kg')[0],
        'kalium': _potassium.split('mg/kg')[0],
        'ph': _ph,
        'temperature': _temperature.split('°C')[0],
        'moisture': _moisture.split('%')[0],
      }),
    );

    if (response.statusCode == 201) {
      // Handle success
      print('Data submitted successfully: ${response.body}');
    } else {
      // Handle error
      print('Failed to submit data: ${response.body}');
    }

    setState(() {
      _isLoading = false; // Set loading state to false
    });

    _countdownTimer?.cancel(); // Cancel the countdown timer
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()), // Navigate to your desired page
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Connected to ${widget.device.remoteId.str}'),
            SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 20,
              children: [
                _buildGauge('Temperature', _temperature, '°C', 0, 100),
                _buildGauge('Moisture', _moisture, '%', 0, 100),
                _buildGauge('pH', _ph, '', 0, 14),
                _buildGauge('Nitrogen', _nitrogen, 'mg/kg', 0, 1000),
                _buildGauge('Phosphor', _phosphor, 'mg/kg', 0, 1000),
                _buildGauge('Potassium', _potassium, 'mg/kg', 0, 1000),
              ],
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: _isLoading // Show countdown or loading indicator
                  ? Text('Saving... ($_countdown s)')
                  : Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGauge(String label, String value, String unit, double min, double max) {
    double doubleValue;
    try {
      doubleValue = double.parse(value.split(unit)[0]);
    } catch (e) {
      doubleValue = 0;
    }

    return Column(
      children: [
        Text('$label: $value', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(
          width: 150,
          height: 150,
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: min,
                maximum: max,
                ranges: <GaugeRange>[
                  GaugeRange(startValue: min, endValue: max * 0.25, color: Colors.red),
                  GaugeRange(startValue: max * 0.25, endValue: max * 0.75, color: Colors.orange),
                  GaugeRange(startValue: max * 0.75, endValue: max, color: Colors.green),
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(value: doubleValue),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    widget: Container(
                     
                      child: Text(value,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    angle: 90,
                    positionFactor: 0.5,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
