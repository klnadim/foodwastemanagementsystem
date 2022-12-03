import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management_system/screens/admin_panel.dart';
import 'package:food_waste_management_system/screens/dashboard/dashboard_screen2.dart';
import 'package:food_waste_management_system/screens/donar_dashboard_screen.dart';
import 'package:food_waste_management_system/screens/donnar_add_food.dart';
import 'package:food_waste_management_system/screens/login_screen.dart';
import 'package:food_waste_management_system/screens/signup_screen.dart';

 void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food waste Management System',
      home: LoginScreen(),
      
    
      
    );
  }
}
