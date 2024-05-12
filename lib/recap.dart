import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),

        useMaterial3: true,
      ),
      home: const Recap(title: 'Recap'),
    );
  }
}

class Recap extends StatefulWidget {
  const Recap({super.key, required this.title});
  final String title;

  @override
  State<Recap> createState() => _RecapState();
}

class _RecapState extends State<Recap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lahan Polije',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Divider(),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Natrium:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Nilai Natrium'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Fosfor:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Nilai Fosfor'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kalium:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Nilai Kalium'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ph:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Nilai Ph'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Suhu:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Nilai Suhu'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kelembapan:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Nilai Kelembapan'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Saran Tanaman:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Saran untuk tanaman'),
                  SizedBox(height: 8),
                  Text(
                    'Saran Perbaikan Lahan:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Saran untuk perbaikan lahan'),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        // Aksi ketika tombol kembali ditekan
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back),
                      backgroundColor: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}