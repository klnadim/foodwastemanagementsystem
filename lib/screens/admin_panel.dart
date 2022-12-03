import 'dart:math';
import 'dart:ui';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management_system/utils/styles.dart';
import 'package:food_waste_management_system/widgets/card_dashboard.dart';
import 'package:food_waste_management_system/widgets/list_title.dart';

class AdminPanelScreen extends StatelessWidget {
  AdminPanelScreen({Key? key}) : super(key: key);

  String? name;
  Image? image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[100],
        appBar: AppBar(
          title: Text(
            "Hello Admin",
            style: textstyle(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: const [
            // Text("Hello Nadim"),
            // PopupMenuButton(itemBuilder: (context) {
            //   return [const PopupMenuItem(child: Text("Dashboard")),const PopupMenuItem(child: Text("Dashboard")),];
            // },)
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
                            backgroundImage:
                                Image.asset("assets/images/testimage.JPG")
                                    .image),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("admin@gmail.com")
                      ],
                    ),
                  ),
                ),
              ),
              Card(child: listtile("Dashboard", Icons.dashboard)),
              const Divider(
                color: Colors.black26,
              ),
              
              
              
              
              Card(child: listtile("Profile", Icons.person_outline_outlined)),
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
            children: [singleCard(Icons.done_all_outlined, "Donated Foods"),singleCard(Icons.request_page, "Request"),singleCard(Icons.close, "Rejected")],
          ),
        ),
      ),
    );
  }
}
