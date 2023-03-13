import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddFoodModel {
  String foodItems;
  String description;
  String address;
  String city;

  String foodValidation;
  int? foodPerson;
  String contactNumber;
  String publicOrPrivate;
  DateTime dateTime;
  String uid;
  List<XFile>? files;

  AddFoodModel({
    required this.foodItems,
    required this.description,
    required this.address,
    required this.city,
    required this.foodValidation,
    required this.foodPerson,
    required this.contactNumber,
    required this.publicOrPrivate,
    required this.dateTime,
    required this.uid,
    this.files,
  });

  // factory AddFoodModel.fromDocument(DocumentSnapshot doc) {
  //   return AddFoodModel(
  //       foodItems: doc['fooditems'],
  //       description: doc['description'],
  //       address: doc['address'],
  //       city: doc['city'],
  //       foodValidation: doc['foodValidation'],
  //       foodPerson: doc['foodperson'],
  //       contactNumber: doc['contact'],
  //       files: doc['images'],
  //       // dateTime: doc['dateTime'],
  //       uid: doc['uid']);
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     "foodItems": foodItems,
  //     "description": description,
  //     "address": address,
  //     "city": city,
  //     "foodValidation": foodValidation,
  //     "foodPerson": foodPerson,
  //     "contactNumber": contactNumber,
  //     "files": files,
  //     // "dateTime": dateTime,
  //     "uid": uid,
  //   };
  // }

  // factory AddFoodModel.fromSnapshot(
  //     DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
  //   final data = documentSnapshot.data()!;

  //   // var timeStamp = data['timeDate'];

  //   DateTime updateDateTime = DateTime.fromMillisecondsSinceEpoch(
  //       data['timeDate'].millisecondsSinceEpoch);

  //   var imageLink = List.castFrom(data['imagesUrls']);

  //   return AddFoodModel(
  //       foodItems: data['foodItems'],
  //       description: data['description'],
  //       address: data['address'],
  //       city: data['city'],
  //       foodValidation: data['foodValidation'],
  //       foodPerson: data['foodPerson'],
  //       contactNumber: data['contactNumber'],
  //       files: XFile(imageLink.path),
  //       publicOrPrivate: data['publicOrPrivate'],
  //       dateTime: updateDateTime,
  //       uid: data['uid']);
  // }
}
