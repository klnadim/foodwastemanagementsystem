import 'package:cloud_firestore/cloud_firestore.dart';

class AddFoodModel {
  String foodItems;
  String description;
  String address;
  String city;
  String foodValidation;
  int foodPerson;
  String contactNumber;
  String uid;

  AddFoodModel(
      {required this.foodItems,
      required this.description,
      required this.address,
      required this.city,
      required this.foodValidation,
      required this.foodPerson,
      required this.contactNumber,
      required this.uid});

  factory AddFoodModel.fromDocument(DocumentSnapshot doc) {
    return AddFoodModel(
        foodItems: doc['fooditems'],
        description: doc['description'],
        address: doc['address'],
        city: doc['city'],
        foodValidation: doc['foodValidation'],
        foodPerson: doc['foodperson'],
        contactNumber: doc['contact'],
        uid: doc['uid']);
  }
}
