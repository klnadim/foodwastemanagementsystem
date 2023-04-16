import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:food_waste_management_system/screens/home_screen.dart';

import 'package:image_picker/image_picker.dart';

import '../screens/login_signup/login_screen.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

//Get request exists or not

//Request data retrive from firebase

Future getRequestData() async {
  List requestData = [];
  try {
    final _requestData = _firestore.collection('foodRequest').doc().get();

    await _requestData.then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        requestData.add(documentSnapshot.data());
      } else {
        print('Document does not exist on the database');
      }
    });
  } catch (e) {
    print(e.toString());
  }

  return requestData;
}

//get user email and rool from firebase
Future getUsersInfo(String pUserId) async {
  List getUserData = [];
  try {
    final _user = _firestore.collection('users').doc(pUserId).get();

    await _user.then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        getUserData.add(documentSnapshot.data());
      } else {
        print('Document does not exist on the database');
      }
    });
  } catch (e) {
    print(e.toString());
  }

  return getUserData;
}

//Profile completion check

// checkProfileComplete() {
//   var profileData = FirebaseFirestore.instance.collection('profileData');

//   var ff = profileData.count().query;

//   // if (profileData.doc(FirebaseAuth.instance.currentUser!.uid).id.isNotEmpty) {
//   //   return true;
//   // } else {
//   //   return false;
//   // }

//   return ff;
// }

//Confrimation

Future<void> updateConInAddFoodStatus({
  required String status,
  required String addFoodDocId,
}) {
  CollectionReference addFood =
      FirebaseFirestore.instance.collection('addFood');

  return addFood.doc(addFoodDocId).update({
    'status': status,
  }).catchError((error) => print("Failed to : $error"));
}

Future<void> confirmationFood({
  required String requestUid,
  required String donatedUid,
  required String foodDocId,
  required DateTime dateTime,
  String? status,
}) {
  CollectionReference confrimFood =
      FirebaseFirestore.instance.collection('confirmationFoods');

  return confrimFood
      .doc()
      .set({
        'donatedUid': donatedUid,
        'requestUid': requestUid,
        'foodDocId': foodDocId,
        'dateTime': dateTime,
        'status': status
      })
      .then((value) => print("confirmed"))
      .catchError((error) => print("Failed to : $error"));
}

//Rejection
Future<void> rejectionFood({
  required String requestUid,
  required String donatedUid,
  required String foodDocId,
  required String rejectReason,
  required DateTime dateTime,
}) {
  CollectionReference rejectFoods =
      FirebaseFirestore.instance.collection('rejectFoods');

  return rejectFoods
      .doc()
      .set({
        'donatedUid': donatedUid,
        'requestUid': requestUid,
        'foodDocId': foodDocId,
        'rejectReason': rejectReason,
        'dateTime': dateTime,
      })
      .then((value) => print("Request Successfully"))
      .catchError((error) => print("Failed to : $error"));
}

//Request button in Food Donar View

Future<void> requestForFood({
  required String requestUid,
  required String donatedUid,
  required String docId,
  required DateTime dateTime,
  required String profilePicLink,
  required String emailAddress,
  required String mobileNumber,
  required String userName,
  required String date,
  required String time,
  String? city,
  String? status,
}) {
  CollectionReference foodRequest =
      FirebaseFirestore.instance.collection('foodRequest');

  return foodRequest
      .doc()
      .set({
        'donatedUid': donatedUid,
        'requestUid': requestUid,
        'documentId': docId,
        'dateTime': dateTime,
        'email': emailAddress,
        'profilePic': profilePicLink,
        'mobileNumber': mobileNumber,
        'city': city,
        'status': status
      })
      .then((value) => print("Request Successfully"))
      .catchError((error) => print("Failed to : $error"));
}

//Fetch all data from firebase firestore addFood document

Stream<dynamic> getFoodData() {
  Stream documentStream = FirebaseFirestore.instance
      .collection('addFood')
      .doc(_firebaseAuth.currentUser!.uid)
      .snapshots();

  return documentStream;
}

loginPage(BuildContext context) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ));
}

getUserId() {
  var userID = _firebaseAuth.currentUser?.uid;
  return userID ?? '';
}

Future<String> uploadToStorageMultiImg(String childName, XFile images) async {
  Reference ref = _firebaseStorage.ref().child(childName).child(images.name);

  UploadTask uploadTask = ref.putFile(File(images.path));

  // TaskSnapshot snapshot = await uploadTask;
  // await uploadTask.whenComplete(() => print(ref.getDownloadURL()));
  TaskSnapshot snapshot = await uploadTask;
  String downloadlink = await snapshot.ref.getDownloadURL();

  return downloadlink;
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
  required String city,
  String? email,
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
      'city': city,
      'email': email,
      'photoUrl': imageUrl
    });

    msg = "Success";
  } catch (e) {
    msg = e.toString();
  }
}

Future<void> userProfileUpdate({
  required String fullName,
  required String address,
  required String number,
  required String uid,
  required String city,
  Uint8List? file,
  String? img,
}) async {
// CollectionReference users = FirebaseFirestore.instance.collection('users');

// Future<void> updateUser() {
//   return users
//     .doc('ABC123')
//     .update({'info.address.location': GeoPoint(53.483959, -2.244644)})
//     .then((value) => print("User Updated"))
//     .catchError((error) => print("Failed to update user: $error"));
// }

  var msg = "Some error occured";
  try {
    String imageUrl;

    if (img != null && file != null) {
      imageUrl = await uploadToStorage("PorfilePic", file);
    } else {
      imageUrl = img!;
    }

    await _firestore.collection('profileData').doc(uid).update({
      'fullName': fullName,
      'address': address,
      'number': number,
      'uid': uid,
      'city': city,
      'photoUrl': imageUrl
    });

    msg = "Success";
  } catch (e) {
    msg = e.toString();
  }
}

Future retriveProfileData(String pUserId) async {
  List getProfileData = [];
  try {
    final CollectionReference profileData =
        FirebaseFirestore.instance.collection('profileData');

    await profileData
        .where('uid', isEqualTo: pUserId)
        .get()
        .then((QuerySnapshot) {
      for (var element in QuerySnapshot.docs) {
        getProfileData.add(element.data());
      }
    });
  } catch (e) {
    print(e.toString());
  }

  return getProfileData.asMap();
}

Future<void> addFoodSubmit(
  String foodItems,
  String description,
  String address,
  String city,
  String foodValidation,
  int foodPerson,
  String contactNumber,
  // String publicOrPrivate,
  String date,
  String time,
  String convertTime,
  List<String> imagesUrls,
  String uid,
  String status,
) async {
  var msg = "Some error occured";

  try {
    await _firestore.collection('addFood').doc().set({
      'foodItems': foodItems,
      'description': description,
      'address': address,
      'city': city,
      'foodValidation': foodValidation,
      'foodPerson': foodPerson,
      'contactNumber': contactNumber,
      // 'publicOrPrivate': publicOrPrivate,
      'date': date,
      'time': time,
      'imagesUrls': imagesUrls,
      'uid': uid,
      'convertTime': convertTime,
      'status': status
    });
  } catch (e) {
    msg = e.toString();
  }
}

void logOut(BuildContext context) async {
  await _firebaseAuth.signOut();
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));
}
