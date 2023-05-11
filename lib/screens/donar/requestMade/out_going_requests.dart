import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management_system/screens/donar/donar_dashboard_screen.dart';
import 'package:food_waste_management_system/screens/donar/requestMade/request_made.dart';
import 'package:food_waste_management_system/utils/styles.dart';
import 'package:food_waste_management_system/widgets/blinking_text.dart';

import '../../../utils/methods.dart';

class OutGoingRequestScreen extends StatefulWidget {
  const OutGoingRequestScreen({Key? key}) : super(key: key);

  @override
  State<OutGoingRequestScreen> createState() => _OutGoingRequestScreenState();
}

class _OutGoingRequestScreenState extends State<OutGoingRequestScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final Stream<QuerySnapshot> _foodRequest = FirebaseFirestore.instance
      .collection('foodRequest')
      // .orderBy('dateTime', descending: true)
      .where('requestUid', isEqualTo: getUserId())
      .snapshots();

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
                                "Are you sure you want to Cancel your Request?"),
                            actions: [
                              TextButton(
                                child: Text("CANCEL"),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              TextButton(
                                child: Text("DELETE"),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('foodRequest')
                                      .doc(document.id)
                                      .delete()
                                      .then(
                                    (value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return DonarDashboardScreen();
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
                      // Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: BlinkingText(
                          text: "${data['foodDate']}\n ${data['foodTime']}",
                          style: TextStyle(
                              color: Colors.white,
                              backgroundColor: Colors.purple,
                              fontWeight: FontWeight.bold)),
                      title: Text(data['foodItems']),
                      subtitle: Text(
                          "${data['donnarMobileNumber']} \n\n ${data['status'] == 'rejected' ? data['rejectionReason'] : ""}"),
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
