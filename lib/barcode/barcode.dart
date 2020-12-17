import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../screens/item_screen.dart';


class MyBarcode extends StatefulWidget {
  @override
  _MyBarcodeState createState() => _MyBarcodeState();
}

class _MyBarcodeState extends State<MyBarcode> {

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {}
    print('hello');
    // setState(() {
    //   Navigator.of(context).pushNamed(
    //     ItemScreen.routeName,
    //     arguments: barcodeScanRes,
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
        home: Scaffold(body: Builder(builder: (BuildContext context) {
      return Container(
        alignment: Alignment.center,
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(onPressed: () => scanBarcodeNormal()),
          ],
        ),
      );
    })));
  }
}
