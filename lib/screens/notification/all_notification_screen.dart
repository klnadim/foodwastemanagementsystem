import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management_system/screens/notification/notifications.dart';
import 'package:food_waste_management_system/utils/methods.dart';

class AllNotificationScreen extends StatefulWidget {
  AllNotificationScreen({Key? key}) : super(key: key);

  @override
  State<AllNotificationScreen> createState() => _AllNotificationScreenState();
}

class _AllNotificationScreenState extends State<AllNotificationScreen> {
  NotificationServices noti = NotificationServices();

  final Stream<QuerySnapshot> _foodRequest = FirebaseFirestore.instance
      .collection('foodRequest')
      .where('donatedUid', isEqualTo: getUserId())
      .snapshots();

  @override
  void initState() {
    // TODO: implement initState
    // noti.listenToCollection(getUserId());
    // noti.sendNotificationToUser(getUserId(), "title", "body");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Notifications"),
      ),
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
                    // leading: CircleAvatar(
                    //   radius: 30.0,
                    //   backgroundColor: Colors.transparent,
                    //   // backgroundColor: Colors.purple,
                    //   backgroundImage: NetworkImage(
                    //     data['profilePic'],
                    //   ),
                    // ),
                    title: Text(data['email']),
                    subtitle: Text(data['city']),
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
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Center(child: Text("Notication Screen")),
      //     Center(
      //         child: ElevatedButton(
      //             onPressed: () async {
      //               // var token = await noti.getDeviceToken();
      //               // // print(token);
      //               // noti.saveFCMToken(getUserId(), token);
      //             },
      //             child: Text("data")))
      //   ],
      // ),
    );
  }
}
