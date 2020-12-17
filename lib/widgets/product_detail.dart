import 'package:flutter/material.dart';
import 'package:scanyourway/screens/reviews_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductDetail extends StatefulWidget {
  final String id;
  final String name;
  final String details;
  final String imageUrl;
  // final double price;
  ProductDetail(this.id, this.name, this.details, this.imageUrl);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {


  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((user) async {
      final fav = await Firestore.instance
          .collection('favourites')
          .where('userId', isEqualTo: user.uid)
          .where('productId', isEqualTo: widget.id)
          .getDocuments();
      this.setState(() {
        isFavourite = fav.documents.length > 0 ? true : false;
      });
    });
  }

  void _addFavourites() async {
    final user = await FirebaseAuth.instance.currentUser();
    final userData =
        await Firestore.instance.collection('users').document(user.uid).get();
    Firestore.instance.collection('favourites').add({
      'productId': widget.id,
      'userId': user.uid,
      'username': userData['username'],
      'imageUrl': widget.imageUrl,
      'productname': widget.name,
    });
    this.setState(() {
      isFavourite = true;
    });
  }
//variabe undefined
//dont load info to true or false after
  bool isFavourite = false;

  void _deleteFavourites() async {
    final user = await FirebaseAuth.instance.currentUser();
    final fav = await Firestore.instance
        .collection('favourites')
        .where('userId', isEqualTo: user.uid)
        .where('productId', isEqualTo: widget.id)
        .getDocuments();
    if (fav.documents.length == 0) {
      this._addFavourites();
    } else {
      for (DocumentSnapshot doc in fav.documents) {
        doc.reference.delete();
      }
      this.setState(() {
        isFavourite = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Stack(children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.network(
                  widget.imageUrl),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Container(
                  width: 340,
                  color: Colors.black87,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text(
                   widget.name,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ReviewsScreen.routeName,
                      arguments: {'id': widget.id, 'name': widget.name});
                },
                child: Container(
                  width: 400,
                  color: Colors.indigo,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text(
                    'Go to Reviews',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              right: 0,
              child: Container(
                child: FlatButton(
                  onPressed: () => _deleteFavourites(),
                  child: Column(
                    children: <Widget>[
                      Icon(
                         Icons.favorite,
                        color: isFavourite ? Colors.red : Colors.black,
                        size: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              child: Column(
                children: <Widget>[
                  Text(
                    widget.details,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
