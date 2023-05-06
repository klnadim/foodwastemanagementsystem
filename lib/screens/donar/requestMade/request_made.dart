import 'package:flutter/material.dart';

import 'package:food_waste_management_system/screens/donar/requestMade/all_reqested.dart';
import 'package:food_waste_management_system/screens/donar/requestMade/on_going_req.dart';
import 'package:food_waste_management_system/screens/donar/requestMade/out_going_requests.dart';
import 'package:food_waste_management_system/screens/donar/requestMade/request_confirmed.dart';

class RequestMode extends StatelessWidget {
  const RequestMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: const [
              Tab(
                text: "OnGoing",
              ),
              Tab(
                text: "OutGoing Requests",
              ),
              Tab(
                text: "Incoming Requests",
              ),
              Tab(
                text: "In Req Confirmed ",
              ),
            ],
          ),
          title: Text('Requests'),
        ),
        body: TabBarView(
          children: const [
            OnGoingRequestSreen(),
            OutGoingRequestScreen(),
            AllReqestedScreen(),
            RequestConfirmedSreen(),
          ],
        ),
      ),
    );
  }
}
