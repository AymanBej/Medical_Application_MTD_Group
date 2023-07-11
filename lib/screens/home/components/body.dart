import 'package:flutter/material.dart';
import 'package:med_app/screens/home/components/all_products.dart';
import '../../../size_config.dart';

import 'popular_product.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            
            
           
            // Add other widgets here
            SizedBox(height: getProportionateScreenWidth(15)),
            PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(20)),
            AllProducts(),
            SizedBox(height: getProportionateScreenWidth(20)),
          ],
        ),
      ),
    );
  }
}
