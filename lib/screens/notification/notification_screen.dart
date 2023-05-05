import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management_system/screens/donar/requestMade/request_view.dart';
import 'package:food_waste_management_system/screens/notification/notifications.dart';
import 'package:food_waste_management_system/utils/methods.dart';

import '../../models/arguments_return.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({required this.getDocID, Key? key}) : super(key: key);
  String? getDocID;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationServices noti = NotificationServices();

  String? docId;
  Stream<QuerySnapshot>? foodRequest;

  @override
  void initState() {
    docId = widget.getDocID;
    // TODO: implement initState
    // noti.listenToCollection(getUserId());
    // noti.sendNotificationToUser(getUserId(), "title", "body");
    foodRequest = FirebaseFirestore.instance
        .collection('foodRequest')
        // .where('donatedUid', isEqualTo: getUserId())
        .where('documentId', isEqualTo: docId)
        .where('status', isEqualTo: "")
        .snapshots();

    print(docId ?? "null");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  myShowDialog(context, buildContext) {
    showDialog(context: context, builder: buildContext);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
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
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RequestFoodView.routeName,
                          arguments: ScreenArguments(
                              data['documentId'], data['requestUid']));
                    },
                    child: ListTile(
                      // onLongPress: {},
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
                      // trailing: InkWell(
                      //     onTap: () {
                      //       // Navigator.pushNamed(
                      //       //     context, RequestFoodView.routeName,
                      //       //     arguments: ScreenArguments(
                      //       //         data['documentId'], data['requestUid']));
                      //     },
                      //     child: Icon(Icons.keyboard_arrow_right_rounded)),
                    ),
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
