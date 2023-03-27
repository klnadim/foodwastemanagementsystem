import 'package:flutter/material.dart';
import 'package:food_waste_management_system/screens/admin/all_reqested.dart';
import 'package:food_waste_management_system/screens/admin/confirmed_screen.dart';
import 'package:food_waste_management_system/screens/admin/rejected_screen.dart';

class ReqestFoodStatusScreen extends StatelessWidget {
  const ReqestFoodStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: const [
              Tab(
                text: "All",
              ),
              Tab(
                text: "Confirmed",
              ),
              Tab(
                text: "Rejected",
              ),
            ],
          ),
          title: Text('All Food Requests'),
        ),
        body: TabBarView(
          children: [
            AllReqestedScreen(),
            ConfirmedScreen(),
            RejectedScreen(),
          ],
        ),
      ),
    );
  }
}
