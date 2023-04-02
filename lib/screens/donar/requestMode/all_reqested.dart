import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management_system/models/arguments_return.dart';
import 'package:food_waste_management_system/screens/donar/donated_food_view.dart';
import 'package:food_waste_management_system/utils/methods.dart';

class AllReqestedScreen extends StatefulWidget {
  const AllReqestedScreen({Key? key}) : super(key: key);

  @override
  State<AllReqestedScreen> createState() => _AllReqestedScreenState();
}

class _AllReqestedScreenState extends State<AllReqestedScreen> {
  @override
  void initState() {
    super.initState();
  }

  final Stream<QuerySnapshot> _foodRequest = FirebaseFirestore.instance
      .collection('foodRequest')
      // .where('publicOrPrivate', isEqualTo: 'public')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _foodRequest,
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
                              context, DonatedFoodView.routeName,
                              arguments: ScreenArguments(
                                  data['documentId'], data['uid']));
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
