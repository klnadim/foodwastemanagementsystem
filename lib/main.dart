import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management_system/screens/admin/admin_all_donation.dart';

import 'package:food_waste_management_system/screens/admin/request/admin_request_mode.dart';

import 'package:food_waste_management_system/screens/donar/donar_dashboard_screen.dart';
import 'package:food_waste_management_system/screens/donar/donated_food_view.dart';
import 'package:food_waste_management_system/screens/donar/indivisual_donated_list.dart';
import 'package:food_waste_management_system/screens/donar/donationMade/donation_mode.dart';
import 'package:food_waste_management_system/screens/donar/donationMade/on_going_req.dart';
import 'package:food_waste_management_system/screens/donar/requestMade/request_made.dart';
import 'package:food_waste_management_system/screens/donar/requestMade/request_view.dart';
import 'package:food_waste_management_system/screens/home_screen.dart';
import 'package:food_waste_management_system/screens/splash_screen.dart';
import 'package:food_waste_management_system/screens/user_profile.dart';
import 'package:food_waste_management_system/utils/methods.dart';

import 'screens/donar/donnar_add_food.dart';
import 'screens/login_signup/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgoundHandler);

  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgoundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.notification!.title.toString());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food waste Management System',
      theme: ThemeData(fontFamily: 'Lato'),
      home: SplashScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/addFood': (context) => DonnarAddFood(),
        '/indivisualDonatedList': (context) => IndivisualDonatedList(),
        DonatedFoodView.routeName: (context) => DonatedFoodView(),
        RequestFoodView.routeName: (context) => RequestFoodView(),
        '/profile': (context) =>
            UserProfile(userId: FirebaseAuth.instance.currentUser!.uid),
        '/donarDashboard': (context) => DonarDashboardScreen(),
        '/donationMode': (context) => DonationMode(),
        '/onGoingRequest': (context) => OnGoingRequestSreen(),
        '/requestMode': (context) => RequestMode(),
        '/adminDonationScreen': (context) => AdminDonationScreen(),
        '/adminRequestMade': (context) => AdminRequestMode()
      },
    );
  }
}
