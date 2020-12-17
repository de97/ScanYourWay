import 'package:flutter/material.dart';
import 'package:scanyourway/barcode/barcode.dart';
import 'package:scanyourway/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/my_account_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        AppBar(
          title: Text('ScanYourWay',),
          //never display a back button even if it thinks you can go bavk
        ),
        Divider(),
        ListTile(
            leading: Icon(Icons.account_box),
            title: Text('My Account'),
            onTap: () {
            Navigator.of(context).pushNamed(MyAccountScreen.routeName);
            }),
        Divider(),
        ListTile(
           leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              FirebaseAuth.instance.signOut();
            }),
      ],
    ));
  }
}
