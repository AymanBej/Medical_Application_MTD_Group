import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_app/screens/admin/Doctors_screen/doctors_screen.dart';
import 'package:med_app/screens/admin/Products_screen/admin_products_screen.dart';

import 'package:med_app/screens/sign_in/sign_in_screen.dart';

import '../constants.dart';
import '../enums.dart';

final _auth = FirebaseAuth.instance;

class AdminBottomNavBar extends StatelessWidget {
  const AdminBottomNavBar({
    Key? key,
    required this.selectedAdminMenu,
  }) : super(key: key);

  final MenuStateAdmin selectedAdminMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 15,
            color: Color.fromARGB(255, 145, 145, 145).withOpacity(0.25),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.medication,
              size: 30,
              color: MenuStateAdmin.allproducts == selectedAdminMenu
                  ? kPrimaryColor
                  : inActiveIconColor,
            ),
            onPressed: () =>
                Navigator.pushNamed(context, AdminProducts.routeName),
          ),
          IconButton(
            icon: Icon(
              Icons.people,
              size: 30,
              color: MenuStateAdmin.doctors == selectedAdminMenu
                  ? kPrimaryColor
                  : inActiveIconColor,
            ),
            onPressed: () {
              _auth.signOut();
              Navigator.pushNamed(context, DoctorsScreen.routeName);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              size: 30,
              color: MenuStateAdmin.signout == selectedAdminMenu
                  ? kPrimaryColor
                  : inActiveIconColor,
            ),
            onPressed: () {
              _auth.signOut();
              Navigator.pushNamed(context, SignInScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
