import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:med_app/components/default_button.dart';
import 'package:med_app/models/Product.dart';
import 'package:med_app/size_config.dart';
import '../../../../constants.dart';
import '../../product_edited_success_screen/product_success_screen.dart';
import 'ImageSelectionWidget.dart';

class EditMedDialog extends StatefulWidget {
  final Product product;

  EditMedDialog({required this.product});

  @override
  _EditMedDialogState createState() => _EditMedDialogState();
}

class _EditMedDialogState extends State<EditMedDialog> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _compositionController = TextEditingController();
  TextEditingController _precautionsController = TextEditingController();
  TextEditingController _usageController = TextEditingController();
  TextEditingController _contraindicationController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();
  TextEditingController _ispopularController = TextEditingController();
  List<String> isPopular = ["No", "Yes"];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.product.name;
    _descriptionController.text = widget.product.description;
    _compositionController.text = widget.product.composition;
    _precautionsController.text = widget.product.precautions;
    _usageController.text = widget.product.usage;
    _ispopularController.text = widget.product.isPopular;
    _imageUrlController.text = widget.product.imageUrl;
    _contraindicationController.text = widget.product.contraindication;
  }

  Future<void> updateProductData() async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference productsRef =
          FirebaseFirestore.instance.collection('products');

      // Update the product document
      await productsRef.doc(widget.product.id).update({
        'name': _nameController.text,
        'description': _descriptionController.text,
        'composition': _compositionController.text,
        'precautions': _precautionsController.text,
        'usage': _usageController.text,
        'contraindication': _contraindicationController.text,
        "ispopular": _ispopularController.text,
        "imageUrl": _imageUrlController.text,
      });

      Navigator.pushNamed(
        context,
        ProductEditedSuccessScreen.routeName,
      );
    } catch (error) {
      // Handle any errors that occur during the update
      // Display an error message to the user or handle it in a way suitable for your app
      print('Error updating product: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Medication'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(15)),
            buildNameMedFormField(),
            SizedBox(height: getProportionateScreenHeight(15)),
            buildDescriptionFormField(),
            SizedBox(height: getProportionateScreenHeight(15)),
            buildCompositionFormField(),
            SizedBox(height: getProportionateScreenHeight(15)),
            buildPrecautionsFormField(),
            SizedBox(height: getProportionateScreenHeight(15)),
            buildUsageFormField(),
            SizedBox(height: getProportionateScreenHeight(15)),
            buildContraindicationFormField(),
            SizedBox(height: getProportionateScreenHeight(15)),
            buildIsPopularFormField(),
            SizedBox(height: getProportionateScreenHeight(15)),
            Text(
              "IMPORTANT: If you don't like to change the current image, just click on Save without selecting an image",
              style: TextStyle(fontSize: 15, color: Colors.red),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: getProportionateScreenHeight(15)),
            ImageSelectionWidget(
              imageUrlController: _imageUrlController, // Pass the controller
            ),
            SizedBox(height: getProportionateScreenHeight(25)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: DefaultButton(
                text: 'Save',
                press: () async {
                  await updateProductData();
                },
              ),
            ),
            TextButton(
              child: Center(
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildNameMedFormField() {
    return TextFormField(
      controller: _nameController,
      onChanged: (value) {},
      maxLines: null,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        labelText: 'Medication name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildDescriptionFormField() {
    return TextFormField(
      controller: _descriptionController,
      onChanged: (value) {},
      maxLines: null,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        labelText: 'Description',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildCompositionFormField() {
    return TextFormField(
      controller: _compositionController,
      onChanged: (value) {},
      maxLines: null,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        labelText: 'Composition',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPrecautionsFormField() {
    return TextFormField(
      controller: _precautionsController,
      onChanged: (value) {},
      maxLines: null,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        labelText: 'Precautions',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildUsageFormField() {
    return TextFormField(
      controller: _usageController,
      onChanged: (value) {},
      maxLines: null,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        labelText: 'Usage method',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildContraindicationFormField() {
    return TextFormField(
      controller: _contraindicationController,
      onChanged: (value) {},
      maxLines: null,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        labelText: 'Contraindication',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildIsPopularFormField() {
    return TextFormField(
      controller: _ispopularController,
      readOnly: true,
      onChanged: (value) {
        return null;
      },
      decoration: InputDecoration(
        labelText: "Medication Popularity",
        prefixIcon: DropdownButton<String>(
          items: isPopular.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
              onTap: () {
                setState(() {
                  _ispopularController.text = value;
                });
              },
            );
          }).toList(),
          onChanged: (_) {},
        ),
        labelStyle: TextStyle(
          color: _ispopularController.text == "Yes" ||
                  _ispopularController.text == "No"
              ? kPrimaryColor
              : kSecondaryColor,
        ),
      ),
    );
  }
}
