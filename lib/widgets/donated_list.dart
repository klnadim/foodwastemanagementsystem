import 'package:flutter/material.dart';
import 'package:food_waste_management_system/utils/methods.dart';

import '../models/arguments_return.dart';
import '../screens/donated_food_view.dart';

class DonatedList extends StatefulWidget {
  const DonatedList({Key? key}) : super(key: key);

  @override
  State<DonatedList> createState() => _DonatedListState();
}

String searchName = "";

class _DonatedListState extends State<DonatedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff6ae792),
        title: Card(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search',
            ),
            onChanged: (val) {
              setState(() {
                searchName = val;
                print(searchName);
              });
            },
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(onPressed: () {}, child: Text("CLickkk")),
        // child: StreamBuilder(
        //   stream: _foodCollection,
        //   builder:
        //       (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //     if (snapshot.hasError) {
        //       return Text('Something went wrong');
        //     }

        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Text("Loading");
        //     }

        //     return ListView(
        //       children: snapshot.data!.docs.map((DocumentSnapshot document) {
        //         Map<String, dynamic> data =
        //             document.data()! as Map<String, dynamic>;

        //         if (data['city'].toString().toLowerCase().startsWith(
        //               searchName.toLowerCase(),
        //             )) {
        //           return Card(
        //             elevation: 6,
        //             margin: const EdgeInsets.all(10),
        //             child: ListTile(
        //               leading: CircleAvatar(
        //                 radius: 30.0,
        //                 backgroundColor: Colors.transparent,
        //                 // backgroundColor: Colors.purple,
        //                 backgroundImage: NetworkImage(
        //                   data['imagesUrls'][0],
        //                 ),
        //               ),
        //               title: Text(data['foodItems']),
        //               subtitle: Text(data['city']),
        //               trailing: InkWell(
        //                   onTap: () {
        //                     Navigator.pushNamed(
        //                         context, DonatedFoodView.routeName,
        //                         arguments: ScreenArguments(document.id));
        //                   },
        //                   child: Icon(Icons.keyboard_arrow_right_rounded)),
        //             ),
        //           );
        //         }
        //         return Card();
        //       }).toList(),
        //     );
        //   },
        // ),
      ),
    );
  }
}
