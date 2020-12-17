import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scanyourway/product_item.dart';
import '../widgets/bottom.dart';

class Favourites extends StatefulWidget {
  static const routeName = '/favourites-screen';

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  getUID() async {
    final user = await FirebaseAuth.instance.currentUser();
    print(user.uid);
    return user.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
      ),
      body: Container(
        child: FutureBuilder(
            future: FirebaseAuth.instance.currentUser(),
            builder: (ctx, futureSnapshot) {
              print('User data ${futureSnapshot.data}');
              String userId = futureSnapshot.data.uid;
              if (futureSnapshot.hasData) {
                return StreamBuilder(
                    stream: Firestore.instance
                        .collection('favourites')
                        .where('userId', isEqualTo: userId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final doc = snapshot.data.documents;
                        if (snapshot.data.documents.length > 0) {
                          return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) =>
                                FavouritesProductItem(
                              doc[index]['productId'],
                              doc[index]['productname'],
                              doc[index]['imageUrl'],
                            ),
                          );
                        } else {
                          return Center(child: Text('You have no favourites'));
                        }
                      } else {
                        return Text('No data');
                      }
                    });
              } else {
                return Text('no user');
              }
            }),
      ),
      bottomNavigationBar: Bottom(),
    );
  }
}

// var doc = snapshot.data.documents[index];
// return Text('Favourites: ${doc['productId']}');

//  if (snapshot.hasData) {
//               final doc = snapshot.data.documents;
//               return ListView.builder(
//                 itemCount: snapshot.data.documents.length,
//                 itemBuilder: (context, index) => GestureDetector(
//                   child: ProductItem(
//                     doc[index].documentID,
//                     doc[index]['name'],
//                     doc[index]['imageUrl'],
//                   ),
//                 ),
//               );
//             } else {
//               print('no data');
//               return Center(child: Text('no data'));
//             }
//           }),
//     );
//   }
// }

//  builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               final doc = snapshot.data;
//               //final productId = snapshot.data.documentID;
//               if (snapshot.hasData) {
//                 return ProductDetail(
//                   doc.documentID,
//                   doc['name'],
//                   doc['details'],
//                   doc['imageUrl'],
//                 );
//               } else {
//                 return Center(
//                   child: Text('Sorry no data'),
//                 );
//               }
//             }),
//       ),
//       bottomNavigationBar: Bottom(),
//     );
//   }
// }
