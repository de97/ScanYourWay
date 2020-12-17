import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../widgets/bottom.dart';

class NewReview extends StatefulWidget {
  static const routeName = '/new-review';

  @override
  _NewReviewState createState() => _NewReviewState();
}

class _NewReviewState extends State<NewReview> {
  //manage which input is focused
  final _reviewFocusNode = FocusNode();
  //all you to interact withstate behind form widget
  final _formKey = GlobalKey<FormState>();
  final _controller = new TextEditingController();

  //clear up focusnode in memory (avoid memory leaks)
  @override
  void dispose() {
    _reviewFocusNode.dispose();
    super.dispose();
  }

  var _title = '';
  var _review = '';
  double _starRating;
  var productId;
  int helpful;
  int unhelpful;

  void _sendReview() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    //save the form will trigger all the values in text form field and save it
    _formKey.currentState.save();
    //FocusScope.of(context).unfocus();
    // lines below will only execute once we have the user
    final user = await FirebaseAuth.instance.currentUser();
    final userData =
        await Firestore.instance.collection('users').document(user.uid).get();
    Firestore.instance.collection('reviews').add({
      'productId': productId,
      'name': _title,
      'review': _review,
      'starRating': _starRating,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData['username'],
      'userImage': userData['image_url'],
    });
    _controller.clear();
     Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    productId = ModalRoute.of(context).settings.arguments as String;
    //print("Reviews ${productId}");
    return Scaffold(
      appBar: AppBar(title: Text("Add Review")),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.all(8),
          child: Padding(
            padding: EdgeInsets.all(14),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text('Give a Rating!')),
                  Container(
                      child: SmoothStarRating(
                    allowHalfRating: false,
                    starCount: 5,
                    rating: 0,
                    size: 40.0,
                    color: Colors.yellow,
                    borderColor: Colors.black,
                    spacing: 0.0,
                    onRated: (value) {
                      setState(() {
                        _starRating = value;
                      });
                    },
                  )),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Container(
                      child: TextFormField(
                          decoration: InputDecoration(labelText: 'Heading'),
                          //shows move to next input button on keyboard
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_reviewFocusNode);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please provide a heading.';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              _title = value;
                            });
                          }),
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Write a Review',
                      ),
                      focusNode: _reviewFocusNode,
                      maxLines: 8,
                      //suited for text fields with multiple lines
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) {
                        _sendReview();
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please add a review.';
                        }
                        if (value.length < 10) {
                          return 'Should be at least 10 characters long';
                        }
                        return null;
                      },
                      onSaved: (value) {
                            setState(() {
                              _review = value;
                            });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: RaisedButton(
                      child: Text('Add Review'),
                      onPressed: _sendReview,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Bottom(),
    );
  }
}

//_title.trim().isEmpty ? null :

//  validator: (value) {
//                           if (value.isEmpty) {
//                             return 'Please write a review';
//                           }
//                           return null;
//                         },
