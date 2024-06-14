import 'package:flutter/material.dart';

class LaporanFour extends StatefulWidget {
  @override
  _LaporanFourState createState() => _LaporanFourState();
}

class _LaporanFourState extends State<LaporanFour> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NutriSoil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _textController,
                              decoration: InputDecoration(
                                labelText: 'Masukkan Nama Lahan',
                                border: UnderlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (int i = 1; i <= 5; i++) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                        child: Row(
                          children: [
                            Text(
                              "Titik $i",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                (i == 1 || i == 2) ? Icons.check : Icons.close, // Conditional icon
                                color: (i == 1 || i == 2) ? Colors.green : Colors.red, // Conditional color
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                        child: Container(
                          height: 2,
                          width: MediaQuery.of(context).size.width - 40,
                          color: Color.fromARGB(255, 160, 160, 160),
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Row(
                        children: [
                          Text(
                            "Laporan",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: Container(
                          height: 2,
                          width: MediaQuery.of(context).size.width - 40,
                          color: Color.fromARGB(255, 160, 160, 160),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          "Laporan lahan akan tampil ketika data sensor pada 5 titik lahan terbaca",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          textAlign: TextAlign.center, // Center the text
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ]),
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}


