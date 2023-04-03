import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management_system/screens/admin/admin_panel_screen.dart';

import 'package:food_waste_management_system/screens/dashboard/dashboard_screen2.dart';
import 'package:food_waste_management_system/screens/donar/donar_dashboard_screen.dart';
import 'package:food_waste_management_system/screens/donar/donated_food_view.dart';
import 'package:food_waste_management_system/screens/donar/indivisual_donated_list.dart';
import 'package:food_waste_management_system/screens/donar/donationMode/donation_mode.dart';
import 'package:food_waste_management_system/screens/donar/requestMode/request_mode.dart';
import 'package:food_waste_management_system/screens/donar/requestMode/request_view.dart';

import 'package:food_waste_management_system/screens/home_screen.dart';

import 'package:food_waste_management_system/screens/ngo/ngo_dashboard.dart';

import 'package:food_waste_management_system/screens/splash_screen.dart';
import 'package:food_waste_management_system/screens/user_profile.dart';
import 'package:food_waste_management_system/utils/methods.dart';

import 'screens/donar/donnar_add_food.dart';
import 'screens/login_signup/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: FirebaseOptions(
      //     apiKey: "AIzaSyCW1ePGZ59uspUs_dlinhOz9yzeb1BW6l0",
      //     authDomain: "fwms-d6bd4.firebaseapp.com",
      //     projectId: "fwms-d6bd4",
      //     storageBucket: "fwms-d6bd4.appspot.com",
      //     messagingSenderId: "506712614677",
      //     appId: "1:506712614677:web:c92747caaa9ab99c6a6b1c",
      //     measurementId: "G-XTM0P7ESC0"),

      );

  runApp(const MyApp());
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
        // '/donatedFoodView': ((context) => DonatedFoodView(id: ,)),
        DonatedFoodView.routeName: (context) => DonatedFoodView(),
        RequestFoodView.routeName: (context) => RequestFoodView(),

        '/profile': (context) =>
            UserProfile(userId: FirebaseAuth.instance.currentUser!.uid),
        // 'ngoDashboard': (context) => NgoDashboardScreen(),
        '/donarDashboard': (context) => DonarDashboardScreen(),
        '/adminDashboard': (context) => AdminPanelScreen(),
        '/donationMode': (context) => DonationMode(),
        '/requestMode': (context) => RequestMode(),
      },
      // home: UserProfile(userId: getUserId()),
    );
  }
}

// class MainPage extends StatelessWidget {
//   const MainPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: StreamBuilder<User?>(
//             stream: FirebaseAuth.instance.authStateChanges(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());

//                 // return HomeScreen();
//               } else if (snapshot.hasError) {
//                 return Text("Something went Wrong.");
//               } else if (snapshot.hasData) {
//                 // FirebaseFirestore.instance
//                 //     .collection('users')
//                 //     .doc(user!.uid)
//                 //     .get()
//                 //     .then(
//                 //   (value) {
//                 //     if (value.get('rool') == 'Admin') {
//                 //       return AdminPanelScreen();
//                 //     } else if (value.get('rool') == 'NGO') {
//                 //       return NgoDashboardScreen();
//                 //     } else if (value.get('rool') == 'DONAR') {
//                 //       return DonarDashboardScreen();
//                 //     }
//                 //   },
//                 // );
//                 // var kk = FirebaseFirestore.instance
//                 //     .collection('users')
//                 //     .doc(user!.uid)
//                 //     .get()
//                 //     .then((DocumentSnapshot documentSnapshot) {
//                 //   if (documentSnapshot.exists) {
//                 //     if (documentSnapshot.get('rool') == "Admin") {
//                 //       Navigator.pushReplacement(
//                 //         context,
//                 //         MaterialPageRoute(
//                 //           builder: (context) => AdminPanelScreen(),
//                 //         ),
//                 //       );
//                 //     } else if (documentSnapshot.get('rool') == "NGO") {
//                 //       Navigator.pushReplacement(
//                 //         context,
//                 //         MaterialPageRoute(
//                 //           builder: (context) => NgoDashboardScreen(),
//                 //         ),
//                 //       );
//                 //     } else if (documentSnapshot.get('rool') == "DONAR") {
//                 //       Navigator.pushReplacement(
//                 //         context,
//                 //         MaterialPageRoute(
//                 //           builder: (context) => DonarDashboardScreen(),
//                 //         ),
//                 //       );
//                 //     } else {
//                 //       Navigator.pushReplacement(
//                 //         context,
//                 //         MaterialPageRoute(
//                 //           builder: (context) => HomeScreen(),
//                 //         ),
//                 //       );
//                 //     }
//                 //   }
//                 // });

//                 return HomeScreen();
//               } else {
//                 return LoginScreen();
//               }
//             }));
//   }
// }
