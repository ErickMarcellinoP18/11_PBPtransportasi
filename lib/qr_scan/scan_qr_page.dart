import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transportasi_11/constant/app_constant.dart';
import 'package:transportasi_11/qr_scan/scanner_error_widget.dart';
import 'package:screen_brightness/screen_brightness.dart';

import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerPageView extends StatefulWidget {
  const BarcodeScannerPageView({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerPageView> createState() => _BarcodeScannerPageViewState();
}

class _BarcodeScannerPageViewState extends State<BarcodeScannerPageView>
    with SingleTickerProviderStateMixin {
  BarcodeCapture? barcodeCapture;

  double _brightnessValue = 0.1; // Kecerahan awal (0-1)
  double _initialBrightness = 0.5; // Kecerahan awal yang disimpan
  ScreenBrightness screenBrightness = ScreenBrightness();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        children: [
          cameraView(),
          Container(),
        ],
      ),
    );
  }

  Widget cameraView() {
    return Builder(
      builder: (context) {
        return Stack(
          children: [
            MobileScanner(
              startDelay: true,
              controller: MobileScannerController(torchEnabled: false),
              fit: BoxFit.contain,
              errorBuilder: (context, error, child) {
                return ScannerErrorWidget(error: error);
              },
              onDetect: (capture) => setBarcodeCapture(capture),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 100,
                color: Colors.black.withOpacity(0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 120,
                        height: 50,
                        child: FittedBox(
                          child: FloatingActionButton(
                            onPressed: () => getURLResult(),
                            child: const Text("Scan"),
                          ),
                        ),
                      ),
                    ),
                    // barcodeCaptureTextResult(context),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Text barcodeCaptureTextResult(BuildContext context) {
    return Text(
      barcodeCapture?.barcodes.first.rawValue ??
          LabelTextConstant.scanQrPlaceHolderLabel,
      overflow: TextOverflow.fade,
      style: Theme.of(context)
          .textTheme
          .headlineMedium!
          .copyWith(color: Colors.white),
    );
  }

  void setBarcodeCapture(BarcodeCapture capture) {
    setState(() {
      barcodeCapture = capture;
    });
  }

  void getURLResult() {
    final qrCode = barcodeCapture?.barcodes.first.rawValue;

    if (qrCode != null) {
      copyToClipboard(qrCode);
      setMaxBrightness();
      resetBrightnessAfterDelay(Duration(seconds: 5));
    }
  }

  void showSnackbarError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content:
            Text('QR code tidak valid', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
    );
  }

  void copyToClipboard(String text) {
    // if (text.contains('pbptransport')) {
    //   Clipboard.setData(ClipboardData(text: text));
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Valid Legit', style: TextStyle(color: Colors.white)),
    //       backgroundColor: Colors.green,
    //     ),
    //   );
    // } else {
    //   showSnackbarError();
    // }

    if (text.contains('pbptransport')) {
      Clipboard.setData(ClipboardData(text: text));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Valid Legit', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      showSnackbarError();
    }
  }

////////Brightness
  Future<void> setMaxBrightness() async {
    await screenBrightness.setScreenBrightness(1.0);

    setState(() {
      _brightnessValue = 1.0;
    });
  }

  Future<void> resetBrightness() async {
    await screenBrightness.setScreenBrightness(_initialBrightness);

    setState(() {
      _brightnessValue = _initialBrightness;
    });
  }

  Future<void> resetBrightnessAfterDelay(Duration delay) async {
    await Future.delayed(delay);
    resetBrightness();
    setState(() {});
  }
}
