import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../utils/methods.dart';

class RequestConfirmedSreen extends StatefulWidget {
  const RequestConfirmedSreen({Key? key}) : super(key: key);

  @override
  State<RequestConfirmedSreen> createState() => _RequestConfirmedSreenState();
}

Stream<QuerySnapshot>? foodCollection;

class _RequestConfirmedSreenState extends State<RequestConfirmedSreen> {
  @override
  void initState() {
    foodCollection = FirebaseFirestore.instance
        .collection('confirmationFoods')
        .where('requestUid', isEqualTo: getUserId())
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: foodCollection,
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
                    // leading: CircleAvatar(
                    //   radius: 30.0,
                    //   backgroundColor: Colors.transparent,
                    //   // backgroundColor: Colors.purple,
                    //   backgroundImage: NetworkImage(
                    //     data['profilePic'],
                    //   ),
                    // ),
                    title: Text(data['foodName']),
                    // subtitle: Text(data['city']),
                    trailing: InkWell(
                        onTap: () {
                          // Navigator.pushNamed(
                          //     context, RequestFoodView.routeName,
                          //     arguments: ScreenArguments(
                          //         data['documentId'], data['requestUid']));
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
