import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:med_app/components/coustom_bottom_nav_bar.dart';
import 'package:med_app/constants.dart';
import 'package:med_app/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:med_app/screens/allproducts/components/body.dart';
import '../../size_config.dart';
import 'components/body.dart';

final _firestore = FirebaseFirestore.instance;
late User? signedInUser;

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? messageText;

  List<String> sliderImages = [
    'assets/images/Image Banner 2.jpg',
    'assets/images/Banner-1.png',
    'assets/images/Banner-2.png',
    
  ];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          signedInUser = user;
        });
        print(signedInUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: false,
        backgroundColor: kPrimaryColor,
        title: Text(
          "Welcome To AYMANHEALTH",
          style: TextStyle(fontSize: 20),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AllProductsScreen()),
              );
            },
          ),
        ],
      ),
body: ListView(
  shrinkWrap: true,
  children: [
    CarouselSlider(
      items: sliderImages.map((imagePath) {
        return Container(
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
    ),
    Body(),
  ],
),


      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
