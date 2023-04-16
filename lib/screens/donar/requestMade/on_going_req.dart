import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management_system/utils/methods.dart';
import 'package:intl/intl.dart';

import '../../../models/arguments_return.dart';
import '../../../utils/styles.dart';
import '../donated_food_view.dart';

class OnGoingRequestSreen extends StatefulWidget {
  const OnGoingRequestSreen({Key? key}) : super(key: key);

  @override
  State<OnGoingRequestSreen> createState() => _OnGoingRequestSreenState();
}

final Stream<QuerySnapshot> _foodCollection = FirebaseFirestore.instance
    .collection('addFood')
    .where('date',
        isGreaterThanOrEqualTo:
            DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
    .where('uid', isEqualTo: getUserId())
    // .orderBy('date', descending: true)
    // .orderBy('time', descending: true)
    .snapshots();

DateTime selectedDate = DateTime.now();

class _OnGoingRequestSreenState extends State<OnGoingRequestSreen> {
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
          stream: _foodCollection,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

                // if (dt1.compareTo(dt2) > 0) {
                return Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Card(
                      elevation: 6,
                      margin: const EdgeInsets.all(10),
                      child: ExpansionTile(
                        leading: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.transparent,
                          // backgroundColor: Colors.purple,
                          backgroundImage: NetworkImage(
                            data['imagesUrls'][0],
                          ),
                        ),
                        title: Text(data['foodItems']),
                        subtitle: Text(
                          "[$vDate" + " " + "$_vTime ]",
                          style: TextStyle(
                            color: Colors.black,
                            backgroundColor: Colors.green,
                          ),
                        ),
                        children: [
                          Text("Req 1"),
                          Text("Req 2"),
                          Text("Req 3"),
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () {}, child: Text("See all"))
                            ],
                          )
                          // ListTile(

                          //   trailing: InkWell(
                          //       onTap: () {
                          //         Navigator.pushNamed(
                          //             context, DonatedFoodView.routeName,
                          //             arguments: ScreenArguments(
                          //                 document.id, data['uid']));
                          //       },
                          //       child:
                          //           Icon(Icons.keyboard_arrow_right_rounded)),
                          // ),
                        ],
                      ),
                    ),
                    // InkWell(
                    //     onTap: () {},
                    //     child: Icon(Icons.notification_important_outlined))
                  ],
                );
                // }
              }).toList(),
            );
          },
        ),
        //
      ),
    );
  }
}
