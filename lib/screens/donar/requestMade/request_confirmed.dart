import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../utils/methods.dart';
import '../../../utils/styles.dart';
import '../../../widgets/blinking_text.dart';

class RequestConfirmedSreen extends StatefulWidget {
  const RequestConfirmedSreen({Key? key}) : super(key: key);

  @override
  State<RequestConfirmedSreen> createState() => _RequestConfirmedSreenState();
}

Stream<QuerySnapshot>? _foodRequest;

class _RequestConfirmedSreenState extends State<RequestConfirmedSreen> {
  @override
  void initState() {
    _foodRequest = FirebaseFirestore.instance
        .collection('foodRequest')
        .where('donatedUid', isEqualTo: getUserId())
        .where('status', isEqualTo: 'confirmed')
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _foodRequest,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading"));
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No Data Found"));
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
                  // elevation: 6,
                  margin: const EdgeInsets.all(10),
                  child: InkWell(
                    child: ListTile(
                      leading: BlinkingText(
                          text: "${data['foodDate']}\n ${data['foodTime']}",
                          style: TextStyle(
                              color: Colors.white,
                              backgroundColor: Colors.purple,
                              fontWeight: FontWeight.bold)),
                      title: Text(data['foodItems']),
                      subtitle: Text("${'Req Mob:' + data['mobileNumber']} "),
                      trailing: Text(data['status'], style: textstyle()),
                    ),
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
