import 'dart:math';
import 'dart:ui';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management_system/utils/styles.dart';
import 'package:food_waste_management_system/widgets/card_dashboard.dart';
import 'package:food_waste_management_system/widgets/list_title.dart';

import '../utils/methods.dart';
import 'user_profile.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({Key? key}) : super(key: key);

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
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

    try {
      if (li == null) {
        setState(() {
          pGetImageUrl = listData![0][''];
          pFullName = listData![0][''];
          pMobileNumber = listData![0][''];
        });
      } else {
        setState(() {
          listData = li;

          pGetImageUrl = listData![0]['photoUrl'];
          pFullName = listData![0]['fullName'];
          pMobileNumber = listData![0]['number'];
        });
      }
    } catch (e) {
      Text(e.toString());
    }

    // if (li != null) {
    //   setState(() {
    //     listData = li;

    //     pGetImageUrl = listData![0]['photoUrl'];
    //     pFullName = listData![0]['fullName'];
    //     pMobileNumber = listData![0]['number'];
    //   });
    // } else {
    //   print("unable data retrive");
    // }
  }

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
          actions: [
            TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                icon: Icon(Icons.home),
                label: Text(""))
          ],
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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserProfile(userId: user!.uid),
                      ));
                },
                child: Card(
                  child: listtile("Profile", Icons.person_outline_outlined),
                ),
              ),
              SizedBox(
                height: 20,
              ),
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
            childAspectRatio: 10 / 9,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/donatedFoodView');
                },
                child: singleCard(Icons.done_all_outlined, "Donated Foods"),
              ),
              singleCard(Icons.request_page, "Request"),
              singleCard(Icons.close, "Rejected")
            ],
          ),
        ),
      ),
    );
  }
}
