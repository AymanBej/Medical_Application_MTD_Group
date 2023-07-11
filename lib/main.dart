import 'package:flutter/material.dart';
import 'package:med_app/routes.dart';
import 'package:med_app/screens/home/home_screen.dart';
import 'package:med_app/screens/splash/splash_screen.dart';
import 'package:med_app/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
