import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_waste_management_system/screens/admin/admin_panel.dart';
import 'package:food_waste_management_system/screens/donar/donar_dashboard_screen.dart';

import 'package:food_waste_management_system/utils/methods.dart';
import 'package:food_waste_management_system/widgets/custom_wigets.dart';
import 'package:food_waste_management_system/widgets/dialog_box.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/styles.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key, required this.userId}) : super(key: key);

  String userId;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController fullNameCon = TextEditingController(text: "");
  TextEditingController addressCon = TextEditingController();
  TextEditingController mobileCon = TextEditingController();

  TextEditingController cityCon = TextEditingController();

  Uint8List? _image;
  bool saveUpdate = false;

  //user profile data get and set varibale
  Map? listData;
  String? pGetImageUrl;
  String? pMobileNumber;
  String? pFullName;
  String? pAddress;
  String? pUser;
  String? pCity;

  //email,rool

  String? pEmailAddress;
  String? pRoolOfUser;

  void selectImage(ImageSource source) async {
    Uint8List im = await pickImageMethod(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  void dispose() {
    super.dispose();

    fullNameCon.dispose();
    addressCon.dispose();
    mobileCon.dispose();
    cityCon.dispose();
  }

  @override
  void initState() {
    super.initState();
    gUserData();

    if (pGet() != false) {
      pGet();
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserProfile(userId: widget.userId),
          ));
    }
  }

  pGet() async {
    var li = await retriveProfileData(widget.userId);

    print(li);

    if (li != null) {
      listData = li;

      pGetImageUrl = listData![0]['photoUrl'];
      pFullName = listData![0]['fullName'];
      pMobileNumber = listData![0]['number'];
      pAddress = listData![0]['address'];
      pUser = listData![0]['uid'];
      pCity = listData![0]['city'];
      if (listData != null) {
        fullNameCon.text = pFullName!;
        mobileCon.text = pMobileNumber!;
        addressCon.text = pAddress!;
        cityCon.text = pCity!;

        setState(() {
          saveUpdate = true;
        });
      }
    } else {
      print("unable data retrive");
    }
  }

  gUserData() async {
    var getUserInfoNGO = await getUsersInfo(getUserId());

    if (getUserInfoNGO != null) {
      pEmailAddress = getUserInfoNGO[0]['email'];

      pRoolOfUser = getUserInfoNGO[0]['rool'];
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: allbgcolor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text("Update Your profile."),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // SvgPicture.asset(
                      //   "assets/images/testimage.JPG",
                      //   color: primaryColor,
                      //   height: 64,
                      // ),
                      const SizedBox(
                        height: 30,
                      ),
                      Stack(
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 64,
                                  backgroundImage: MemoryImage(_image!),
                                )
                              : CircleAvatar(
                                  radius: 64,
                                  backgroundImage: pGetImageUrl != null
                                      ? NetworkImage(pGetImageUrl!)
                                      : NetworkImage(
                                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
                                ),
                          Positioned(
                            bottom: 8,
                            right: -1,
                            child: IconButton(
                              onPressed: () async {
                                selectImage(ImageSource.gallery);
                              },
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      // myFormField(
                      //   fullNameCon,
                      //   "Full Name",
                      //   TextInputType.name,

                      //   (valueKey) {
                      //     if (valueKey!.isEmpty || valueKey.length < 3) {
                      //       return "This field is required and cannot be empty";
                      //     }
                      //     return null;
                      //   },
                      // ),

                      TextFormField(
                        controller: fullNameCon,
                        decoration: const InputDecoration(
                            labelText: 'Full Name',
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required and cannot be empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // myFormField(
                      //   addressCon,
                      //   "Address",
                      //   TextInputType.name,
                      //   (valueKey) {
                      //     if (valueKey!.isEmpty || valueKey.length < 3) {
                      //       return "This field is required and cannot be empty";
                      //     }
                      //     return null;
                      //   },
                      // ),

                      TextFormField(
                        controller: addressCon,
                        decoration: const InputDecoration(
                            labelText: 'Address',
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required and cannot be empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: cityCon,
                        decoration: const InputDecoration(
                            labelText: 'City',
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required and cannot be empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      // myFormField(
                      //   mobileCon,
                      //   "Mobile Number",
                      //   TextInputType.name,
                      //   (valueKey) {
                      //     if (valueKey!.isEmpty || valueKey.length < 3) {
                      //       return "This field is required and cannot be empty";
                      //     }
                      //     return null;
                      //   },
                      // ),

                      TextFormField(
                        maxLength: 11,
                        controller: mobileCon,
                        decoration: const InputDecoration(
                            labelText: 'Mobile Number',
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder()),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.contains(RegExp(r'^[a-zA-Z\-]'))) {
                            return 'Use only numbers!';
                          }
                        },
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       CustomDialogBox(
                      //         title: "Are you Sure?",
                      //         contains: saveUpdate != true
                      //             ? "For Save"
                      //             : "For Update",
                      //         button1: () {
                      //           if (saveUpdate != true) {
                      //             userProfileSave(
                      //                 fullName: fullNameCon.text,
                      //                 address: addressCon.text,
                      //                 number: mobileCon.text,
                      //                 uid: widget.userId,
                      //                 file: _image!);
                      //           } else {
                      //             userProfileUpdate(
                      //                 fullName: fullNameCon.text,
                      //                 address: addressCon.text,
                      //                 number: mobileCon.text,
                      //                 uid: widget.userId,
                      //                 file: _image!);
                      //           }
                      //         },
                      //       );
                      //     });
                      //   },
                      //   child:
                      //       saveUpdate != true ? Text("Save") : Text("Update"),
                      // ),

                      ElevatedButton(
                          onPressed: () {
                            showMyDialog(context, "Are you Sure?",
                                saveUpdate != true ? "For Save" : "For Update",
                                () {
                              if (saveUpdate != true) {
                                userProfileSave(
                                        fullName: fullNameCon.text,
                                        address: addressCon.text,
                                        number: mobileCon.text,
                                        uid: widget.userId,
                                        city: cityCon.text,
                                        email: pEmailAddress,
                                        file: _image!)
                                    .then((value) {
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(getUserId())
                                      .get()
                                      .then(
                                    (value) {
                                      if (value.get('rool') == "ADMIN") {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminPanelScreen()),
                                        );
                                      } else {
                                        return Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DonarDashboardScreen(),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                });
                              } else {
                                userProfileUpdate(
                                  fullName: fullNameCon.text,
                                  address: addressCon.text,
                                  number: mobileCon.text,
                                  uid: widget.userId,
                                  city: cityCon.text,
                                  file: _image,
                                  img: pGetImageUrl,
                                ).then((value) => {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(getUserId())
                                          .get()
                                          .then(
                                        (value) {
                                          // if (value.get('rool') == 'Admin') {
                                          //   return AdminPanelScreen();
                                          // } else if (value.get('rool') == 'NGO') {
                                          //   return NgoDashboardScreen();
                                          // } else if (value.get('rool') == 'DONAR') {
                                          //   return DonarDashboardScreen();
                                          // }

                                          if (value.get('rool') == "ADMIN") {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdminPanelScreen()),
                                            );
                                          } else {
                                            return Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DonarDashboardScreen(),
                                                ));
                                          }
                                        },
                                      )
                                    });
                              }
                            });
                          },
                          child: saveUpdate != true
                              ? Text("Save")
                              : Text("Update")),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
