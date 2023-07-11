import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../components/AdminBottomNavBar.dart';
import '../../../../constants.dart';
import '../../../../enums.dart';

class DoctorScreen extends StatefulWidget {
  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  int currentPage = 1;
  final int doctorsPerPage = 7;
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          "Doctors",
          style: TextStyle(fontSize: 23),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users-form').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            final users = snapshot.data!.docs;

            final filteredUsers = users
                .where((doc) {
                  final userData = doc.data() as Map<String, dynamic>;
                  final name = userData['name'] as String;
                  return name.toLowerCase().contains(searchQuery.toLowerCase());
                })
                .toList();

            final int totalDoctors = filteredUsers.length;
            final int totalPages = (totalDoctors / doctorsPerPage).ceil();

            final paginatedUsers = filteredUsers
                .skip((currentPage - 1) * doctorsPerPage)
                .take(doctorsPerPage)
                .toList();

            return Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                        currentPage = 1; // Reset current page when search query changes
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Search by Name',
                      hintText: "Enter the name of doctor",
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: paginatedUsers.length,
                  itemBuilder: (context, index) {
                    final userData = paginatedUsers[index].data() as Map<String, dynamic>;

                    final name = userData['name'];
                    final email = userData['email'];
                    final phone = userData['phone'];
                    final address = userData['address'];

                    return Card(
                      child: ExpansionTile(
                        title: Text(
                          name,
                          style: TextStyle(fontSize: 18),
                        ),
                        children: [
                          ListTile(
                            title: Text('E-mail: $email'),
                          ),
                          ListTile(
                            title: Text('Numéro: $phone'),
                          ),
                          ListTile(
                            title: Text('Adresse: $address'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 15),
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
      ),
      bottomNavigationBar: AdminBottomNavBar(selectedAdminMenu: MenuStateAdmin.doctors),
    );
  }
}
