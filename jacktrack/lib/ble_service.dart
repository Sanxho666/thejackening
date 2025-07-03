import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleService {
  final FlutterBluePlus _flutterBlue = FlutterBluePlus();
  Stream<List<ScanResult>> get scanResults => _flutterBlue.scanResults;

  void startScan() {
    _flutterBlue.startScan(timeout: const Duration(seconds: 4));
  }

  void stopScan() {
    _flutterBlue.stopScan();
  }

  Future<void> connect(BluetoothDevice device) async {
    await device.connect();
  }

  void disconnect(BluetoothDevice device) {
    device.disconnect();
  }
}
