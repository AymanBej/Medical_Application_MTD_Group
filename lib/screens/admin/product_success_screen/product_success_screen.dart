import 'package:flutter/material.dart';

import 'components/body.dart';

class ProductSuccessScreen extends StatelessWidget {
  static String routeName = "/product_success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("Product added Successefuly !"),
      ),
      body: Body(),
    );
  }
}
