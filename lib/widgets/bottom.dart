import 'package:flutter/material.dart';
import 'package:scanyourway/screens/home_screen.dart';
import '../screens/favourites.dart';

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      //width: MediaQuery.of(context).size.width,
      color: Colors.indigo,
      child: Container(
         width: MediaQuery.of(context).size.width,
        margin:
            EdgeInsets.only(left: 8.0, top: 16.0, bottom: 10.0, right: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              child: FlatButton(
                onPressed: () => {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen())),
                },
                child: Column(
                  children: <Widget>[Icon(Icons.home, color: Colors.white,), Text("Home", style: TextStyle(color: Colors.white, fontSize: 16))],
                ),
              ),
            ),
            Container(
              child: FlatButton(
                onPressed: () => {},
                child: Column(
                  children: <Widget>[Icon(Icons.camera_rear, color: Colors.white,), Text("Scanner", style: TextStyle(color: Colors.white, fontSize: 16),)],
                ),
              ),
            ),
            Container(
              child: FlatButton(
                onPressed: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Favourites())),
                },
                child: Column(
                  children: <Widget>[Icon(Icons.favorite, color: Colors.white,), Text("Favourites", style: TextStyle(color: Colors.white, fontSize: 16))],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
