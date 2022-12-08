import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management_system/screens/admin_panel.dart';
import 'package:food_waste_management_system/screens/user_profile.dart';
import 'package:food_waste_management_system/utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/card_dashboard.dart';

class DonarDashboardScreen extends StatefulWidget {
  DonarDashboardScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DonarDashboardScreen> createState() => _DonarDashboardScreenState();
}

class _DonarDashboardScreenState extends State<DonarDashboardScreen> {
  String? name;

  Image? image;

  // FirebaseFirestore _firestore = FirebaseFirestore.instance.collection()

  @override
  void initState() {
    // TODO: implement initState

    User? user = FirebaseAuth.instance.currentUser;
    print(user);

    super.initState();
  }

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[100],
        appBar: AppBar(
          title: Text(
            "Hello ",
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
                            backgroundImage:
                                Image.asset("assets/images/testimage.JPG")
                                    .image),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminPanelScreen(),
                        ));
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
              singleCard(Icons.food_bank_outlined, 'Add Food'),
              singleCard(Icons.list_alt_rounded, 'Donated List'),
            ],
          ),
        ),
      ),
    );
  }

  ListTile listtile(String text, IconData iconData) =>
      ListTile(title: Text("$text"), leading: Icon(iconData));
}
