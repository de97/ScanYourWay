import 'package:flutter/material.dart';
import '../widgets/bottom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/reviews_expanded.dart';


Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Hello'),),
  );
}

class ReviewsExpandedScreen extends StatelessWidget {
  static const routeName = '/ExpandedReviewsScreen';

  @override
  Widget build(BuildContext context) {
    final reviewId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("Reviews"),
      ),
      body: Container(
        height: 460,
        child: FutureBuilder(
            future: FirebaseAuth.instance.currentUser(),
            builder: (ctx, futureSnapshot) {
              if (futureSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return StreamBuilder(
                stream: Firestore.instance
                    .collection('reviews')
                    .document(reviewId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final doc = snapshot.data;
                  return ReviewsExpanded(
                    doc['name'],
                    doc['review'],
                    doc['createdAt'],
                    doc['username'],
                    doc['userId'] == futureSnapshot.data.uid,
                    reviewId,
                    doc['userImage'],
                    doc['starRating'],
                  );
                },
              );
            }),
      ),
      bottomNavigationBar: Bottom(),
    );
  }
}
