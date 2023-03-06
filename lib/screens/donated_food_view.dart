import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management_system/models/add_food_model.dart';
import 'package:food_waste_management_system/utils/styles.dart';

class DonatedFoodView extends StatefulWidget {
  final String id;

  const DonatedFoodView({Key? key, required this.id}) : super(key: key);

  @override
  State<DonatedFoodView> createState() => _DonatedFoodViewState();
}

class _DonatedFoodViewState extends State<DonatedFoodView> {
  bool dataAvailable = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.,
      appBar: AppBar(
        title: Text(widget.id),
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('addFood')
            .doc(widget.id)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text("EOrr");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          var fData = AddFoodModel.fromSnapshot(snapshot.data);
          print(fData.city);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  height: 150,
                  width: double.infinity,
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("For Image"),
                  ),
                ),
                Text(
                  fData.foodItems,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
                ),
                Row(
                  children: [
                    Text(
                      fData.foodValidation,
                    ),
                    Text("${fData.foodPerson}")
                  ],
                )
              ],
            ),
          );
        },
      ),
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
