import 'package:flutter/material.dart';

import 'components/body.dart';

class ProductAddedSuccessScreen extends StatelessWidget {
  static String routeName = "/product_added_success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("Medication Added Successefuly !"),
      ),
      body: Body(),
    );
  }
}
