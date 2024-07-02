// import 'package:flutter_blue_plugin/flutter_blue_plugin.dart' as fb;
import 'package:get/get.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

class BleController extends GetxController {
  FlutterBlue ble = FlutterBlue.instance;

  Future<void> scanDevices() async {
    if (await Permission.bluetoothScan.request().isGranted) {
      if (await Permission.bluetoothConnect.request().isGranted) {
        ble.startScan(timeout: Duration(seconds: 10));
        ble.stopScan();
      }
    }
  }

  Stream<List<ScanResult>> get scanResults => ble.scanResults;
}
