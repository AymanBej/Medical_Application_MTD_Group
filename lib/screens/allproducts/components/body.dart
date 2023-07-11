import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:med_app/constants.dart';
import 'package:med_app/components/product_card_user.dart';
import 'package:med_app/models/Product.dart';
import '../../home/components/search_field.dart';

class AllProductsScreen extends StatefulWidget {
  @override
  _AllProductsScreenState createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  int currentPage = 1;
  final int productsPerPage = 4;
  List<Product> filteredProductList = [];
  String searchQuery = '';

  void filterProducts(List<Product> allProducts) {
    filteredProductList = allProducts
        .where((product) => product.name
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          "All Medications",
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
              stream: FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('An error occurred');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                List<Product> allProducts = snapshot.data!.docs.map((doc) => Product.fromFirestore(doc)).toList();
                filterProducts(allProducts);

                final int totalProducts = filteredProductList.length;
                final int totalPages = (totalProducts / productsPerPage).ceil();

                return Column(
                  children: [
                    GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.85,
                      children: filteredProductList
                          .skip((currentPage - 1) * productsPerPage)
                          .take(productsPerPage)
                          .map((product) => ProductCard(product: product))
                          .toList(),
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
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
