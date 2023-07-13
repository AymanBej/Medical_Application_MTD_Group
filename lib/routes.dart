import 'package:flutter/widgets.dart';
import 'package:med_app/screens/admin/Doctors_screen/doctors_screen.dart';
import 'package:med_app/screens/admin/Products_screen/admin_products_screen.dart';
import 'package:med_app/screens/admin/Products_screen/components/body.dart';
import 'package:med_app/screens/admin/details/details_screen.dart';
import 'package:med_app/screens/admin/login/sign_up_screen.dart';
import 'package:med_app/screens/admin/product_added_success_screen/product_success_screen.dart';
import 'package:med_app/screens/admin/product_deleted_success_screen.dart/product_success_screen.dart';
import 'package:med_app/screens/admin/product_edited_success_screen/product_success_screen.dart';
import 'package:med_app/screens/allproducts/allproducts_screen.dart';
import 'package:med_app/screens/details/details_screen.dart';
import 'package:med_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:med_app/screens/home/home_screen.dart';
import 'package:med_app/screens/login_success/login_success_screen.dart';
import 'package:med_app/screens/sign_in/sign_in_screen.dart';
import 'package:med_app/screens/signup_success/signup_success_screen.dart';
import 'package:med_app/screens/splash/splash_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  AllProducts.routeName: (context) => AllProducts(),
  SignUpSuccessScreen.routeName: (context) => SignUpSuccessScreen(),
  AdminProducts.routeName: (context) => AdminProductsScreen(),
  DoctorsScreen.routeName: (context) => DoctorsScreen(),
  ProductAddedSuccessScreen.routeName: (context) => ProductAddedSuccessScreen(),
  ProductDeletedSuccessScreen.routeName: (context) =>
      ProductDeletedSuccessScreen(),
  ProductEditedSuccessScreen.routeName: (context) =>
      ProductEditedSuccessScreen(),
  DetailsScreenAdmin.routeName: (context) => DetailsScreenAdmin(),
  AdminLoginScreen.routeName: (context) => AdminLoginScreen(),
};
