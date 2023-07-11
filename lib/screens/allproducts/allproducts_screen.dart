import 'package:flutter/material.dart';
import '../../components/coustom_bottom_nav_bar.dart';
import '../../enums.dart';
import 'components/body.dart';

class AllProducts extends StatelessWidget {
  static String routeName = "/allproducts";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      body: 
      AllProductsScreen(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.allproducts),
     
    );
  }
}
