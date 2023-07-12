import 'package:flutter/material.dart';
import 'package:med_app/components/default_button.dart';
import 'package:med_app/screens/admin/Products_screen/admin_products_screen.dart';
import 'package:med_app/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight * 0.4, //40%
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Expanded(
          child: Text(
            "Medication Added Successefuly !",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(30),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: Expanded(
            child: DefaultButton(
              text: "Return",
              press: () {
                Navigator.pushNamed(context, AdminProducts.routeName);
              },
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
