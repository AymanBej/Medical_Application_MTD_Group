import 'package:flutter/material.dart';
import 'package:med_app/constants.dart';
import 'package:med_app/size_config.dart';

import 'sign_up_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Icon(
                    Icons.admin_panel_settings_sharp,
                    size: 60,
                  ),
                  Text("Admin Login", style: headingStyle),
                  Text(
                    "Complete your details",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.06),
                  SignUpForm(),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
