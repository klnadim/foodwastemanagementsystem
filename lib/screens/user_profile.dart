import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_waste_management_system/utils/methods.dart';
import 'package:food_waste_management_system/widgets/custom_wigets.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/styles.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key, required this.userId}) : super(key: key);

  String userId;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final fullNameCon = TextEditingController(text: "init");
  TextEditingController addressCon = TextEditingController();
  TextEditingController mobileCon = TextEditingController();

  TextEditingController testCon = TextEditingController();

  Uint8List? _image;

  //user profile data get and set varibale
  Map? listData;
  String? pGetImageUrl;
  String? pMobileNumber;
  String? pFullName;
  String? pAddress;

  void selectImage(ImageSource source) async {
    Uint8List im = await pickImageMethod(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    fullNameCon.dispose();
    addressCon.dispose();
    mobileCon.dispose();
  }

  @override
  void initState() {
    super.initState();
    // pGet();
  }

  pGet() async {
    var li = await retriveProfileData();

    if (li != null) {
      setState(() {
        listData = li;

        pGetImageUrl = listData![0]['photoUrl'];
        pFullName = listData![0]['fullName'];
        pMobileNumber = listData![0]['number'];
        pAddress = listData![0]['address'];
        print(listData);
      });
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
                        pFullName ?? "",
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
                      TextFormField(
                        initialValue: pFullName ?? "",
                        decoration: InputDecoration(
                            labelText: "Full Name",
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder()),
                      )

                      // MyFormField(
                      //   pAddress ?? "",
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
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // MyFormField(
                      //   pMobileNumber ?? "",
                      //   mobileCon,
                      //   "Mobile Number",
                      //   TextInputType.number,
                      //   (valueKey) {
                      //     if (valueKey!.isEmpty || valueKey.length < 3) {
                      //       return "This field is required and cannot be empty";
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       setState(() {
                      //         userProfileSave(
                      //             fullName: fullNameCon.text,
                      //             address: addressCon.text,
                      //             number: mobileCon.text,
                      //             uid: widget.userId,
                      //             file: _image!);
                      //       });
                      //     },
                      //     child: Text("Save"))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
