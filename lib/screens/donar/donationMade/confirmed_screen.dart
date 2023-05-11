import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConfirmedDonations extends StatefulWidget {
  const ConfirmedDonations({Key? key}) : super(key: key);

  @override
  State<ConfirmedDonations> createState() => _ConfirmedDonationsState();
}

final Stream<QuerySnapshot> _foodRequest = FirebaseFirestore.instance
    .collection('foodRequest')
    // .where('status', isEqualTo: 'confirmed')
    .snapshots();

class _ConfirmedDonationsState extends State<ConfirmedDonations> {
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

              if (data.isEmpty) {
                print("NO DATA");
              }

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
