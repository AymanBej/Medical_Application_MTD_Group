import 'package:flutter/material.dart';
import 'package:med_app/screens/allproducts/allproducts_screen.dart';

import '../../../size_config.dart';


class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.black,
          ),
        ),
        GestureDetector(
           onTap: () => Navigator.pushNamed(
                          context, AllProducts.routeName),
          child: Text(
            "See all",
            style: TextStyle(color: Color.fromARGB(255, 149, 149, 149)),
          ),
        ),
      ],
    );
  }
}

