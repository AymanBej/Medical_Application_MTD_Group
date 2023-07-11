import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:med_app/components/product_card_admin.dart';
import 'package:med_app/constants.dart';
import 'package:med_app/models/Product.dart';
import 'package:med_app/screens/admin/Products_screen/components/boite_form.dart';
import '../../../../components/AdminBottomNavBar.dart';
import '../../../../enums.dart';
import '../../../home/components/search_field.dart';

class AdminProductsScreen extends StatefulWidget {
  @override
  _AdminProductsScreenState createState() => _AdminProductsScreenState();
}

class _AdminProductsScreenState extends State<AdminProductsScreen> {
  int currentPage = 1;
  final int productsPerPage = 4;
  List<Product> filteredProductList = [];
  String searchQuery = '';

  void filterProducts(List<Product> allProducts) {
    filteredProductList = allProducts
        .where((product) =>
            product.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  // Function to handle the form submission

  // Function to validate form fields

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          "Medications",
          style: TextStyle(fontSize: 23),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            SearchField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('An error occurred');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                List<Product> allProducts = snapshot.data!.docs
                    .map((doc) => Product.fromFirestore(doc))
                    .toList();
                filterProducts(allProducts);

                final int totalProducts = filteredProductList.length;
                final int totalPages = (totalProducts / productsPerPage).ceil();

                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.85,
                        children: filteredProductList
                            .skip((currentPage - 1) * productsPerPage)
                            .take(productsPerPage)
                            .map(
                                (product) => ProductCardAdmin(product: product))
                            .toList(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            color: kPrimaryColor,
                            onPressed: currentPage > 1
                                ? () {
                                    setState(() {
                                      currentPage--;
                                    });
                                  }
                                : null,
                          ),
                          Text(
                            'Page $currentPage of $totalPages',
                            style: TextStyle(fontSize: 17),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            color: kPrimaryColor,
                            onPressed: currentPage < totalPages
                                ? () {
                                    setState(() {
                                      currentPage++;
                                    });
                                  }
                                : null,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          AdminBottomNavBar(selectedAdminMenu: MenuStateAdmin.allproducts),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // Create a GlobalKey<FormState> to validate the form
              GlobalKey<FormState> formKey = GlobalKey<FormState>();

              return AlertDialog(
                title: Text("Add Medication"),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 20), // Augmented width
                content: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [FormAddMed()],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
