import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:med_app/components/product_card_user.dart';
import 'package:med_app/models/Product.dart';

import '../../../size_config.dart';

class PopularProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('products')
          .where('isPopular', isEqualTo: 'Yes')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Une erreur s\'est produite');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        List<Product> popularProducts = snapshot.data!.docs
            .map((doc) => Product.fromFirestore(doc))
            .toList();

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Popular Medications",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenWidth(15)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...popularProducts
                      .map((product) => ProductCard(
                            product: product
                          )),
                  SizedBox(width: getProportionateScreenWidth(20)),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
