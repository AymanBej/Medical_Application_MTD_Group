import 'package:flutter/material.dart';

import 'components/body.dart';

class ProductEditedSuccessScreen extends StatelessWidget {
  static String routeName = "/product_edit_success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("Medication Edited Successefuly !"),
      ),
      body: Body(),
    );
  }
}
