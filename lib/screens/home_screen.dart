import 'package:flutter/material.dart';
import 'package:scanyourway/screens/product_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/favourites.dart';
import '../widgets/app_drawer.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import '../screens/item_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        //centerTitle: true,
        title: Container(padding: EdgeInsets.all(70), child: Text("ScanYourWay")),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 12,
          ),
          ScrollButton(),
          StreamBuilder(
              stream: Firestore.instance.collection('categories').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final doc = snapshot.data.documents;
                  return Container(
                    height: 230,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) => ScrollButton1(
                        doc[index].documentID,
                        doc[index]['name'],
                        doc[index]['imageUrl'],
                      ),
                    ),
                  );
                } else {
                  return Text('No data');
                }
              }),
        ],
      ),
      bottomNavigationBar: Container(
        height: 170,
        color: Colors.indigo,
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(14),
          child: ListTile(
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'How it works?',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'ScanYourWay provides you with customer reviews on a wide range of products. Click the scanner button above to scan a product',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class Hello extends StatelessWidget {
 static const routeName = '/practice';

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

class GridTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ScrollButton extends StatefulWidget {
  @override
  _ScrollButtonState createState() => _ScrollButtonState();
}

class _ScrollButtonState extends State<ScrollButton> {
  @override
  Widget build(BuildContext context) {
    Future<void> scanBarcodeNormal() async {
      String barcodeScanRes;
      try {
        barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            "#ff6666", "Cancel", true, ScanMode.BARCODE);
        print(barcodeScanRes);
      } on PlatformException {}
      print('barcode$barcodeScanRes');
      setState(() {
        Navigator.of(context).pushNamed(
          ItemScreen.routeName,
          arguments: barcodeScanRes,
        );
        
      });
    }
    return Container(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Column(
              children: <Widget>[
                Container(
                  height: 120,
                  width: 150,
                  child: Card(
                      color: Colors.blue,
                      child: IconButton(
                        onPressed: () => scanBarcodeNormal(),
                        icon: Icon(
                          Icons.camera_rear,
                          size: 100,
                          color: Colors.white,
                        ),
                      )),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      'Scanner',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Favourites()));
            },
            child: Column(
              children: <Widget>[
                Container(
                  height: 120,
                  width: 150,
                  child: Card(
                      color: Colors.blue,
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          size: 100,
                          color: Colors.white,
                        ),
                      )),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      'Favourites',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                height: 120,
                width: 150,
                child: Card(
                    color: Colors.blue,
                    child: IconButton(
                      icon: Icon(
                        Icons.account_box,
                        size: 100,
                        color: Colors.white,
                      ),
                    )),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'My Account',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

class ScrollButton1 extends StatelessWidget {
  //final String imageUrl;
  final String id;
  final String name;
  final String imageUrl;

  ScrollButton1(
    this.id,
    this.name,
    this.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    print(imageUrl);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ProductsScreen.routeName,
            arguments: {'id': id, 'name': name});
      },
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 160,
                width: 300,
                color: Colors.blue,
                margin: EdgeInsets.all(8),
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
              Positioned(
                left: 9,
                bottom: 9,
                child: Container(
                  height: 160,
                  width: 300,
                  color: Colors.black54,
                ),
              ),
              Positioned(
                bottom: 53,
                left: 35,
                child: Container(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
