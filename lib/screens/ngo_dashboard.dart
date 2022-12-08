import 'package:flutter/material.dart';
import 'package:food_waste_management_system/screens/login_screen.dart';
import 'package:food_waste_management_system/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/card_dashboard.dart';

class NgoDashboardScreen extends StatelessWidget {
  NgoDashboardScreen({Key? key}) : super(key: key);

  String? name;
  Image? image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[100],
        appBar: AppBar(
          title: Text(
            "Hello Nadim",
            style: textstyle(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Text("LogOut"))
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
                            backgroundImage: Image.asset("IMG").image),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("NGO")
                      ],
                    ),
                  ),
                ),
              ),
              Card(child: listtile("Dashboard", Icons.dashboard)),
              const Divider(
                color: Colors.black26,
              ),
              Card(child: listtile("Notification", Icons.dashboard)),
              const Divider(
                color: Colors.black26,
              ),
              Card(child: listtile("Profile", Icons.dashboard)),
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
              Text("NGO Dashboard"),
              singleCard(Icons.food_bank_outlined, 'Approved List'),
            ],
          ),
        ),
      ),
    );
  }

  ListTile listtile(String text, IconData iconData) =>
      ListTile(title: Text("$text"), leading: Icon(iconData));
}
