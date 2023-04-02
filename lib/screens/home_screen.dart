import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:food_waste_management_system/models/arguments_return.dart';

import 'package:food_waste_management_system/screens/ngo/ngo_dashboard.dart';
import 'package:food_waste_management_system/utils/methods.dart';
import 'package:food_waste_management_system/utils/styles.dart';
import 'package:intl/intl.dart';

import 'admin/admin_panel.dart';
import 'donar/donated_food_view.dart';
import 'login_signup/login_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Stream<DocumentSnapshot<Map<String, dynamic>>> documentStream =
  //     FirebaseFirestore.instance
  //         .collection('addFood')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .snapshots();.

  // final Stream<QuerySnapshot> _usersStream =
  //     FirebaseFirestore.instance.collection('addFood').snapshots();

  final Stream<QuerySnapshot> _foodCollection = FirebaseFirestore.instance
      .collection('addFood')
      // .where('publicOrPrivate', isEqualTo: 'public')
      .snapshots();
  bool foodDataAvailble = false;
  TextStyle myText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  Color myColor = Colors.green;
  DateTime selectedDate = DateTime.now();

  void checkLoginOrNot() {
    if (getUserId() == '') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    }
  }

//for connection check

//end con
  @override
  void initState() {
    // checkLoginOrNot();
    super.initState();

    // Future.delayed(Duration(seconds: 3));
    // var vUserId = user!.uid;
    // if (vUserId.isEmpty) {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => LoginScreen(),
    //       ));
    // } else {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => HomeScreen(),
    //       ));
    // }
  }

  String searchName = "";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // DataColumn columnsName = [];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff6ae792),
          onPressed: () {
            getUserId() == '' ? "" : Navigator.pushNamed(context, '/addFood');
          },
          child: Text(
            "D",
            style: textstyle(),
          )),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff6ae792),
        actions: [
          InkWell(
            onTap: () => basedOfLogin(),
            child: Icon(Icons.person_outline_rounded),
          ),
          TextButton(
              // ignore: unnecessary_null_comparison
              onPressed: () => logOut(context),
              child: Text(getUserId() == '' ? "Login" : "Logout"))
        ],
        title: Card(
          child: TextField(
            decoration: InputDecoration(
              label: Text("City"),
              prefixIcon: Icon(Icons.search),
              hintText: 'Search',
            ),
            onChanged: (val) {
              setState(() {
                searchName = val;
                print(searchName);
              });
            },
          ),
        ),
      ),
      body: Center(
        child:
            // mainAxisAlignment: MainAxisAlignment.center,

            // Text("SignIn with \n ${getUserId() ?? 'null'}"),
            // TextButton(
            //     onPressed: () {
            //       basedOfLogin();
            //     },
            //     child: Text("Profile")),

            // color: Colors.cyan,

            StreamBuilder(
          stream: _foodCollection,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                // String? vDate = data['date'];
                // print(vDate);

                // String? nowDate = DateFormat('yyyy-MM-dd').format(selectedDate);
                // print(nowDate);

                // if (vDate == null) {
                //   return Text("erorr");
                // } else {
                //   print(DateTime.parse(vDate));
                // }

                if (data['city'].toString().toLowerCase().startsWith(
                      searchName.toLowerCase(),
                    )) {
                  return Card(
                    elevation: 6,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30.0,
                        backgroundColor: Colors.transparent,
                        // backgroundColor: Colors.purple,
                        backgroundImage: NetworkImage(
                          data['imagesUrls'][0],
                        ),
                      ),
                      title: Text(data['foodItems']),
                      subtitle: Text(data['city']),
                      trailing: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, DonatedFoodView.routeName,
                                arguments:
                                    ScreenArguments(document.id, data['uid']));
                          },
                          child: Icon(Icons.keyboard_arrow_right_rounded)),
                    ),
                  );
                }
                return Card();
              }).toList(),
            );
          },
        ),
        //
      ),
    );
  }

  void basedOfLogin() {
    // print(user!.uid);
    if (getUserId() == '') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      FirebaseFirestore.instance
          .collection('users')
          .doc(getUserId())
          .get()
          .then(
        (value) {
          if (value.get('rool') == "ADMIN") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AdminPanelScreen()),
            );
          } else {
            return Navigator.pushNamed(context, '/donarDashboard');
          }
        },
      );
    }
  }
}
