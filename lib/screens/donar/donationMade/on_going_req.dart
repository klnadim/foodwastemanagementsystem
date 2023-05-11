import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management_system/screens/notification/all_notification_screen.dart';
import 'package:food_waste_management_system/screens/notification/notification_screen.dart';
import 'package:food_waste_management_system/utils/methods.dart';
import 'package:intl/intl.dart';

import '../../../models/arguments_return.dart';
import '../../../utils/styles.dart';
import '../../../widgets/blinking_text.dart';
import '../donated_food_view.dart';

class OnGoingRequestSreen extends StatefulWidget {
  const OnGoingRequestSreen({Key? key}) : super(key: key);

  @override
  State<OnGoingRequestSreen> createState() => _OnGoingRequestSreenState();
}

// List email = [];
String? city;
List allDocId = [];

Stream<QuerySnapshot>? foodCollection;

// void getDocumentIdFromFoodAdd() {
//   FirebaseFirestore.instance
//       .collection('addFood')
//       .where('date',
//           isGreaterThanOrEqualTo:
//               DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
//       .where('uid', isEqualTo: getUserId())
//       // .orderBy('date', descending: true)
//       // .orderBy('time', descending: true)
//       .get()
//       .then((value) {
//     value.docs.forEach((element) {
//       // var allD = element.data();

//       allDocId.add(element.id);
//     });
//     print(allDocId);
//   });
// }

DateTime selectedDate = DateTime.now();

int? countrrrr;
List emailList = [];
int count = 0;
Future<int?> countDocumentsWithSameUserID(String userID, String docId) async {
  // QuerySnapshot snapshot = await FirebaseFirestore.instance
  //     .collection('foodRequest')
  //     .where('donatedUid', isEqualTo: userID)
  //     .get()
  //     .then(((value) {
  //   return value;
  // }));

  // QuerySnapshot snapshot = await FirebaseFirestore.instance
  //     .collection('foodRequest')
  //     .where('documentId', isEqualTo: docId)
  //     // .where('donatedUid', isEqualTo: 'L1bz9LvWPohZngZvopOuEiwL6np1')
  //     .get().then();

  // Define the query to retrieve the count data with additional information
  Query query = FirebaseFirestore.instance
      .collection('foodRequest')
      .where('documentId', isEqualTo: docId);

// Retrieve the count data with additional information
  query.get().then((querySnapshot) {
    count = querySnapshot.size;

    querySnapshot.docs.forEach((element) {
      emailList.add(element.data());
    });

    // print('Count: $count');
    // // print('Data: $data');
    print(emailList[0]['email']);
    print(emailList[1]['email']);
  }).catchError((error) {
    print('Error retrieving data: $error');
  });
  // print(count);

  // return count;
}

// void getcountRRRR(String docId) async {
//   countrrrr = await countDocumentsWithSameUserID(getUserId(), docId);
// }

class _OnGoingRequestSreenState extends State<OnGoingRequestSreen> {
  @override
  void initState() {
    // getcoutRRRR();
    // getDocumentIdFromFoodAdd();

    foodCollection = FirebaseFirestore.instance
        .collection('addFood')
        .where('date',
            isGreaterThanOrEqualTo:
                DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
        .where('uid', isEqualTo: getUserId())
        // .orderBy('date', descending: true)
        // .orderBy('time', descending: true)
        .snapshots();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

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
      floatingActionButton: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
            const Color(0xff6ae792),
          )),
          onPressed: () {
            Navigator.pushNamed(context, '/addFood');
          },
          child: Text(
            "Donate Now",
            style: textstyle(),
          )),
      body: Center(
        child: StreamBuilder(
          stream: foodCollection,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading..");
            }

            return ListView(
              children: snapshot.data!.docs.map(
                (DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;

                  String? vDate = data['date'];

                  String _vTime = data['time'];
                  DateTime _timeee = DateFormat.jm().parse(_vTime);
                  var _t = DateFormat("HH:mm:ss").format(_timeee);

                  var datTime = vDate! + " " + _t;

                  // DateTime _time = DateTime.parse(_t);

                  // var _todayDate = DateFormat("yyyy-MM-dd").format(timeSelect);

                  // var convertedDays =
                  //     DateTime.parse(vDate!).difference(DateTime.now()).inDays;

                  DateTime dt1 = DateTime.parse(datTime);
                  DateTime dt2 = selectedDate;

                  if (dt1.compareTo(dt2) == 0) {
                    print("Both date time are at same moment.");
                  }

                  if (dt1.compareTo(dt2) < 0) {
                    print("DT1 is before DT2");
                  }

                  if (dt1.compareTo(dt2) > 0) {
                    print("DT1 is after DT2");
                  }

                  // getcountRRRR(document.id);
                  // print(document.id);

                  // print(selectedDate.difference(DateTime.parse(vDate!)).inDays);

                  // print(vDate == _todayDate ? "True" : "False");

                  // print(_vTime =
                  //     formatDate( )
                  //         .toString());

                  // print(
                  //     DateFormat.yMEd().add_jms().format(DateTime.parse(vTime)));

                  // print(DateTime.parse(vDate!));

                  // String? nowDate = DateFormat('yyyy-MM-dd').format(selectedDate);
                  // print(nowDate);

                  // if (vDate == null) {
                  //   return Text("erorr");
                  // } else {
                  //   print(DateTime.parse(vDate));
                  // }

                  if (dt1.compareTo(dt2) > 0) {
                    return Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Card(
                          elevation: 6,
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
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
                                        "Are you sure you want to delete this Item?"),
                                    actions: [
                                      TextButton(
                                        child: Text("CANCEL"),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                      TextButton(
                                        child: Text("DELETE"),
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('addFood')
                                              .doc(document.id)
                                              .delete()
                                              .then(
                                            (value) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);

                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return OnGoingRequestSreen();
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
                            },
                            leading: CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Colors.transparent,
                              // backgroundColor: Colors.purple,
                              backgroundImage: NetworkImage(
                                data['imagesUrls'][0],
                              ),
                            ),
                            title: Text(data['foodItems']),
                            subtitle: BlinkingText(
                                text: "$vDate" + " " + "$_vTime",
                                style: TextStyle(
                                    color: Colors.white,
                                    backgroundColor: Colors.purple,
                                    fontWeight: FontWeight.bold)),
                            trailing: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            NotificationScreen(
                                                getDocID: document.id),
                                      ));
                                },
                                child: Icon(Icons.request_page)),
                          ),
                        ),
                      ],
                    );
                  }

                  return Card();
                },
              ).toList(),
            );
          },
        ),
        //
      ),
    );
  }
}
