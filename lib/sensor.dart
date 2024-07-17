import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'Api/Api_Connect.dart';
import 'homepage.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Sensor extends StatefulWidget {
  @override
  SensorState createState() => SensorState();
}

class SensorState extends State<Sensor> {
  final Random random = Random();
  final List<double> values = List.generate(6, (_) => 0.0);
  final apiUrl = Uri.parse(ApiConnect.createdetailland); // Update with your actual API URL
  bool _isLoading = false; // Add loading state
  int _countdown = 15; // Duration for measurement countdown
  Timer? _countdownTimer; // Timer for countdown

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (Timer t) {
      setState(() {
        for (int i = 0; i < values.length; i++) {
          values[i] = random.nextDouble() * 100; // Random value between 0 and 100
        }
      });
    });
  }

  Future<void> submitData() async {
    setState(() {
      _isLoading = true; // Set loading state to true
    });

    // Start countdown
    _countdown = 15; // Reset countdown to 15 seconds
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
      apiUrl,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'land': landId, // Include land ID in the request
        'nitrogen': values[0],
        'fosfor': values[1],
        'kalium': values[2],
        'ph': values[3],
        'temperature': values[4],
        'moisture': values[5],
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
    // Navigator.of(context).pop(); // Navigate back to the previous page
     Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()), // Ganti HalamanTujuan dengan halaman yang diinginkan
      ); // Navigate back to the previous page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor'),
        backgroundColor: Color(0xFF2E5F4C),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
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
                  buildCardWithGauge('Nitrogen', values[0], 0),
                  buildCardWithGauge('Fosfor', values[1], 1),
                  buildCardWithGauge('Kalium', values[2], 2),
                  buildCardWithGauge('pH Tanah', values[3], 3),
                  buildCardWithGauge('Suhu', values[4], 4),
                  buildCardWithGauge('Kelembapan', values[5], 5),
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                      GaugeRange(startValue: 0, endValue: 100, color: Colors.green),
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(value: value),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Container(
                          child: Text(
                            value.toStringAsFixed(1),
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

void main() {
  runApp(MaterialApp(
    home: Sensor(),
  ));
}
