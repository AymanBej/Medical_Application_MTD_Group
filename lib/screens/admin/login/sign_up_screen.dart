import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'components/body.dart';

class AdminLoginScreen extends StatelessWidget {
  static String routeName = "/admin_login";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Login"),
      ),
      body: Body(),
    );
  }
}
