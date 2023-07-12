import 'package:flutter/material.dart';

import 'components/body.dart';

class ProductDeletedSuccessScreen extends StatelessWidget {
  static String routeName = "/product_delete_success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("Medication Deleted Successefuly !"),
      ),
      body: Body(),
    );
  }
}
