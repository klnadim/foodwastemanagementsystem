import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/arguments_return.dart';

import 'donated_food_view.dart';

class IndivisualDonatedList extends StatelessWidget {
  IndivisualDonatedList({Key? key}) : super(key: key);
  String routeName = '/indivisualDonatedList';

  var vDonList = FirebaseFirestore.instance
      .collection('addFood')
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent[50],
      body: StreamBuilder<QuerySnapshot>(
        stream: vDonList,
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
              return Card(
                elevation: 6,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.transparent,
                    // backgroundColor: Colors.purple,
                    backgroundImage: NetworkImage(
                      data['imagesUrls'][0],
                    ),
                  ),
                  title: Text(data['foodItems']),
                  subtitle: Text(data['city']),
                  trailing: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, DonatedFoodView.routeName,
                            arguments:
                                ScreenArguments(document.id, data['uid']));
                      },
                      child: Icon(Icons.keyboard_arrow_right_rounded)),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
