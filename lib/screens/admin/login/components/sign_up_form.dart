import 'package:flutter/material.dart';
import 'package:med_app/components/custom_surfix_icon.dart';
import 'package:med_app/components/default_button.dart';
import 'package:med_app/components/form_error.dart';
import 'package:med_app/screens/admin/Products_screen/admin_products_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController _nameController = TextEditingController();

  bool showSpinner = false;

  final _formKey = GlobalKey<FormState>();
  late String adminname;
  late String password;
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
                buildUserNameFormField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildPasswordFormField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(20)),
                DefaultButton(
                  text: "Login",
                  press: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        final snapshot = await FirebaseFirestore.instance
                            .collection('admins')
                            .where('adminname', isEqualTo: adminname)
                            .where('password', isEqualTo: password)
                            .limit(1)
                            .get();

                        if (snapshot.docs.isNotEmpty) {
                          // L'adminname et le mot de passe sont valides
                          Navigator.pushNamed(
                            context,
                            AdminProducts.routeName,
                          );
                        } else {
                          // L'adminname et le mot de passe ne correspondent à aucun admin enregistré
                          throw Exception("Invalid adminname or password");
                        }
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      setState(() {
                        showSpinner = false;
                        addError(error: "Invalid admin name or password");
                      });
                    }
                  },
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

  TextFormField buildUserNameFormField() {
    return TextFormField(
      controller: _nameController,
      onSaved: (newValue) => adminname = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Admin name",
        hintText: "Enter your name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }
}
