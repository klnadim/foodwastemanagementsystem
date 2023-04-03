import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:food_waste_management_system/widgets/dialog_box.dart';

import '../../models/arguments_return.dart';
import '../../utils/methods.dart';
import '../../widgets/custom_snackbar.dart';

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

Map? listData;

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
    if (pGet() != false) {
      pGet();
    } else {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => UserProfile(userId: widget.userId),
      //     ));
    }
    super.initState();
  }

  gUserData() async {
    var getUserInfoNGO = await getUsersInfo(getUserId());

    if (getUserInfoNGO != null) {
      vEmail = getUserInfoNGO[0]['email'];
    }
  }

  pGet() async {
    var li = await retriveProfileData(getUserId());

    print(li);

    if (li != null) {
      listData = li;

      vProfilePic = listData![0]['photoUrl'];
      vUserName = listData![0]['fullName'];
      vMobile = listData![0]['number'];
      vAddress = listData![0]['address'];

      vCity = listData![0]['city'];
    }
  }

  bool dataAvailable = false;

  @override
  Widget build(BuildContext context) {
    // FirebaseFirestore.instance
    //     .collection('addFood')
    //     .where('uid', isEqualTo: getUserId())
    //     .get()
    //     .then((value) {
    //   if (value.docs.isNotEmpty) {
    //     setState(() {
    //       isDonar = true;
    //     });
    //   } else {
    //     setState(() {
    //       isDonar = false;
    //     });
    //   }
    // });

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
                                            Text(
                                              data['foodValidation'],
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
                      child: args.uid == getUserId()!
                          ? Container(
                              // child: Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceAround,
                              //   children: [
                              //     ElevatedButton(
                              //         onPressed: () {}, child: Text("Confirm")),
                              //     ElevatedButton(
                              //         onPressed: () {}, child: Text("Reject")),
                              //   ],
                              // ),
                              )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80.0)),
                                elevation: 0.0,
                                padding: EdgeInsets.all(0.0),
                              ),
                              onPressed: () {
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
                                          status: '')
                                      .then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        snackBar(
                                            "Your Request Successfully Send!!",
                                            "",
                                            () {}));
                                    Navigator.pushNamed(context, '/home');
                                  });
                                });
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
                    // ElevatedButton(
                    //     onPressed: () {
                    //       var ffff = checkProfileComplete();
                    //       print(ffff);

                    //       if (checkProfileComplete() == true) {
                    //         AlertDialog(
                    //           content:
                    //               Text("Successfully Your Request Added.."),
                    //         );
                    //       } else if (checkProfileComplete() == false) {
                    //         ScaffoldMessenger.of(context).showSnackBar(
                    //           snackBar(
                    //               "You does not Request Right now.Please complete your profile First.!",
                    //               "Profile", () {
                    //             Navigator.pushNamed(context, '/profile');
                    //           }),
                    //         );
                    //       }
                    //     },
                    //     child: Text("Check"))
                  ],
                ),
              );
            }

            // Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Container(
            //       margin: EdgeInsets.all(10),
            //       height: 150,
            //       width: double.infinity,
            //       // color: Colors.green,
            //       child: PageView.builder(
            //         itemCount: images.length,
            //         pageSnapping: true,
            //         itemBuilder: (context, pagePosition) {
            //           return

            //           Container(
            //               margin: EdgeInsets.all(10),
            //               child: Image.network(
            //                 images[pagePosition],
            //                 fit: BoxFit.fill,
            //               ));
            //         },
            //       ),
            //     ),
            //     Text(
            //       data['foodItems'],
            //       style: TextStyle(
            //           fontFamily: 'Lato',
            //           fontWeight: FontWeight.w400,
            //           fontSize: 20),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(15.0),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text(
            //             'Persons: ${data['foodPerson'].toString()}',
            //             style: TextStyle(
            //                 fontFamily: 'Lato',
            //                 fontWeight: FontWeight.w400,
            //                 fontSize: 20),
            //           ),
            //           Text(
            //             'Valid For: ${data['foodValidation']}',
            //             style: TextStyle(
            //                 fontFamily: 'Lato',
            //                 fontWeight: FontWeight.w400,
            //                 fontSize: 20),
            //           ),
            //         ],
            //       ),
            //     ),
            //     Text(
            //       data['description'],
            //       style: TextStyle(fontFamily: 'Lato', fontSize: 18),
            //     ),
            //     SizedBox(
            //       height: 8,
            //     ),
            //     Text(
            //       data['city'],
            //       style: TextStyle(fontFamily: 'Lato', fontSize: 18),
            //     ),
            //     SizedBox(
            //       height: 8,
            //     ),
            //     Text(
            //       data['contactNumber'],
            //       style: TextStyle(fontFamily: 'Lato', fontSize: 18),
            //     ),
            //   ],
            // );

            return Text("loading");
          },
        )

        // StreamBuilder(
        //   stream: FirebaseFirestore.instance
        //       .collection('addFood')
        //       .doc(widget.id)
        //       .get(),
        //   builder: (context, AsyncSnapshot snapshot) {
        //     if (snapshot.hasError) {
        //       return Text("EOrr");
        //     }
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return CircularProgressIndicator();
        //     }

        //     // var fData = AddFoodModel.fromSnapshot(snapshot.data);
        //     // var getImages = fData.files;
        //     // print(getImages);

        //     // final DateTime dateTime = fData.dateTime.toLocal();
        //     // print(dateTime);

        //     return Padding(
        //       padding: const EdgeInsets.all(8.0),

        // body: FutureBuilder(
        //   future: FirebaseFirestore.instance
        //       .collection('addFood')
        //       .doc(widget.id)
        //       .get(),
        //   builder: (context, AsyncSnapshot snapshot) {
        //     if (snapshot.hasError) {
        //       print("Error");
        //     }
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }

        //     final data = snapshot.data;

        //     // var vData  AddFoodModel.fromDocument(data);

        //     return Text("data");
        //     // return Column(
        //     //   children: [
        //     //     Padding(
        //     //       padding: const EdgeInsets.all(8.0),
        //     //       child: Container(
        //     //         color: Colors.brown,
        //     //         height: 150,
        //     //         width: double.infinity,
        //     //         child: Center(child: Text("Photos SHow")),
        //     //       ),
        //     //     ),
        //     //     Padding(
        //     //       padding: const EdgeInsets.all(8.0),
        //     //       child: Column(
        //     //         children: [
        //     //           Row(
        //     //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     //             children: [
        //     //               Row(
        //     //                 children: [
        //     //                   Card(
        //     //                     shadowColor: Colors.black,
        //     //                     color: Colors.grey,
        //     //                     child: Padding(
        //     //                       padding: EdgeInsets.all(5.0),
        //     //                       child: Text("Items:"),
        //     //                     ),
        //     //                   ),
        //     //                   Card(
        //     //                     child: Padding(
        //     //                       padding: const EdgeInsets.all(5.0),
        //     //                       child: Text(vData.foodItems),
        //     //                     ),
        //     //                   ),
        //     //                 ],
        //     //               ),
        //     //               Row(
        //     //                 children: [
        //     //                   Card(
        //     //                     shadowColor: Colors.black,
        //     //                     color: Colors.grey,
        //     //                     child: Padding(
        //     //                       padding: EdgeInsets.all(5.0),
        //     //                       child: Text("Desciption:"),
        //     //                     ),
        //     //                   ),
        //     //                   Card(
        //     //                     child: Padding(
        //     //                       padding: const EdgeInsets.all(5.0),
        //     //                       child: Text(vData.description),
        //     //                     ),
        //     //                   ),
        //     //                 ],
        //     //               ),
        //     //             ],
        //     //           ),
        //     //           Row(
        //     //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     //             children: [
        //     //               Row(
        //     //                 children: [
        //     //                   Card(
        //     //                     shadowColor: Colors.black,
        //     //                     color: Colors.grey,
        //     //                     child: Padding(
        //     //                       padding: EdgeInsets.all(5.0),
        //     //                       child: Text("Address:"),
        //     //                     ),
        //     //                   ),
        //     //                   Card(
        //     //                     child: Padding(
        //     //                       padding: const EdgeInsets.all(5.0),
        //     //                       child: Text(vData.address),
        //     //                     ),
        //     //                   ),
        //     //                 ],
        //     //               ),
        //     //               Row(
        //     //                 children: [
        //     //                   Card(
        //     //                     shadowColor: Colors.black,
        //     //                     color: Colors.grey,
        //     //                     child: Padding(
        //     //                       padding: EdgeInsets.all(5.0),
        //     //                       child: Text("City:"),
        //     //                     ),
        //     //                   ),
        //     //                   Card(
        //     //                     child: Padding(
        //     //                       padding: const EdgeInsets.all(5.0),
        //     //                       child: Text(vData.city),
        //     //                     ),
        //     //                   ),
        //     //                 ],
        //     //               ),
        //     //             ],
        //     //           ),
        //     //           Row(
        //     //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     //             children: [
        //     //               Row(
        //     //                 children: [
        //     //                   Card(
        //     //                     shadowColor: Colors.black,
        //     //                     color: Colors.grey,
        //     //                     child: Padding(
        //     //                       padding: EdgeInsets.all(5.0),
        //     //                       child: Text("Validity:"),
        //     //                     ),
        //     //                   ),
        //     //                   Card(
        //     //                     child: Padding(
        //     //                       padding: const EdgeInsets.all(5.0),
        //     //                       child: Text(vData.foodValidation),
        //     //                     ),
        //     //                   ),
        //     //                 ],
        //     //               ),
        //     //               Row(
        //     //                 children: [
        //     //                   Card(
        //     //                     shadowColor: Colors.black,
        //     //                     color: Colors.grey,
        //     //                     child: Padding(
        //     //                       padding: EdgeInsets.all(5.0),
        //     //                       child: Text("Persons:"),
        //     //                     ),
        //     //                   ),
        //     //                   Card(
        //     //                     child: Padding(
        //     //                       padding: const EdgeInsets.all(5.0),
        //     //                       child: Text(vData.foodPerson.toString()),
        //     //                     ),
        //     //                   ),
        //     //                 ],
        //     //               ),
        //     //             ],
        //     //           ),
        //     //           Row(
        //     //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     //             children: [
        //     //               Row(
        //     //                 children: [
        //     //                   Card(
        //     //                     shadowColor: Colors.black,
        //     //                     color: Colors.grey,
        //     //                     child: Padding(
        //     //                       padding: EdgeInsets.all(5.0),
        //     //                       child: Text("Contact:"),
        //     //                     ),
        //     //                   ),
        //     //                   Card(
        //     //                     child: Padding(
        //     //                       padding: const EdgeInsets.all(5.0),
        //     //                       child: Text(vData.contactNumber),
        //     //                     ),
        //     //                   ),
        //     //                 ],
        //     //               ),
        //     //             ],
        //     //           ),
        //     //         ],
        //     //       ),
        //     //     ),
        //     //   ],
        //     // );
        //   },
        // ),
        );
  }
}
