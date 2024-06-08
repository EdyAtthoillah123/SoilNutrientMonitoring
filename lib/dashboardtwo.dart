import 'package:flutter/material.dart';

class DashboardTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nutrisoil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green, // Set the navbar color to green
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green, // Set the drawer header color to green
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/profile_wishal.jpg'), // Path to your profile image
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Wishal Azharyan Al Hisyam',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                   Text(
                    'wishal123@gmail.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.black),
              title: Text('Home', style: TextStyle(color: Colors.black)),
              onTap: () {
                // Navigate to the home screen
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.black),
              title: Text('Settings', style: TextStyle(color: Colors.black)),
              onTap: () {
                // Navigate to the settings screen
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.black),
              title: Text('Logout', style: TextStyle(color: Colors.black)),
              onTap: () {
                // Handle logout action
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: // Add space for the AppBar
                Container(
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
                            "Lahan 1",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 64, 144, 75),
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              "Normal",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
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
                      child: Text(
                        "Lahan tidak mempunyai faktor pembatas yang berarti atau nyata  terhadap penggunaan berkelanjutan, atau hanya mempunyai faktor  pembatas yang bersifat minor dan tidak mereduksi produktivitas lahan  secara nyata. \nRata Rata Unsur Hara Tanah \nNatrium : 0.35% \nFosfor    : 27 ppm \nKalium   : 50 mg/100gr \nPh          : 5,5 H2O \nSuhu      : 32 Derajat \nKelembapan  : 40% Saran Tanaman : Jagung",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 20.0, top: 10),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            "Detail",
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    )
                  ]),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle button press
        },
        backgroundColor: Colors.green,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        shape: CircleBorder(),
      ),
    );
  }
}
