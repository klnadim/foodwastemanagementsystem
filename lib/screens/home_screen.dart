import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:food_waste_management_system/models/arguments_return.dart';

import 'package:food_waste_management_system/screens/login_screen.dart';

import 'package:food_waste_management_system/screens/ngo/ngo_dashboard.dart';
import 'package:food_waste_management_system/utils/methods.dart';

import 'admin/admin_panel.dart';
import 'donar/donar_dashboard_screen.dart';
import 'donar/donated_food_view.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Stream<DocumentSnapshot<Map<String, dynamic>>> documentStream =
  //     FirebaseFirestore.instance
  //         .collection('addFood')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .snapshots();.

  // final Stream<QuerySnapshot> _usersStream =
  //     FirebaseFirestore.instance.collection('addFood').snapshots();

  void getData() {
    var ffff = getFoodData();
    print(ffff);
  }

  final Stream<QuerySnapshot> _foodCollection =
      FirebaseFirestore.instance.collection('addFood').snapshots();
  bool foodDataAvailble = false;
  TextStyle myText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  Color myColor = Colors.green;

  void checkLoginOrNot() {
    if (getUserId().isEmpty) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    }
  }

//for connection check

//end con
  @override
  void initState() {
    // checkLoginOrNot();
    super.initState();

    // Future.delayed(Duration(seconds: 3));
    // var vUserId = user!.uid;
    // if (vUserId.isEmpty) {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => LoginScreen(),
    //       ));
    // } else {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => HomeScreen(),
    //       ));
    // }
  }

  String searchName = "";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // DataColumn columnsName = [];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff6ae792),
        actions: [
          InkWell(
            onTap: () => basedOfLogin(),
            child: Icon(Icons.person_outline_rounded),
          ),
          TextButton(
              // ignore: unnecessary_null_comparison
              onPressed: () => logOut(context),
              child: Text(getUserId() == null ? "Login" : "Logout"))
        ],
        title: Card(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search',
            ),
            onChanged: (val) {
              setState(() {
                searchName = val;
                print(searchName);
              });
            },
          ),
        ),
      ),
      body: Center(
        child:
            // mainAxisAlignment: MainAxisAlignment.center,

            // Text("SignIn with \n ${getUserId() ?? 'null'}"),
            // TextButton(
            //     onPressed: () {
            //       basedOfLogin();
            //     },
            //     child: Text("Profile")),

            // color: Colors.cyan,

            StreamBuilder(
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

                if (data['city'].toString().toLowerCase().startsWith(
                      searchName.toLowerCase(),
                    )) {
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
                            Navigator.pushNamed(
                                context, DonatedFoodView.routeName,
                                arguments: ScreenArguments(document.id));
                          },
                          child: Icon(Icons.keyboard_arrow_right_rounded)),
                    ),
                  );
                }
                return Card(
                    // elevation: 6,
                    // margin: const EdgeInsets.all(10),
                    // child: ListTile(
                    //   leading: CircleAvatar(
                    //     radius: 30.0,
                    //     backgroundColor: Colors.transparent,
                    //     // backgroundColor: Colors.purple,
                    //     backgroundImage: NetworkImage(
                    //       data['imagesUrls'][0],
                    //     ),
                    //   ),
                    //   title: Text(data['foodItems']),
                    //   subtitle: Text(data['city']),
                    //   trailing: InkWell(
                    //       onTap: () {
                    //         Navigator.pushNamed(
                    //             context, DonatedFoodView.routeName,
                    //             arguments: ScreenArguments(document.id));
                    //       },
                    //       child: Icon(Icons.keyboard_arrow_right_rounded)),
                    // ),
                    );
              }).toList(),
            );
          },
        ),
        // child: StreamBuilder<QuerySnapshot>(
        //   stream: _foodCollection,
        //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        //     //Catch data from Firebase
        //     final List dataFoods = [];
        //     if (snapshot.data == null) {
        //       return Text("Null");
        //     }

        //     if (snapshot.hasError) {
        //       return Text("Something went Wrong!");
        //     }
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Text("Loading");
        //     }
        //     snapshot.data!.docs.map((DocumentSnapshot document) {
        //       Map a = document.data() as Map<String, dynamic>;

        //       a['id'] = document.id;
        //       dataFoods.add(a);
        //     }).toList();
        //     if (dataFoods.isNotEmpty) {
        //       foodDataAvailble = true;
        //     }

        //     return foodDataAvailble == false
        //         ? Text("No Data Availabile At this Moment")
        //         : Container(
        //             margin: EdgeInsets.all(10),
        //             child: Table(
        //               border: TableBorder.all(),
        //               // columnWidths: const {1: FlexColumnWidth(50)},
        //               columnWidths: {1: FlexColumnWidth(2)},
        //               // defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        //               children: [
        //                 TableRow(
        //                   children: [
        //                     TableCell(
        //                       child: Container(
        //                         color: myColor,
        //                         child: Center(
        //                           child: Text(
        //                             "Items",
        //                             style: myText,
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                     TableCell(
        //                       child: Container(
        //                         color: myColor,
        //                         child: Center(
        //                           child: Text(
        //                             "City",
        //                             style: myText,
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                     TableCell(
        //                       child: Container(
        //                         color: myColor,
        //                         child: Center(
        //                           child: Text(
        //                             "Persons",
        //                             style: myText,
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                     TableCell(
        //                       child: Container(
        //                         color: myColor,
        //                         child: Center(
        //                           child: Text(
        //                             "View",
        //                             style: myText,
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                   ],
        //                 ),

        //                 //For Loop Start
        //                 for (var i = 0; i < dataFoods.length; i++) ...[
        //                   TableRow(children: [
        //                     TableCell(
        //                         child: Center(
        //                             child: Text(dataFoods[i]
        //                                     ['foodItems']
        //                                 .toString()))),
        //                     TableCell(
        //                         child: Center(
        //                             child: Text(dataFoods[i]['city']
        //                                 .toString()))),
        //                     TableCell(
        //                         child: Center(
        //                             child: Text(dataFoods[i]
        //                                     ['foodPerson']
        //                                 .toString()))),
        //                     TableCell(
        //                       child: Center(
        //                         child: Row(
        //                           mainAxisAlignment:
        //                               MainAxisAlignment.spaceEvenly,
        //                           children: [
        //                             InkWell(
        //                               child: Icon(
        //                                 Icons.remove_red_eye_sharp,
        //                                 color: Colors.blueAccent,
        //                               ),
        //                               onTap: () {
        //                                 Navigator.push(
        //                                     context,
        //                                     MaterialPageRoute(
        //                                       builder: (context) =>
        //                                           DonatedFoodView(
        //                                               id: dataFoods[i]
        //                                                   ['id']),
        //                                     ));
        //                               },
        //                             ),
        //                             // InkWell(
        //                             //   onTap: () {
        //                             //     deleteUser(dataStudents[i]['id']);
        //                             //   },
        //                             //   child: Icon(
        //                             //     Icons.delete_outline_outlined,
        //                             //     color: Colors.red,
        //                             //   ),
        //                             // ),
        //                           ],
        //                         ),
        //                       ),
        //                     ),
        //                   ])
        //                 ],

        //                 // TableRow(
        //                 //   children: [
        //                 //     TableCell(
        //                 //       child: Container(
        //                 //         child: Text("Nadim"),
        //                 //       ),
        //                 //     ),
        //                 //   ],
        //                 // ),
        //               ],
        //             ),
        //           );
        //   },
        // )

        // StreamBuilder<QuerySnapshot>(
        //   stream: _usersStream,
        //   builder: (BuildContext context,
        //       AsyncSnapshot<QuerySnapshot> snapshot) {
        //     if (snapshot.hasData) {
        //       return ListView(
        //         children:
        //             snapshot.data!.docs.map((DocumentSnapshot document) {
        //           Map<String, dynamic> data =
        //               document.data()! as Map<String, dynamic>;

        //           var vuid = data['uid'].toString();
        //           var id;
        //           if (FirebaseAuth.instance.currentUser!.uid == vuid) {
        //             id = vuid;
        //             print(id);
        //           } else {
        //             id = "";
        //           }

        //           return Table(
        //             children: const [
        //               TableRow(
        //                 children: [
        //                   Text('Foods',
        //                       textAlign: TextAlign.center,
        //                       style:
        //                           TextStyle(fontWeight: FontWeight.bold)),
        //                   Text('City',
        //                       textAlign: TextAlign.center,
        //                       style:
        //                           TextStyle(fontWeight: FontWeight.bold)),
        //                   Text('For Persons',
        //                       textAlign: TextAlign.center,
        //                       style:
        //                           TextStyle(fontWeight: FontWeight.bold)),
        //                   Text('View',
        //                       textAlign: TextAlign.center,
        //                       style:
        //                           TextStyle(fontWeight: FontWeight.bold)),
        //                 ],
        //               ),
        //               TableRow(children: [
        //                 Text("data"),
        //                 Text("data"),
        //                 Text("data"),
        //                 Text("0"),
        //               ]),
        //             ],
        //           );
        //         }).toList(),
        //       );
        //     }
        //     if (snapshot.hasError) {
        //       return Text('Something went wrong');
        //     }

        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Text("Loading");
        //     }
        //     return Text("data");
        //   },
        // ),
      ),
    );
  }

  void basedOfLogin() {
    // print(user!.uid);
    FirebaseFirestore.instance.collection('users').doc(getUserId()).get().then(
      (value) {
        // if (value.get('rool') == 'Admin') {
        //   return AdminPanelScreen();
        // } else if (value.get('rool') == 'NGO') {
        //   return NgoDashboardScreen();
        // } else if (value.get('rool') == 'DONAR') {
        //   return DonarDashboardScreen();
        // }

        if (value.get('rool') == "ADMIN") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminPanelScreen()),
          );
        } else if (value.get('rool') == 'NGO') {
          return Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NgoDashboardScreen(),
            ),
          );
        } else if (value.get('rool') == 'DONAR') {
          return Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DonarDashboardScreen(),
            ),
          );
        } else {
          return Text("No Profile found");
        }
      },
    );
  }
}
