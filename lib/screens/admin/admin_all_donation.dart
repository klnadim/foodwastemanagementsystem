import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:food_waste_management_system/models/arguments_return.dart';
import 'package:food_waste_management_system/screens/admin/admin_panel.dart';
import 'package:food_waste_management_system/screens/donar/donated_food_view.dart';
import 'package:food_waste_management_system/utils/methods.dart';

class AdminDonationScreen extends StatefulWidget {
  const AdminDonationScreen({Key? key}) : super(key: key);

  @override
  State<AdminDonationScreen> createState() => _AdminDonationScreenState();
}

class _AdminDonationScreenState extends State<AdminDonationScreen> {
  Stream<QuerySnapshot>? foodDonation;
  @override
  void initState() {
    foodDonation = FirebaseFirestore.instance
        .collection('addFood')

        // .where('uid', isEqualTo: getUserId())
        .snapshots();
    super.initState();
  }

  final snackBar = SnackBar(
    content: Row(
      children: [
        Icon(Icons.check_circle_outline, color: Colors.white),
        SizedBox(width: 8),
        Text("Document deleted successfully.",
            style: TextStyle(color: Colors.white)),
      ],
    ),
    backgroundColor: Colors.green,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: foodDonation,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                return Card(
                  elevation: 6,
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Row(
                              children: [
                                Icon(Icons.warning, color: Colors.red),
                                SizedBox(width: 8),
                                Text("Delete Item"),
                              ],
                            ),
                            content: Text(
                                "Are you sure you want to delete this Item?"),
                            actions: [
                              TextButton(
                                child: Text("CANCEL"),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              TextButton(
                                child: Text("DELETE"),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('addFood')
                                      .doc(document.id)
                                      .delete()
                                      .then(
                                    (value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return AdminPanelScreen();
                                        },
                                      ));
                                    },
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    leading: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.transparent,
                      // backgroundColor: Colors.purple,
                      // backgroundImage: NetworkImage(
                      //   data[0]['imagesUrls'] ?? "",
                      // ),
                    ),
                    title: Text(data['foodItems'] ?? ""),
                    subtitle: Text(data['city'] ?? ""),
                    trailing: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            DonatedFoodView.routeName,
                            arguments:
                                ScreenArguments(document.id, data['uid']),
                          );
                        },
                        child: Icon(Icons.keyboard_arrow_right_rounded)),
                  ),
                );
              }).toList(),
            );
          } else {
            return Text("data");
          }
        },
      ),
    );
  }
}
