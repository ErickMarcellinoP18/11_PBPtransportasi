import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:transportasi_11/component/passComp.dart';
import 'package:transportasi_11/view/login.dart';
import 'package:transportasi_11/component/form_component.dart';
import 'package:transportasi_11/database/sql_helper.dart';
import 'package:transportasi_11/data/user.dart';
import 'package:intl/intl.dart';
import 'package:transportasi_11/view/TicketPage.dart';
void main() {
  runApp(const BrightnessControlApp());
}

class BrightnessControlApp extends StatefulWidget {
  const BrightnessControlApp({Key? key}) : super(key: key);

  @override
  _BrightnessControlAppState createState() => _BrightnessControlAppState();
}

class _BrightnessControlAppState extends State<BrightnessControlApp> {
  // TODO: Inisialisasi sensor gyro dan pengaturan kecerahan
  double _brightness = 1.0; // Atur kecerahan awal
  bool _isDeviceMoving = false; // Status perangkat bergerak atau tidak

  @override
  void initState() {
    super.initState();
    // TODO: Mulai sensor gyro
    // Code untuk mengatur sensor gyro dan mendengarkan perubahan status perangkat
  }

  @override
  void dispose() {
    // TODO: Berhenti mendengarkan sensor ketika widget di dispose
    super.dispose();
  }

  void setScreenBrightness(double brightnessValue) {
    // TODO: Code untuk mengatur kecerahan layar berdasarkan nilai brightnessValue
    // Contoh: Menyetel kecerahan layar menggunakan plugin eksternal
  }

  void handleDeviceMovement(bool isMoving) {
    // Fungsi untuk menangani perubahan status perangkat bergerak atau tidak
    setState(() {
      _isDeviceMoving = isMoving;
      if (!_isDeviceMoving) {
        // Perangkat tidak bergerak, kurangi kecerahan layar
        setScreenBrightness(0.5); // Contoh: Set kecerahan ke 50%
      } else {
        // Perangkat bergerak, kembalikan kecerahan layar ke nilai awal
        setScreenBrightness(1.0); // Contoh: Set kecerahan ke 100%
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brightness Control App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Brightness Control'),
        ),
        body: Center(
          child: Text(
            _isDeviceMoving ? 'Device is moving' : 'Device is not moving',
          ),
        ),
      ),
    );
  }
}
