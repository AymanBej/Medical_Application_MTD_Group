import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_app/screens/allproducts/allproducts_screen.dart';
import 'package:med_app/screens/home/home_screen.dart';

import 'package:med_app/screens/sign_in/sign_in_screen.dart';

import '../constants.dart';
import '../enums.dart';
final _auth = FirebaseAuth.instance;
class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

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
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home,
                  size: 30,
                  color: MenuState.home == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, HomeScreen.routeName),
              ),

              IconButton(
                icon: Icon(Icons.medication,
                size:30,
                  
                  color: MenuState.allproducts == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, AllProducts.routeName),
              ),
              IconButton(
                icon: Icon(Icons.exit_to_app,
                size:30,
                  
                  color:
                      
                       inActiveIconColor,
                ),
                 onPressed: () {
                _auth.signOut();
                Navigator.pushNamed(context, SignInScreen.routeName);
              },
                
                
                    
              ),
            
            
            ],
          )),
    );
  }
}
