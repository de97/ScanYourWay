import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/product_detail.dart';
import '../widgets/bottom.dart';
import '../widgets/app_drawer.dart';

class ItemScreen extends StatelessWidget {
  static const routeName = '/item-screen';

  @override
  Widget build(BuildContext context) {
    final barcodeId = ModalRoute.of(context).settings.arguments as String;
    print(barcodeId);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: Firestore.instance
                .collection('products')
                .where('barcode', isEqualTo: barcodeId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              //final productId = snapshot.data.documentID;
              if (snapshot.hasData) {
                final doc = snapshot.data.documents.first;

                ///final doc = snapshot.data;
                print('this document$doc');
                if (doc != null) {
                  return ProductDetail(
                    doc.documentID,
                    doc['name'],
                    doc['details'],
                    doc['imageUrl'],
                  );
                } else {
                  return Center(
                    child: Text('Sorry no data'),
                  );
                }
              }
            }),
      ),
      bottomNavigationBar: Bottom(),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     final barcodeId = ModalRoute.of(context).settings.arguments as String;
//      return Scaffold(
//       appBar: AppBar(),
//        drawer: AppDrawer(),
//       body: SingleChildScrollView(
//         child: StreamBuilder(
//             stream: Firestore.instance
//                 .collection('products')
//                 .document(barcodeId)
//                 .snapshots(),
//             builder: (context, snapshot) {
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

class ItemExpanded extends StatelessWidget {
  static const routeName = '/itemexpanded-screen';
  @override
  Widget build(BuildContext context) {
    final categoryId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: Firestore.instance
                .collection('products')
                .document(categoryId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              //final productId = snapshot.data.documentID;
              if (snapshot.hasData) {
                final doc = snapshot.data;
                // return Text(doc['name'],);
                return ProductDetail(
                  doc.documentID,
                  doc['name'],
                  doc['details'],
                  doc['imageUrl'],
                );
              } else {
                return Center(
                  child: Text('Sorry no data'),
                );
              }
            }),
      ),
      bottomNavigationBar: Bottom(),
    );
  }
}

// class ItemExpanded extends StatelessWidget {
//   static const routeName = '/itemexpanded-screen';
//   @override
//   Widget build(BuildContext context) {
//     final categoryId = ModalRoute.of(context).settings.arguments as String;
//     return Scaffold(
//       appBar: AppBar(),
//       body: StreamBuilder(
//           stream: Firestore.instance
//               .collection('products')
//               .where('categoryId', isEqualTo: categoryId)
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             final doc = snapshot.data.documents;
//             //final productId = snapshot.data.documentID;
//             return ListView.builder(
//               itemCount: snapshot.data.documents.length,
//               itemBuilder: (context, index) => SingleChildScrollView(
//                 child: Container(
//                   height: 600,
//                   child: Expanded(
//                     child: ProductDetail(
//                       doc[index].documentID,
//                       doc[index]['name'],
//                       doc[index]['details'],
//                       doc[index]['imageUrl'],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }),
//           bottomNavigationBar: Bottom(),
//     );
//   }
// }

// return StreamBuilder(
//                 stream: Firestore.instance
//                     .collection('reviews')
//                     .document(reviewId)
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                   final doc = snapshot.data;
//                   return ReviewsExpanded(
//                     doc['name'],
//                     doc['review'],
//                     doc['username'],
//                     doc['userId'] == futureSnapshot.data.uid,
//                     reviewId,
//                     doc['userImage'],
//                     doc['starRating'],
//                   );
//                 },
//               );
//             }),
//       ),
//       bottomNavigationBar: Bottom(),
//     );
//   }
// }
