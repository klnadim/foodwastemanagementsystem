import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:food_waste_management_system/models/arguments_return.dart';

import 'package:food_waste_management_system/utils/methods.dart';
import 'package:food_waste_management_system/utils/styles.dart';
import 'package:food_waste_management_system/widgets/blinking_text.dart';
import 'package:food_waste_management_system/widgets/custom_snackbar.dart';
import 'package:food_waste_management_system/widgets/my_snack_bar.dart';
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
  DateTime selectedDate = DateTime.now();
  var _vDd = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

  final Stream<QuerySnapshot> _foodCollection = FirebaseFirestore.instance
      .collection('addFood')
      .where('date',
          isGreaterThanOrEqualTo:
              DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
      .snapshots();

  var foodCollection1 = FirebaseFirestore.instance
      .collection('addFood')
      .where('date',
          isGreaterThanOrEqualTo:
              DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
      .get()
      .then((value) {});

  bool foodDataAvailble = false;
  TextStyle myText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  Color myColor = Colors.green;

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
      floatingActionButton: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
            const Color(0xff6ae792),
          )),
          onPressed: () {
            getUserId() == null
                ? ScaffoldMessenger.of(context).showSnackBar(
                    snackBar("Please Login or SignUp!!", "Login", () {
                    Navigator.pushNamed(context, '/login');
                  }))
                : Navigator.pushNamed(context, '/addFood');
          },
          child: Text(
            "Donate Now",
            style: textstyle(),
          )),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff6ae792),
        actions: [
          InkWell(
            onTap: () {
              getUserId() == null
                  ? ScaffoldMessenger.of(context).showSnackBar(
                      snackBar("Please Login or SignUp!!", "Login", () {
                      Navigator.pushNamed(context, '/login');
                    }))
                  : basedOfLogin();
            },
            child: Icon(Icons.person_outline_rounded),
          ),
          TextButton(
              // ignore: unnecessary_null_comparison
              onPressed: () => getUserId() == null
                  ? Navigator.pushNamed(context, '/login')
                  : logOut(context),
              child: Text(getUserId() == null ? "Login" : "Logout"))
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
              });
            },
          ),
        ),
      ),
      body: Center(
        child: StreamBuilder(
          stream: _foodCollection,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Loading"));
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                String? vDate = data['date'];

                String _vTime = data['time'];
                DateTime _timeee = DateFormat.jm().parse(_vTime);
                var _t = DateFormat("HH:mm:ss").format(_timeee);

                var datTime = vDate! + " " + _t;

                DateTime dt1 = DateTime.parse(datTime);
                DateTime dt2 = selectedDate;

                if (dt1.compareTo(dt2) == 0) {
                  print("Both date time are at same moment.");
                }

                if (dt1.compareTo(dt2) < 0) {
                  print("DT1 is before DT2");
                }

                if (dt1.compareTo(dt2) > 0) {
                  print("DT1 is after DT2");
                }

                if (data['city'].toString().toLowerCase().startsWith(
                      searchName.toLowerCase(),
                    )) {
                  if (dt1.compareTo(dt2) > 0) {
                    return data['uid'] == getUserId()
                        ? Container()
                        : Card(
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
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(data['city']),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  BlinkingText(
                                      text: "$vDate" + " " + "$_vTime",
                                      style: TextStyle(
                                          color: Colors.white,
                                          backgroundColor: Colors.purple,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              trailing: data['status'] == 'confirmed'
                                  ? Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.green,
                                    )
                                  : InkWell(
                                      onTap: () {
                                        getUserId() == null
                                            ? CustomSnackBar.show(
                                                context: context,
                                                message: "Login First",
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white,
                                                duration: Duration(seconds: 5),
                                                snackbarFunctionLabel: "Login",
                                                snackbarFunction: () {
                                                  Navigator.pushNamed(
                                                      context, "/login");
                                                })
                                            : Navigator.pushNamed(context,
                                                DonatedFoodView.routeName,
                                                arguments: ScreenArguments(
                                                    document.id, data['uid']));
                                      },
                                      child: Icon(
                                          Icons.keyboard_arrow_right_rounded)),
                            ),
                          );
                  }
                }
                return Card(
                    // child: Text("ssss"),
                    );
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
