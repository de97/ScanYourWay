import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scanyourway/screens/home_screen.dart';
import 'package:scanyourway/screens/new_review.dart';
import 'package:scanyourway/screens/product_screen.dart';
import 'package:scanyourway/screens/review_expanded_screen.dart';
import './screens/reviews_screen.dart';
import './screens/login_screen.dart';
import './screens/item_screen.dart';
import './screens/favourites.dart';
import './screens/my_account_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapShot) {
            if (userSnapShot.hasData) {
              return HomeScreen();
            }
            return LoginScreen();
          }),
      routes: {
        ReviewsScreen.routeName: (ctx) => ReviewsScreen(),
        NewReview.routeName: (ctx) => NewReview(),
        ReviewsExpandedScreen.routeName: (ctx) => ReviewsExpandedScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        ItemScreen.routeName: (ctx) => ItemScreen(),
        ProductsScreen.routeName: (ctx) => ProductsScreen(),
        ItemExpanded.routeName: (ctx) => ItemExpanded(),
        Favourites.routeName: (ctx) => Favourites(),
        MyAccountScreen.routeName: (ctx) => MyAccountScreen(),
        Hello.routeName: (ctx) => Hello(),
      },
    );
  }
}
