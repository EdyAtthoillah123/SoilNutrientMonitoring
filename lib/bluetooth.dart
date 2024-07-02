import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'ble_controller.dart';

class Bluetooth extends StatefulWidget {
  const Bluetooth({Key? key}) : super(key: key);

  @override
  State<Bluetooth> createState() => _BluetoothState();
}

class _BluetoothState extends State<Bluetooth> {
  final BleController bleController = Get.put(BleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: Text("BLE Scan"),
  ),
  body: GetBuilder<BleController>(
    builder: (controller) {
      return SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<List<ScanResult>>(
                stream: controller.scanResults,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data![index];
                        return Card(
                          elevation: 2,
                          child: ListTile(
                            title: Text(data.device.name ?? "Unknown"),
                            subtitle: Text(data.device.id.id),
                            trailing: Text(data.rssi.toString()),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text("No Data Found"),);
                  }
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  controller.scanDevices();
                },
                child: Text("Scan"),
              ),
            ],
          ),
        ),
      );
    },
  ),
);

  }
}
