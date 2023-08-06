import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:med_app/components/product_card_user.dart';
import 'package:med_app/models/Product.dart';
import '../../../size_config.dart';
import 'section_title.dart';

class AllProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('An error occurred');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final data = snapshot.data;
        if (data == null || data.docs.isEmpty) {
          return Text('No products available');
        }

        List<Product> products =
            data.docs.map((doc) => Product.fromFirestore(doc)).toList();

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
              child: SectionTitle(
                title: "All Medications",
              ),
            ),
            SizedBox(height: getProportionateScreenWidth(15)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...products.map(
                    (product) => ProductCard(
                      product: product,
                    ),
                  ),
                  SizedBox(width: getProportionateScreenWidth(20)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
