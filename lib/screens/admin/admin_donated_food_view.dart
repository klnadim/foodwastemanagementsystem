import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DonatedFoodViewScreen extends StatefulWidget {
  const DonatedFoodViewScreen({Key? key}) : super(key: key);

  @override
  State<DonatedFoodViewScreen> createState() => _DonatedFoodViewScreenState();
}

class _DonatedFoodViewScreenState extends State<DonatedFoodViewScreen> {
  final Stream<QuerySnapshot> _foodCollection =
      FirebaseFirestore.instance.collection('addFood').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _foodCollection,
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
                  subtitle: Text(data['publicOrPrivate']),
                  trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
