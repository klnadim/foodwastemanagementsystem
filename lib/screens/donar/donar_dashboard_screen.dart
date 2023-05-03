import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management_system/screens/donar/donnar_add_food.dart';

import 'package:food_waste_management_system/screens/home_screen.dart';
import 'package:food_waste_management_system/screens/notification/all_notification_screen.dart';

import 'package:food_waste_management_system/screens/user_profile.dart';
import 'package:food_waste_management_system/utils/styles.dart';

import '../../utils/methods.dart';
import '../../widgets/card_dashboard.dart';

class DonarDashboardScreen extends StatefulWidget {
  const DonarDashboardScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DonarDashboardScreen> createState() => _DonarDashboardScreenState();
}

class _DonarDashboardScreenState extends State<DonarDashboardScreen> {
  String? name;

  Image? image;

  //user profile data get and set varibale
  Map? listData;
  String? pGetImageUrl;
  String? pMobileNumber;
  String? pFullName;

  //get from user info
  String? pEmailAddress;
  String? pRoolOfUser;

  // FirebaseFirestore _firestore = FirebaseFirestore.instance.collection()

  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    // print(user);

    super.initState();
    pGet();
    gUserData();
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

  gUserData() async {
    var getUserInfoNGO = await getUsersInfo(getUserId());

    if (getUserInfoNGO != null) {
      pEmailAddress = getUserInfoNGO[0]['email'];

      pRoolOfUser = getUserInfoNGO[0]['rool'];
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
                        Text(
                          pEmailAddress ?? "",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Center(
              //   child: Text(
              //     pRoolOfUser ?? "",
              //     style: TextStyle(color: Colors.deepPurple),
              //   ),
              // ),
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
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllNotificationScreen(),
                          ));
                    },
                    child: Card(
                        child: listtile("Notification",
                            Icons.notification_important_outlined)),
                  )),
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
                  child: Card(child: listtile("Profile", Icons.people))),
              ElevatedButton(
                  onPressed: () => logOut(context), child: Text("LogOut"))
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 15,
            mainAxisSpacing: 10,
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
                child: singleCard(Icons.food_bank_outlined, 'Add Food'),
              ),

              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/donationMode');
                },
                child: singleCard(Icons.list_alt_rounded, 'Donation Made'),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/requestMode');
                },
                child: singleCard(Icons.list, 'Request Made'),
              ),

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
