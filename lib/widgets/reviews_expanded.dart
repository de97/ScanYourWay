import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';

class ReviewsExpanded extends StatelessWidget {
  final String header;
  final String description;
  final Timestamp date;
  final String username;
  final bool isMe;
  final String reviewId;
  final String userImage;
  final double starRating;

  ReviewsExpanded(
    this.header,
    this.description,
    this.date,
    this.username,
    this.isMe,
    this.reviewId,
    this.userImage,
    this.starRating,
  );

  @override
  Widget build(BuildContext context) {
    void _deleteReview() {
      final review =
          Firestore.instance.collection('reviews').document(reviewId);
      review.delete();
      Navigator.of(context).pop();
    }
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(userImage),
              radius: 40.0,
            ),
            Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  'Written By: $username',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Rating:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Text('$starRating'),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      (DateFormat('dd MMMM yyyy ').format(
                          new DateTime.fromMillisecondsSinceEpoch(
                              date.millisecondsSinceEpoch))),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text('$header',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
            ),
            Padding(padding: EdgeInsets.all(20), child: Text('$description')),
            isMe
                ? Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: RaisedButton(
                      onPressed: () => _deleteReview(),
                      child:
                          Text('Delete Review', style: TextStyle(fontSize: 16)),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
