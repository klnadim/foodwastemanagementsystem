import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:food_waste_management_system/utils/styles.dart';
import 'package:food_waste_management_system/widgets/card_dashboard.dart';
import 'package:food_waste_management_system/widgets/list_title.dart';

import '../../utils/methods.dart';
import '../donar/donnar_add_food.dart';
import '../home_screen.dart';
import '../user_profile.dart';

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

  gUserData() async {
    var getUserInfoNGO = await getUsersInfo(getUserId());

    if (getUserInfoNGO != null) {
      pEmailAddress = getUserInfoNGO[0]['email'];

      pRoolOfUser = getUserInfoNGO[0]['rool'];
    }
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
                        Text(
                          pEmailAddress ?? "",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  pRoolOfUser ?? "",
                  style: TextStyle(color: Colors.deepPurple),
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
            crossAxisCount: 3,
            crossAxisSpacing: 15,
            mainAxisSpacing: 10,
            children: [
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
                  Navigator.pushNamed(context, '/adminDonationScreen');
                },
                child: singleCard(Icons.list_alt_rounded, 'Donation Made'),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/adminRequestMade');
                },
                child: singleCard(Icons.list, 'Request Made'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
