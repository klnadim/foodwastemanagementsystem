import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management_system/models/arguments_return.dart';
import 'package:food_waste_management_system/screens/donar/donated_food_view.dart';
import 'package:food_waste_management_system/utils/methods.dart';

class AllDonationScreen extends StatefulWidget {
  const AllDonationScreen({Key? key}) : super(key: key);

  @override
  State<AllDonationScreen> createState() => _AllDonationScreenState();
}

class _AllDonationScreenState extends State<AllDonationScreen> {
  final Stream<QuerySnapshot> _foodDonation = FirebaseFirestore.instance
      .collection('addFood')
      .where('uid', isEqualTo: getUserId())
      .snapshots();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _foodDonation,
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
