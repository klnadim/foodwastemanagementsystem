import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  Uint8List? _image;
  bool saveUpdate = false;

  //user profile data get and set varibale
  Map? listData;
  String? pGetImageUrl;
  String? pMobileNumber;
  String? pFullName;
  String? pAddress;
  String? pUser;

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
  }

  @override
  void initState() {
    super.initState();

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

      if (listData != null) {
        fullNameCon.text = pFullName!;
        mobileCon.text = pMobileNumber!;
        addressCon.text = pAddress!;

        setState(() {
          saveUpdate = true;
        });
      }
    } else {
      print("unable data retrive");
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
                      myFormField(
                        fullNameCon,
                        "Full Name",
                        TextInputType.name,
                        (valueKey) {
                          if (valueKey!.isEmpty || valueKey.length < 3) {
                            return "This field is required and cannot be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      myFormField(
                        addressCon,
                        "Address",
                        TextInputType.name,
                        (valueKey) {
                          if (valueKey!.isEmpty || valueKey.length < 3) {
                            return "This field is required and cannot be empty";
                          }
                          return null;
                        },
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      myFormField(
                        mobileCon,
                        "Mobile Number",
                        TextInputType.name,
                        (valueKey) {
                          if (valueKey!.isEmpty || valueKey.length < 3) {
                            return "This field is required and cannot be empty";
                          }
                          return null;
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
                                    file: _image!);
                              } else {
                                userProfileUpdate(
                                    fullName: fullNameCon.text,
                                    address: addressCon.text,
                                    number: mobileCon.text,
                                    uid: widget.userId,
                                    file: _image!);
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
