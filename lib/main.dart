import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:med_app/routes.dart';
import 'package:med_app/screens/home/home_screen.dart';
import 'package:med_app/screens/splash/splash_screen.dart';
import 'package:med_app/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51NNFW7J54CVgf2sdTUGm1TDSHziha6Epq187HTjVj4mEupM2bnWj986ia3pST0ScW88Pct72fjMrRsmF0Cyee4qw00tClkeF9H";
  await Stripe.instance.applySettings();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MTD Health',
      theme: theme(),
      // home: MyScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: _auth.currentUser != null
          ? HomeScreen.routeName
          : SplashScreen.routeName,
      routes: routes,
    );
  }
}
