import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management_system/screens/login_screen.dart';
import 'package:image_picker/image_picker.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

getUserId() {
  return _firebaseAuth.currentUser!.uid;
}

pickImageMethod(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }

  print("No Image Selected");
}

Future<String> uploadToStorage(String childName, Uint8List file) async {
  Reference ref = _firebaseStorage
      .ref()
      .child(childName)
      .child(_firebaseAuth.currentUser!.uid);

  UploadTask uploadTask = ref.putData(file);

  TaskSnapshot snapshot = await uploadTask;

  String downloadlink = await snapshot.ref.getDownloadURL();
  return downloadlink;
}

Future<void> userProfileSave({
  required String fullName,
  required String address,
  required String number,
  required String uid,
  required Uint8List file,
}) async {
  var msg = "Some error occured";
  try {
    String imageUrl = await uploadToStorage("PorfilePic", file);

    await _firestore.collection('profileData').doc(uid).set({
      'fullName': fullName,
      'address': address,
      'number': number,
      'uid': uid,
      'photoUrl': imageUrl
    });

    msg = "Success";
  } catch (e) {
    msg = e.toString();
  }
}

Future retriveProfileData() async {
  // var _getdata = await FirebaseFirestore.instance
  //     .collection('profileData')
  //     .doc(_firebaseAuth.currentUser!.uid)
  //     .get().then((value) => null);

  // return getdata = FirebaseFirestore.instance
  //     .collection('profileData')
  //     .doc(_firebaseAuth.currentUser!.uid)
  //     .get()
  //     .then((DocumentSnapshot documentSnapshot) {
  //   if (documentSnapshot.exists) {
  //     return documentSnapshot.data();
  //   } else {
  //     print('User profile doesn\'t updated Yet/');
  //   }
  // });

  // var _data = _getdata.data();

  // Map<String, dynamic> map = {
  //   'fullname': _data!['fullName'],
  //   'address': _data['address'],
  //   'mobileNumber': _data['number'],
  //   'photoUrl': _data['photoUrl'],
  // };

  List getProfileData = [];
  try {
    final CollectionReference profileData =
        FirebaseFirestore.instance.collection('profileData');
    await profileData.get().then((QuerySnapshot) {
      for (var element in QuerySnapshot.docs) {
        getProfileData.add(element.data());
      }
    });
  } catch (e) {
    print(e.toString());
  }

  return getProfileData.asMap();
}

void logOut(BuildContext context) async {
  await _firebaseAuth.signOut();
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ));
}
