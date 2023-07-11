import 'package:flutter/material.dart';
import 'package:med_app/models/Product.dart';

import '../../../size_config.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            product.name,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(30),
          ),
          child: ExpansionTile(
            title: Text(
              "Description",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            initiallyExpanded: false,
            children: [
              ListTile(
                title: Text(
                  "${product.description.replaceAll('#', '\n')}",
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(30),
          ),
          child: ExpansionTile(
            title: Text(
              "Composition",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            initiallyExpanded: false,
            children: [
              ListTile(
                title: Text(
                  "${product.composition.replaceAll('#', '\n')}",
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(30),
          ),
          child: ExpansionTile(
            title: Text(
              "Usage method",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            initiallyExpanded: false,
            children: [
              ListTile(
                title: Text(
                  "${product.usage.replaceAll('#', '\n')}",
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(30),
          ),
          child: ExpansionTile(
            title: Text(
              "Precautions for use",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            initiallyExpanded: false,
            children: [
              ListTile(
                title: Text(
                  "${product.precautions.replaceAll('#', '\n')}",
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
        
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(30),
          ),
          child: ExpansionTile(
            title: Text(
              "Contraindication",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            initiallyExpanded: false,
            children: [
              ListTile(
                title: Text(
                  "${product.contraindication.replaceAll('#', '\n')}",
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
