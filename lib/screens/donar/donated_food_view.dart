import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:food_waste_management_system/widgets/dialog_box.dart';
import 'package:food_waste_management_system/widgets/my_snack_bar.dart';

import '../../models/arguments_return.dart';
import '../../utils/methods.dart';
import '../../widgets/blinking_text.dart';
import '../../widgets/custom_snackbar.dart';
import '../user_profile.dart';

class DonatedFoodView extends StatefulWidget {
  // final String id;

  const DonatedFoodView({
    Key? key,
  }) : super(key: key);
  static const routeName = '/donatedFoodView';

  @override
  State<DonatedFoodView> createState() => _DonatedFoodViewState();
}

bool isDonar = false;
bool alreadyRequestOrNot = false;

Map listData = {};

String? vEmail;
String? vProfilePic;
String? vAddress;
String? vCity;
String? vMobile;
String? vStatus;
String? vUserName;

vUserInfo() {
  getUsersInfo(getUserId());
}

class _DonatedFoodViewState extends State<DonatedFoodView> {
  @override
  void initState() {
    gUserData();
    pGet();

    super.initState();
  }

  gUserData() async {
    var getUserInfoNGO = await getUsersInfo(getUserId());

    if (getUserInfoNGO != null) {
      vEmail = getUserInfoNGO[0]['email'];
    }
  }

  pGet() async {
    Map li = await retriveProfileData(getUserId());

    listData = li;
    print(listData.isEmpty);
    if (listData.isNotEmpty) {
      // listData = li;
      vProfilePic = listData[0]['photoUrl'];
      vUserName = listData[0]['fullName'];
      vMobile = listData[0]['number'];
      vAddress = listData[0]['address'];

      vCity = listData[0]['city'];
    }
    return listData;
  }

  checkAlreadyRequested(args) async {
    await FirebaseFirestore.instance
        .collection('foodRequest')
        .where('requestUid', isEqualTo: getUserId())
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach(
        (element) {
          // print(element['requestUid']);
          if (element['documentId'] == args.documentId) {
            alreadyRequestOrNot = true;
          } else {
            // setState(() {});
            alreadyRequestOrNot = false;
          }
        },
      );
      return alreadyRequestOrNot;
    });
  }

  bool dataAvailable = false;

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('addFood');

    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 220, 238, 192),
        appBar: AppBar(
          title: Text("Food Details"),
          centerTitle: true,
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: users.doc(args.documentId).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;

              List images = data['imagesUrls'];

              String? vDate = data['date'];

              String _vTime = data['time'];

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(255, 193, 240, 194),
                                  Color.fromARGB(255, 42, 76, 2)
                                ])),
                        child: Container(
                          width: double.infinity,
                          height: 380.0,
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 200,
                                width: double.infinity,
                                child: PageView.builder(
                                  itemCount: images.length,
                                  pageSnapping: true,
                                  itemBuilder: (context, pagePosition) {
                                    return Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white, width: 4),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        margin: EdgeInsets.all(10),
                                        child: Image.network(
                                          images[pagePosition],
                                          fit: BoxFit.fill,
                                        ));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                data['foodItems'],
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Card(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 5.0),
                                clipBehavior: Clip.antiAlias,
                                color: Colors.white,
                                elevation: 5.0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 22.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              "Persons",
                                              style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              data['foodPerson'].toString(),
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.pinkAccent,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Text(
                                              "Valid For",
                                              style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            BlinkingText(
                                                text: "$vDate" +
                                                    " " +
                                                    "  $_vTime",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    backgroundColor:
                                                        Colors.purple,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            // Text(
                                            //   "[$vDate" + " " + "$_vTime ]",
                                            //   style: TextStyle(
                                            //     fontSize: 15.0,
                                            //     color: Colors.pinkAccent,
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "City",
                                              style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              data['city'],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.pinkAccent,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Description:",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontStyle: FontStyle.normal,
                              fontSize: 25.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          data['description'],
                          // "thssssssssssssssssssnnnnnnnnnnnnnnnnnnnnn",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            letterSpacing: 2.0,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Number:",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontStyle: FontStyle.normal,
                              fontSize: 25.0),
                        ),
                        Text(
                          data['contactNumber'],
                          style: TextStyle(
                            fontSize: 22.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      width: 300.00,
                      child: data['uid'] == getUserId()
                          ? Container()
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80.0)),
                                elevation: 0.0,
                                padding: EdgeInsets.all(0.0),
                              ),
                              onPressed: () {
                                // print(checkAlreadyRequested(args));

                                if (listData.isEmpty) {
                                  // print(true);
                                  CustomSnackBar.show(
                                      context: context,
                                      message:
                                          "Please First complete your Profile",
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      duration: Duration(seconds: 7),
                                      snackbarFunctionLabel: "Profile",
                                      snackbarFunction: () {
                                        Navigator.pushNamed(
                                            context, '/profile');
                                      });
                                }

                                checkAlreadyRequested(args);

                                if (alreadyRequestOrNot == true) {
                                  CustomSnackBar.show(
                                      context: context,
                                      message:
                                          "Already Requested For This Food.",
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      duration: Duration(seconds: 5),
                                      snackbarFunction: () {},
                                      snackbarFunctionLabel: "");
                                } else {
                                  showMyDialog(context, "Request!!!!",
                                      "Are you sure to Request?", () async {
                                    await requestForFood(
                                            requestUid: getUserId(),
                                            donatedUid: data['uid'],
                                            docId: args.documentId,
                                            dateTime: DateTime.now(),
                                            emailAddress: vEmail!,
                                            mobileNumber: vMobile!,
                                            profilePicLink: vProfilePic!,
                                            city: vCity,
                                            userName: vUserName!,
                                            date: data['date'],
                                            time: data['time'],
                                            foodItems: data['foodItems'],
                                            donnarMobileNumber:
                                                data['contactNumber'],
                                            status: '')
                                        .then((value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar(
                                              "Your Request Successfully Send!!",
                                              "",
                                              () {}));
                                      Navigator.pushNamed(context, '/home');
                                    });
                                  });
                                }
                              },
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                      colors: const [
                                        Color.fromARGB(68, 238, 190, 102),
                                        Color.fromARGB(255, 149, 204, 66)
                                      ]),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth: 300.0, minHeight: 50.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Request",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 26.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              );
            }

            return Text("loading");
          },
        ));
  }
}
