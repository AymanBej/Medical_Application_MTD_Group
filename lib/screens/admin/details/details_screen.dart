import 'package:flutter/material.dart';
import 'package:med_app/constants.dart';

import '../../../models/Product.dart';
import 'components/body.dart';

class DetailsScreenAdmin extends StatelessWidget {
  static String routeName = "/details_admin";

  @override
  Widget build(BuildContext context) {
    final ProductAdminDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductAdminDetailsArguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        // centerTitle: true,
        title: Text(
            agrs.product.name), // Set the product title as the app bar title
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Action to perform when "Edit Medication" is pressed
              // Add your desired code here
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Action to perform when "Delete Medication" is pressed
              // Add your desired code here
            },
          ),
        ],
      ),
      body: Body(product: agrs.product),
    );
  }
}

class ProductAdminDetailsArguments {
  final Product product;

  ProductAdminDetailsArguments({required this.product});
}
