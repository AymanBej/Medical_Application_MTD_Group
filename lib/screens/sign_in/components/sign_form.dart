import 'package:flutter/material.dart';
import 'package:med_app/components/custom_surfix_icon.dart';
import 'package:med_app/components/form_error.dart';
import 'package:med_app/helper/keyboard.dart';
import 'package:med_app/screens/admin/login/sign_up_screen.dart';
import 'package:med_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:med_app/screens/payment.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;

  final _formKey = GlobalKey<FormState>();
  bool? remember = false;
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
                buildEmailFormField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildPasswordFormField(),
                SizedBox(height: getProportionateScreenHeight(15)),
                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, AdminLoginScreen.routeName),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: kSecondaryColor,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Admin Login",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    ),
                    Spacer(flex: 7),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, ForgotPasswordScreen.routeName),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          "Forgot Password",
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(20)),
                DefaultButton(
                  text: "Pay to login",
                  press: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        await _auth.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        KeyboardUtil.hideKeyboard(context);
                        Navigator.pushNamed(context, PaymenScreen.routeName);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      setState(() {
                        showSpinner = false;
                        addError(error: "Invalid email or password");
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

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue!,
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

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
