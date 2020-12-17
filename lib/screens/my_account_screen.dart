import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyAccountScreen extends StatelessWidget {
  static const routeName = '/account-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
        child: FutureBuilder(
            future: FirebaseAuth.instance.currentUser(),
            builder: (ctx, futureSnapShot) {
              String userId = futureSnapShot.data.uid;
              if (futureSnapShot.hasData) {
                return StreamBuilder(
                    stream: Firestore.instance
                        .collection('users')
                        .where('userId', isEqualTo: userId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            var doc = snapshot.data.documents[index];
                            return Text('User ${doc['username']}');
                          },
                        );
                      }
                    });
              }
            }),
      ),
    );
  }
}

// body: Container(
//         child: FutureBuilder(
//             future: FirebaseAuth.instance.currentUser(),
//             builder: (ctx, futureSnapshot) {
//               print('User data ${futureSnapshot.data}');
//               String userId = futureSnapshot.data.uid;
//               if (futureSnapshot.hasData) {
//                 return StreamBuilder(
//                     stream: Firestore.instance
//                         .collection('favourites')
//                         .where('userId', isEqualTo: userId)
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData) {
//                         final doc = snapshot.data.documents;
//                         if (snapshot.data.documents.length > 0) {
//                           return ListView.builder(
//                             itemCount: snapshot.data.documents.length,
//                             itemBuilder: (context, index) =>
//                                 FavouritesProductItem(
//                               doc[index]['productId'],
//                               doc[index]['productname'],
//                               doc[index]['imageUrl'],
//                             ),
//                           );
//                         } else {
//                           return Center(child: Text('You have no favourites'));
//                         }
//                       } else {
//                         return Text('No data');
//                       }
//                     });
//               } else {
//                 return Text('no user');
//               }
//             }),
//       ),
//       bottomNavigationBar: Bottom(),
//     );
//   }
// }
