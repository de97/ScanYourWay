import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scanyourway/screens/new_review.dart';
import '../widgets/reviews.dart';
import '../widgets/bottom.dart';

enum FilterOptions {
  Posiitive,
  Negative,
  All,
}

class ReviewsScreen extends StatefulWidget {
  static const routeName = '/reviewScreen';

  @override
  _ReviewsScreenState createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  var _positive = false;
  var _negative = false;
  var _showAll = true;

  @override
  Widget build(BuildContext context) {
    String productName;
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    productName = routeArgs['name'];
    final productId = routeArgs['id'];
    return Scaffold(
      appBar: AppBar(
          title: Text("${productName}", textAlign: TextAlign.center),
          actions: [
            //197
            PopupMenuButton(
                onSelected: (FilterOptions selectedValue) {
                  this.setState(() {
                    if (selectedValue == FilterOptions.Posiitive) {
                      _positive = true;
                    } else {
                      _positive = false;
                    }
                    if (selectedValue == FilterOptions.Negative) {
                      _negative = true;
                    } else {
                      _negative = false;
                    }
                    if (selectedValue == FilterOptions.All) {
                      _showAll = true;
                    } else {
                      _showAll = false;
                    }
                  });
                },
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).primaryIconTheme.color,
                ),
                itemBuilder: (_) => [
                      PopupMenuItem(
                          child: Text('Positive Reviews'),
                          value: FilterOptions.Posiitive),
                      PopupMenuItem(
                          child: Text('Negative Reviews'),
                          value: FilterOptions.Negative),
                      PopupMenuItem(
                          child: Text('Show All'), value: FilterOptions.All),
                    ]),
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              color: Colors.indigo,
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(NewReview.routeName, arguments: productId);
                },
                child: Text(
                  'Add Review',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            Container(
              height: 460,
              child: FutureBuilder(
                  future: FirebaseAuth.instance.currentUser(),
                  builder: (ctx, futureSnapshot) {
                    if (futureSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (_positive == true) {
                      return StreamBuilder(
                        stream: Firestore.instance
                            .collection('reviews')
                            .where('productId', isEqualTo: productId)
                            .where('starRating', isGreaterThan: 3)
                            .snapshots(),
                        builder: (context, snapshot) {
                           if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasData) {
                            if (snapshot.data.documents.length > 0) {
                              final doc = snapshot.data.documents;
                              return ListView.builder(
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) => ReviewItem(
                                  doc[index].documentID,
                                  doc[index]['createdAt'],
                                  doc[index]['name'],
                                  doc[index]['review'],
                                  doc[index]['starRating'],
                                  doc[index]['username'],
                                  doc[index]['userId'] ==
                                      futureSnapshot.data.uid,
                                  key: ValueKey(doc[index].documentID),
                                ),
                              );
                            } else {
                              return Center(
                                  child: Text(
                                      'Sorry there are no positive reviews'));
                            }
                          } else {
                            print('no data');
                            return Center(
                                child: Text(
                                    'Sorry there are no positive reviews'));
                          }
                        },
                      );
                    }
                    if (_negative == true) {
                      return StreamBuilder(
                        stream: Firestore.instance
                            .collection('reviews')
                            .where('productId', isEqualTo: productId)
                            .where('starRating', isLessThan: 3)
                            .snapshots(),
                        builder: (context, snapshot) {
                           if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasData) {
                            if (snapshot.data.documents.length > 0) {
                              final doc = snapshot.data.documents;
                              return ListView.builder(
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) => ReviewItem(
                                  doc[index].documentID,
                                  doc[index]['createdAt'],
                                  doc[index]['name'],
                                  doc[index]['review'],
                                  doc[index]['starRating'],
                                  doc[index]['username'],
                                  doc[index]['userId'] ==
                                      futureSnapshot.data.uid,
                                  key: ValueKey(doc[index].documentID),
                                ),
                              );
                            } else {
                              return Center(
                                  child: Text(
                                      'Sorry there are no negative reviews'));
                            }
                          } else {
                            print('no data');
                            return Center(
                                child: Text(
                                    'Sorry there are no negative reviews'));
                          }
                        },
                      );
                    }
                    if (_showAll == true) {
                      return StreamBuilder(
                        stream: Firestore.instance
                            .collection('reviews')
                            .where('productId', isEqualTo: productId)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasData) {
                            if (snapshot.data.documents.length > 0) {
                              final doc = snapshot.data.documents;
                              return ListView.builder(
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) => ReviewItem(
                                  doc[index].documentID,
                                  doc[index]['createdAt'],
                                  doc[index]['name'],
                                  doc[index]['review'],
                                  doc[index]['starRating'],
                                  doc[index]['username'],
                                  doc[index]['userId'] ==
                                      futureSnapshot.data.uid,
                                  key: ValueKey(doc[index].documentID),
                                ),
                              );
                            } else {
                              return Center(
                                  child: Text('Sorry there are no reviews'));
                            }
                          } else {
                            print('no data');
                            return Center(child: Text('no data'));
                          }
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Bottom(),
    );
  }
}

// if (snapshot.hasData) {
//                         if (snapshot.data.documents.length > 0) {
//                           return ListView.builder(
//                             itemCount: snapshot.data.documents.length,
//                             itemBuilder: (context, index) {
//                               var doc = snapshot.data.documents[index];
//                               return Text('Favourites: ${doc['productId']}');
//                             },
//                           );
//                         } else {
//                           return Text('No favourites');
//                         }
//                       } else {
//                         return Text("No data");
//                       }
//                     });
//               } else {
//                 return Text('no user');
//               }

// ListView.builder(
//                 itemCount: snapshot.data.documents.length,
//                 itemBuilder: (context, index) => ProductItem(
//                   doc[index].documentID,
//                   doc[index]['name'],
//                 ),
//               );

// return ListView.builder(
//                 itemCount: snapshot.data.documents.length,
//                 itemBuilder: (context, index) {
//                   var doc = snapshot.data.documents[index];
//                   return Text('Reviews: ${doc['name']}');
//                 },
//                 itemExtent: 50,
//               );
//             } else {
//               return Text("No data");
//             }
//           }),
//     );
//   }
// }
