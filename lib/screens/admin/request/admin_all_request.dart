import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management_system/models/arguments_return.dart';
import 'package:food_waste_management_system/screens/donar/donated_food_view.dart';
import 'package:food_waste_management_system/screens/donar/requestMade/request_view.dart';
import 'package:food_waste_management_system/utils/methods.dart';

import '../admin_panel.dart';

class AdminAllReqestedScreen extends StatefulWidget {
  const AdminAllReqestedScreen({Key? key}) : super(key: key);

  @override
  State<AdminAllReqestedScreen> createState() => _AdminAllReqestedScreenState();
}

Stream<QuerySnapshot>? foodRequest;

class _AdminAllReqestedScreenState extends State<AdminAllReqestedScreen> {
  @override
  void initState() {
    foodRequest =
        FirebaseFirestore.instance.collection('foodRequest').snapshots();
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
        stream: foodRequest,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              // if (data['city'].toString().toLowerCase().startsWith(
              //       searchName.toLowerCase(),
              //     ))

              {
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
                      backgroundImage: NetworkImage(
                        data['profilePic'],
                      ),
                    ),
                    title: Text(data['email']),
                    subtitle: Text(data['city']),
                    trailing: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RequestFoodView.routeName,
                              arguments: ScreenArguments(
                                  data['documentId'], data['requestUid']));
                        },
                        child: Icon(Icons.keyboard_arrow_right_rounded)),
                  ),
                );
              }
            }).toList(),
          );
        },
      ),
    );
  }
}
