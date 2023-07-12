import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:med_app/constants.dart';
import 'package:med_app/screens/admin/product_deleted_success_screen.dart/product_success_screen.dart';

import '../../../models/Product.dart';
import '../Products_screen/components/edit_model.dart';
import 'components/body.dart';

class DetailsScreenAdmin extends StatelessWidget {
  static String routeName = "/details_admin";

  void deleteMed(BuildContext context, Product product) async {
    try {
      // Initialize Firebase
      await Firebase.initializeApp();

      // Get a reference to the Firestore collection
      CollectionReference productsRef =
          FirebaseFirestore.instance.collection('products');

      // Delete the product document
      await productsRef.doc(product.id).delete();
    } catch (error) {
      // Handle any errors that occur during deletion
      // Display an error message to the user or handle it in a way suitable for your app
      print('Error deleting product: $error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred while deleting the product.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ProductAdminDetailsArguments args = ModalRoute.of(context)!
        .settings
        .arguments as ProductAdminDetailsArguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(args.product.name),
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return EditMedDialog(product: args.product);
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirmation'),
                    content: Text(
                        'Are you sure you want to delete this medication ?'),
                    actions: [
                      TextButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                      TextButton(
                        child: Text('Yes'),
                        onPressed: () {
                          deleteMed(context, args.product);
                          Navigator.pushNamed(
                              context, ProductDeletedSuccessScreen.routeName);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Body(product: args.product),
    );
  }
}

class ProductAdminDetailsArguments {
  final Product product;

  ProductAdminDetailsArguments({required this.product});
}
