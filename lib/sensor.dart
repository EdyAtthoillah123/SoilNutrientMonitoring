import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Sensor extends StatefulWidget {
  @override
  SensorState createState() => SensorState();
}

class SensorState extends State<Sensor> {
  final Random random = Random();
  final List<double> values = List.generate(6, (_) => 0.0);

  @override
  void initState() {
    super.initState();
    // Set timer to update the gauge values every 3 seconds
    Timer.periodic(Duration(seconds: 3), (Timer t) {
      setState(() {
        for (int i = 0; i < values.length; i++) {
          values[i] =
              random.nextDouble() * 100; // Random value between 0 and 100
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor'),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 10, // Horizontal spacing between cards
                mainAxisSpacing: 10, // Vertical spacing between cards
                padding: const EdgeInsets.all(10), // Padding around the grid
                children: <Widget>[
                  buildCardWithGauge('Natrium', values[0], 0),
                  buildCardWithGauge('Fosfor', values[1], 1),
                  buildCardWithGauge('Kalium', values[2], 2),
                  buildCardWithGauge('Ph Tanah', values[3], 3),
                  buildCardWithGauge('Suhu', values[4], 4),
                  buildCardWithGauge('Kelembapan', values[5], 5),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ), // Spacer untuk memberi jarak antara GridView dan tombol
            ElevatedButton(
              onPressed: () {
                // Tambahkan aksi yang Anda inginkan saat tombol ditekan
                print('Tombol ditekan!');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color(0xFF2E5F4C), // Warna latar belakang tombol
                foregroundColor: Colors.white, // Warna teks tombol
                padding: EdgeInsets.symmetric(
                    horizontal: 50, vertical: 15), // Ukuran tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Border radius 5px
                ),
              ),
              child: Text('Selanjutnya'),
            ),
            SizedBox(height: 50), // Spacer tambahan di bawah tombol
          ],
        ),
      ),
    );
  }

  // Fungsi untuk menentukan warna latar belakang berdasarkan nilai
  Color getBackgroundColor(int index) {
    if (index == 0) {
      return Color.fromARGB(255, 253, 255, 224); 
    }
    if (index == 1) {
      return Color.fromARGB(255, 209, 255, 229); 
    }
    if (index == 2) {
      return Color.fromARGB(255, 209, 255, 229);
    }
    if (index == 3) {
      return Color.fromARGB(255, 253, 255, 224); 
    }
    if (index == 4) {
      return Color.fromARGB(255, 253, 255, 224); 
    }
    if (index == 5) {
      return Color.fromARGB(255, 209, 255, 229);
    } else {
      return Color.fromARGB(255, 253, 255, 224); 
    }
  }

  // Contoh fungsi buildCardWithGauge, sesuaikan dengan implementasi Anda
  Widget buildCardWithGauge(String title, double value, int index) {
    return Card(
      color: getBackgroundColor(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      elevation: 5, // Shadow on the card
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Atur teks ke pojok kiri
          crossAxisAlignment:
              CrossAxisAlignment.start, // Atur teks ke pojok kiri
          children: [
            Text(
              title, // Menggunakan parameter title untuk teks
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Expanded(
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    ranges: <GaugeRange>[
                      GaugeRange(
                        startValue: 0,
                        endValue: 100,
                        color: Colors.green,
                      ),
                      // GaugeRange(
                      //   startValue: 50,
                      //   endValue: 100,
                      //   color: Colors.red,
                      // ),
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(
                        value: value, // Value for each gauge
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Container(
                          child: Text(
                            value.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
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
