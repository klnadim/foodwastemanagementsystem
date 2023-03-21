import 'package:flutter/material.dart';

import 'package:food_waste_management_system/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/card_dashboard.dart';

import 'package:food_waste_management_system/screens/donnar_add_food.dart';
import 'package:food_waste_management_system/screens/home_screen.dart';

import 'package:food_waste_management_system/screens/user_profile.dart';

import '../utils/methods.dart';

class NgoDashboardScreen extends StatefulWidget {
  const NgoDashboardScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NgoDashboardScreen> createState() => _NgoDashboardScreenState();
}

class _NgoDashboardScreenState extends State<NgoDashboardScreen> {
  String? name;

  Image? image;

  //user profile data get and set varibale
  Map? listData;
  String? pGetImageUrl;
  String? pMobileNumber;
  String? pFullName;

  // FirebaseFirestore _firestore = FirebaseFirestore.instance.collection()

  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    // print(user);

    super.initState();
    pGet();
  }

  pGet() async {
    var li = await retriveProfileData(getUserId());

    if (li != null) {
      setState(() {
        listData = li;

        pGetImageUrl = listData![0]['photoUrl'];
        pFullName = listData![0]['fullName'];
        pMobileNumber = listData![0]['number'];
      });
    } else {
      print("unable data retrive");
    }
  }

  // ImageProvider imagePro= getImageUrl != null
  //                               ? Image.network("$getImageUrl")
  //                               : Image.network(
  //                                       "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png")
  //                                   .image);

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[100],
        appBar: AppBar(
          title: Text(
            "Hello $pFullName ",
            style: textstyle(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: const [],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    height: 150,
                    width: double.infinity,
                    color: Colors.black12,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundImage: pGetImageUrl != null
                              ? NetworkImage("$pGetImageUrl")
                              : NetworkImage(
                                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),

                          // Image.network(
                          //             "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png")
                          //         .image
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("")
                      ],
                    ),
                  ),
                ),
              ),
              Card(child: listtile("Dashboard", Icons.dashboard)),
              const Divider(
                color: Colors.black26,
              ),
              InkWell(
                  onTap: (() {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => AdminPanelScreen(),
                    //     ));
                  }),
                  child:
                      Card(child: listtile("Notification", Icons.dashboard))),
              const Divider(
                color: Colors.black26,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfile(userId: user!.uid),
                        ));
                  },
                  child: Card(child: listtile("Profile", Icons.dashboard))),
              ElevatedButton(
                  onPressed: () => logOut(context), child: Text("LogOut"))
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 30,
            mainAxisSpacing: 20,
            children: [
              // InkWell()

              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                },
                child: singleCard(Icons.home, 'Home'),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DonnarAddFood(),
                      ));
                },
                child: singleCard(Icons.food_bank_outlined, 'Approved List'),
              ),

              // InkWell(
              //   onTap: () {
              //     Navigator.pushNamed(context, '/indivisualDonatedList');
              //   },
              //   child: singleCard(Icons.list_alt_rounded, 'Donated List'),
              // ),

              // ElevatedButton(
              //     onPressed: () {
              //       setState(() {
              //         pGet();
              //       });
              //     },
              //     child: Text("Click"))
            ],
          ),
        ),
      ),
    );
  }

  ListTile listtile(String text, IconData iconData) =>
      ListTile(title: Text("$text"), leading: Icon(iconData));
}



// class NgoDashboardScreen extends StatelessWidget {
//   NgoDashboardScreen({Key? key}) : super(key: key);

//   String? name;
//   Image? image;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.blueGrey[100],
//         appBar: AppBar(
//           title: Text(
//             "Hello Nadim",
//             style: textstyle(),
//           ),
//           backgroundColor: Colors.transparent,
//           elevation: 0.0,
//           actions: [
//             TextButton(
//                 onPressed: () {
//                   FirebaseAuth.instance.signOut();
//                 },
//                 child: Text("LogOut"))
//           ],
//         ),
//         drawer: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               DrawerHeader(
//                 child: Center(
//                   child: Container(
//                     padding: const EdgeInsets.only(top: 10),
//                     height: 150,
//                     width: double.infinity,
//                     color: Colors.black12,
//                     child: Column(
//                       children: [
//                         CircleAvatar(
//                             radius: 45,
//                             backgroundImage: Image.asset("IMG").image),
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         Text("NGO")
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Card(child: listtile("Dashboard", Icons.dashboard)),
//               const Divider(
//                 color: Colors.black26,
//               ),
//               Card(child: listtile("Notification", Icons.dashboard)),
//               const Divider(
//                 color: Colors.black26,
//               ),
//               Card(child: listtile("Profile", Icons.dashboard)),
//             ],
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: GridView.count(
//             crossAxisCount: 2,
//             crossAxisSpacing: 30,
//             mainAxisSpacing: 20,
//             children: [
//               Text("NGO Dashboard"),
//               singleCard(Icons.food_bank_outlined, 'Approved List'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   ListTile listtile(String text, IconData iconData) =>
//       ListTile(title: Text("$text"), leading: Icon(iconData));
// }
