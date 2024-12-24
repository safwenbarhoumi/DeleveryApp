import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'fitness_app/fitness_app_theme.dart';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
  const Scan({Key? key, required this.animationController}) : super(key: key);
  final AnimationController? animationController;
}

class _ScanState extends State<Scan> {
  String _scanBarcode = 'Unknown';
  Animation<double>? topBarAnimation;
  double topBarOpacity = 0.0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double paddingTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading:
            false, // Set to true if you want a back button
        elevation: 0.0,
        flexibleSpace: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.only(
                top: paddingTop - 10,
                left: screenWidth * 0.02,
                right: screenWidth * 0.04,
                bottom: screenHeight * 2.01,
              ),
              sliver: SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor:
                    FitnessAppTheme.white.withOpacity(topBarOpacity),
                elevation: 0.0,
                flexibleSpace: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.02),
                          child: Text(
                            'Scann',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: FitnessAppTheme.fontName,
                              fontWeight: FontWeight.w700,
                              fontSize: 22 + 6 - 6 * topBarOpacity,
                              letterSpacing: 1.2,
                              color: FitnessAppTheme.darkerText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Builder(builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                  horizontal: screenWidth * 0.1,
                ),
                child: ElevatedButton(
                  onPressed: () => scanBarcodeNormal(),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 8, 12, 229),
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: screenHeight * 0.025,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.025,
                      horizontal: screenWidth * 0.15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                    ),
                    elevation: 8,
                    shadowColor:
                        Color.fromARGB(255, 21, 0, 255).withOpacity(0.6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.barcode_reader), // Icon added here
                      SizedBox(width: screenWidth * 0.03),
                      Text('Barcode scan'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.015,
                  horizontal: screenWidth * 0.1,
                ),
                child: ElevatedButton(
                  onPressed: () => scanQR(),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 51, 0, 255),
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: screenHeight * 0.025,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.025,
                      horizontal: screenWidth * 0.25,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                    ),
                    elevation: 8,
                    shadowColor:
                        Color.fromARGB(255, 51, 0, 255).withOpacity(0.6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code), // Icon added here
                      SizedBox(width: screenWidth * 0.03),
                      Text('QR scan'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Text(
                  'Scan result: $_scanBarcode\n',
                  style: TextStyle(
                      fontSize: screenHeight * 0.03, color: Colors.black38),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
