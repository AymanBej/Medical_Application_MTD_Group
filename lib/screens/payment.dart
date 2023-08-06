import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:med_app/screens/home/home_screen.dart';
import 'package:med_app/screens/login_success/login_success_screen.dart';

import '../components/default_button.dart';

class PaymenScreen extends StatefulWidget {
  static String routeName = "/payment";
  const PaymenScreen({Key? key}) : super(key: key);

  @override
  State<PaymenScreen> createState() => _PaymenScreenState();
}

class _PaymenScreenState extends State<PaymenScreen> {
  Map<String, dynamic>? paymentIntent;

  void navigateToHomePage() {
    Navigator.pushNamed(context, LoginSuccessScreen.routeName);
  }

  void makePayment() async {
    try {
      paymentIntent = await createPaymentIntent();

      var gpay = const PaymentSheetGooglePay(
        merchantCountryCode: "Us",
        currencyCode: 'USD',
        testEnv: true,
      );
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          googlePay: gpay,
          merchantDisplayName: 'Ayman',
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
        ),
      );
      displayPaymentSheet();
    } catch (e) {}
  }

  void displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print('Done');
      navigateToHomePage();
    } catch (e) {
      print('Failed');
    }
  }

  createPaymentIntent() async {
    try {
      Map<String, dynamic> body = {
        'amount': '5000',
        'currency': 'USD',
      };
      http.Response response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization':
              'Bearer sk_test_51NNFW7J54CVgf2sdiR1DfwGR1bA8HIsUwXD8KdbMsySzI1kFDPmgZHBzDhFlehfoWawcvOkRGB6hfQ7yeHEU6lhV007ZbP55lQ',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      return jsonDecode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300, // Définissez ici la largeur souhaitée pour le bouton
          child: DefaultButton(
            text: 'Pay to continue',
            press: () {
              makePayment();
            },
          ),
        ),
      ),
    );
  }
}
