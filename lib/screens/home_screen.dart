import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management_system/screens/admin_panel.dart';
import 'package:food_waste_management_system/screens/donar_dashboard_screen.dart';
import 'package:food_waste_management_system/screens/ngo_dashboard.dart';
import 'package:food_waste_management_system/utils/methods.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: () => logOut(context), child: Text("LogOut"))
        ],
        title: const Text(
          "Homepage",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Home Page Of the APP"),
            Text("SignIn with \n ${user!.uid}"),
            TextButton(
                onPressed: () {
                  basedOfLogin();
                },
                child: Text("Profile"))
          ],
        ),
      ),
    );
  }

  void basedOfLogin() {
    // print(user!.uid);
    FirebaseFirestore.instance.collection('users').doc(user!.uid).get().then(
      (value) {
        // if (value.get('rool') == 'Admin') {
        //   return AdminPanelScreen();
        // } else if (value.get('rool') == 'NGO') {
        //   return NgoDashboardScreen();
        // } else if (value.get('rool') == 'DONAR') {
        //   return DonarDashboardScreen();
        // }
        print(value.get('rool'));
        if (value.get('rool') == 'NGO') {
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
