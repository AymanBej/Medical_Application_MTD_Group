import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:med_app/components/default_button.dart';
import 'package:med_app/components/form_error.dart';
import 'package:med_app/screens/admin/product_added_success_screen/product_success_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import 'ImageSelectionWidget.dart';

class FormAddMed extends StatefulWidget {
  @override
  _FormAddMedState createState() => _FormAddMedState();
}

class _FormAddMedState extends State<FormAddMed> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _compositionController = TextEditingController();
  TextEditingController _precautionsController = TextEditingController();
  TextEditingController _usageController = TextEditingController();
  TextEditingController _contraindicationController = TextEditingController();
  TextEditingController _ispopularController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();
  List<String> isPopular = ["No", "Yes"];

  bool showSpinner = false;
  bool showPopularityError = false;

  final _formKey = GlobalKey<FormState>();
  late String name;

  late String description;
  late String composition;
  late String precautions;
  late String usage;
  late String contraindication;
  bool remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  Future<void> sendProductDataToDB() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("products");
    try {
      await _collectionRef.doc().set({
        "name": _nameController.text,
        "description": _descriptionController.text,
        "composition": _compositionController.text,
        "precautions": _precautionsController.text,
        "usage": _usageController.text,
        "contraindication": _contraindicationController.text,
        "ispopular": _ispopularController.text,
        "imageUrl": _imageUrlController.text, // Add imageUrl field
      });
      print('Product added!');
    } catch (error) {
      print("Something went wrong. $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Stack(
        children: [
          Form(
            key: _formKey,
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
                ImageSelectionWidget(
                  imageUrlController:
                      _imageUrlController, // Pass the controller
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(10)),
                DefaultButton(
                    text: "Add",
                    press: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        setState(() {
                          showSpinner = true;
                        });
                        await sendProductDataToDB();
                        Navigator.pushNamed(
                            context, ProductAddedSuccessScreen.routeName);

                        setState(() {
                          showSpinner = false;
                        });
                      }
                    }),
                TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          if (showSpinner)
            Positioned.fill(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color.fromARGB(0, 0, 0, 0),
                child: Center(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      // Customize the color here
                      primaryColor: Colors.blue,
                    ),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  TextFormField buildIsPopularFormField() {
    return TextFormField(
      controller: _ispopularController,
      readOnly: true,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kIsPopularNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kIsPopularNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Medication Popularity",
        hintText: "Is it popular?",
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

  TextFormField buildNameMedFormField() {
    return TextFormField(
      controller: _nameController,
      onSaved: (newValue) => name = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameMedNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNameMedNullError);
          return "";
        }
        return null;
      },
      maxLines: null,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        labelText: "Medication name",
        hintText: "Enter medication name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildDescriptionFormField() {
    return TextFormField(
      controller: _descriptionController,
      onSaved: (newValue) => description = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kDescriptionNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kDescriptionNullError);
          return "";
        }
        return null;
      },
      maxLines: null,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        labelText: "Description",
        hintText: "Enter the description",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildCompositionFormField() {
    return TextFormField(
      controller: _compositionController,
      onSaved: (newValue) => composition = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCompositionNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kCompositionNullError);
          return "";
        }
        return null;
      },
      maxLines: null,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        labelText: "Composition",
        hintText: "Enter the composition",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPrecautionsFormField() {
    return TextFormField(
      controller: _precautionsController,
      onSaved: (newValue) => precautions = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPrecautionsNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPrecautionsNullError);
          return "";
        }
        return null;
      },
      maxLines: null,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        labelText: "Precautions",
        hintText: "Enter the precautions of use",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildUsageFormField() {
    return TextFormField(
      controller: _usageController,
      onSaved: (newValue) => usage = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kUsageNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kUsageNullError);
          return "";
        }
        return null;
      },
      maxLines: null,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        labelText: "Usage method",
        hintText: "Enter the usage method",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildContraindicationFormField() {
    return TextFormField(
      controller: _contraindicationController,
      onSaved: (newValue) => contraindication = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kContraindicationNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kContraindicationNullError);
          return "";
        }
        return null;
      },
      maxLines: null,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        labelText: "Contraindication",
        hintText: "Enter the contraindication",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
