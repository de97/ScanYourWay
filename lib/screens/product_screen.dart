import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scanyourway/product_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './item_screen.dart';

class ProductsScreen extends StatelessWidget {
  static const routeName = '/product-screen';

  @override
  Widget build(BuildContext context) {
    String categoryName;
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    categoryName = routeArgs['name'];
    final categoryId = routeArgs['id'];

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('products')
              .where('categoryId', isEqualTo: categoryId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              final doc = snapshot.data.documents;
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) => GestureDetector(
                  child: ProductItem(
                    doc[index].documentID,
                    doc[index]['name'],
                    doc[index]['imageUrl'],
                  ),
                ),
              );
            } else {
              print('no data');
              return Center(child: Text('no data'));
            }
          }),
    );
  }
}

// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("ScanYourWay"),
//         actions: [
//           DropdownButton(
//             icon: Icon(
//               Icons.more_vert,
//               color: Theme.of(context).primaryIconTheme.color,
//             ),
//             items: [
//               DropdownMenuItem(
//                 child: Container(
//                   child: Row(
//                     children: <Widget>[
//                       Icon(Icons.exit_to_app),
//                       SizedBox(width: 8),
//                       Text('Logout'),
//                     ],
//                   ),
//                 ),
//                 value: 'logout',
//               ),
//             ],
//             onChanged: (itemIdentifier) {
//               if (itemIdentifier == 'logout') {
//                 FirebaseAuth.instance.signOut();
//               }
//             },
//           ),
//         ],
//       ),
//       drawer: AppDrawer(),
//       body: StreamBuilder(
//           stream: Firestore.instance.collection('products').snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               final doc = snapshot.data.documents;
//               return ListView.builder(
//                 itemCount: snapshot.data.documents.length,
//                 itemBuilder: (context, index) => ProductItem(
//                   doc[index].documentID,
//                   doc[index]['name'],
//                 ),
//               );
//             }
//           }),
//     );
//   }
// }
