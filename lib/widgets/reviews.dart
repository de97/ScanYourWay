import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../screens/review_expanded_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ReviewItem extends StatelessWidget {
  final String id;
  final Timestamp date;
  final String header;
  final String description;
  final double starrating;
  final String username;
  final bool isMe;
  final Key key;

  ReviewItem(this.id, this.date, this.header, this.description, this.starrating, this.username, this.isMe,
      {this.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ReviewsExpandedScreen.routeName, arguments: id);
      },
      child: Card(
        //your reviews will be blue
        color: isMe ? Colors.blue : Colors.white,
        
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: SmoothStarRating(
                      rating: starrating,
                      size: 32,
                      color: Colors.yellow,
                      allowHalfRating: true,
                      spacing: 2.0,
                    ),
                  ),
                  Text(
                    (DateFormat('dd MMMM yyyy ' ).format( new DateTime.fromMillisecondsSinceEpoch( date.millisecondsSinceEpoch) )),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      username,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Padding(
                padding: EdgeInsets.symmetric(vertical: 0),
                child: Text(
                  header,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              subtitle: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  description,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            // Align(
            //     alignment: FractionalOffset.bottomLeft,
            //     child: Padding(
            //         padding: EdgeInsets.symmetric(vertical: 7, horizontal: 16),
            //         child: Container(child: Text('Written by:'))))
            
          ],
        ),
      ),
    );
  }
}

// class ReviewItem extends StatelessWidget {
//   String name;
//   ReviewItem(this.name);
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         children: <Widget>[
//           Stack(
//             children: <Widget>[
//               ClipRRect(
//                 child: Container(
//                   height: 45,
//                   width: MediaQuery.of(context).size.width,
//                 ),
//               ),
//               Positioned(
//                 top: 10,
//                 left: 10,
//                 child: ClipRRect(
//                   child: SmoothStarRating(
//                     rating: 5,
//                     size: 32,
//                     filledIconData: Icons.star,
//                     halfFilledIconData: Icons.star_half,
//                     defaultIconData: Icons.star_border,
//                     color: Colors.yellow,
//                     borderColor: Colors.black,
//                     starCount: 5,
//                     allowHalfRating: true,
//                     spacing: 2.0,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 17,
//                 left: 180,
//                 child: Container(
//                   width: 100,
//                   child: Text(
//                     '2 days ago',
//                     style: TextStyle(
//                       fontSize: 15,
//                     ),
//                     softWrap: true,
//                     overflow: TextOverflow.fade,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 5,
//                 left: 280,
//                 child: RaisedButton(
//               child: Text('View'),
//                 // child: Container(
//                 //   width: 100,
//                 //   height: 100,
//                 //   color: Colors.indigo,
//                 //   padding: EdgeInsets.symmetric(vertical: 2, horizontal: 30),
//                 //   child: GestureDetector(
//                 //     onTap: () {
//                 //       // Navigator.of(context).pushNamed(ViewReviewsScreen.routeName,
//                 //       // arguments: {'id': review.id,});
//                 //     },
//                 //     child: Text(
//                 //       'View',
//                 //       style: TextStyle(
//                 //         fontSize: 18,
//                 //         color: Colors.white,
//                 //       ),
//                 //       softWrap: true,
//                 //       overflow: TextOverflow.fade,
//                 //     ),
//                  // ),
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             padding: EdgeInsets.all(0),
//             child: ListTile(
//               title: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 0),
//                 child: Text(
//                   'Review',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               subtitle: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 5),
//                 child: Text(
//                   'Description',
//                   style: TextStyle(
//                     fontSize: 15,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
