import 'package:flutter/material.dart';

import 'package:food_waste_management_system/screens/donar/requestMode/all_reqested.dart';
import 'package:food_waste_management_system/screens/donar/requestMode/rejected_screen.dart';
import 'package:food_waste_management_system/screens/donar/requestMode/request_confirmed.dart';
import 'package:food_waste_management_system/screens/donar/requestMode/request_for.dart';

class RequestMode extends StatelessWidget {
  const RequestMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: const [
              Tab(
                text: "All Reqeust",
              ),
              Tab(
                text: "Request For",
              ),
              Tab(
                text: "Request Confirmed",
              ),
            ],
          ),
          title: Text('Donations'),
        ),
        body: TabBarView(
          children: const [
            AllReqestedScreen(),
            RequestForSreen(),
            RequestConfirmedSreen()
          ],
        ),
      ),
    );
  }
}
