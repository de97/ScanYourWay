import 'package:flutter/material.dart';
import 'package:scanyourway/screens/item_screen.dart';
import './screens/reviews_screen.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String name;
  final String imageUrl;

  ProductItem(this.id, this.name, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ItemExpanded.routeName, arguments: id,
        );
      },
      child: Container(
        height: 80,
        child: Card(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(
                  left: 10,
                ),
                child: Text(name)),
            Padding(
              padding: EdgeInsets.all(10),
              child: Image.network(
                  imageUrl),
            ),
          ],
        )),
      ),
    );
  }
}

class FavouritesProductItem extends StatefulWidget {
  @override
  _FavouritesProductItemState createState() => _FavouritesProductItemState();
  final String id;
  final String name;
  final String imageUrl;

  FavouritesProductItem(this.id, this.name, this.imageUrl);
}

class _FavouritesProductItemState extends State<FavouritesProductItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ItemExpanded.routeName, arguments: widget.id,
        );
      },
      child: Container(
        height: 80,
        child: Card(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(
                  left: 10,
                ),
                child: Text(widget.name)),
            Padding(
              padding: EdgeInsets.all(10),
              child: Image.network(
                  widget.imageUrl),
            ),
          ],
        )),
      ),
    );
  }
}
// child: GestureDetector(
//             onTap: () {
//               Navigator.of(context).pushNamed(ItemExpanded.routeName,
//                   arguments: {'id': id, 'name': name});
//             },
