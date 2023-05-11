import 'package:flutter/material.dart';
import 'package:food_waste_management_system/screens/admin/request/admin_all_request.dart';
import 'package:food_waste_management_system/screens/admin/request/admin_request_confirmed.dart';

class AdminRequestMode extends StatelessWidget {
  const AdminRequestMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: const [
              Tab(
                text: "All Request",
              ),
              Tab(
                text: "Confirmed Request",
              ),
            ],
          ),
          title: Text('Requests'),
        ),
        body: TabBarView(
          children: const [
            AdminAllReqestedScreen(),
            AdminRequestConfirmedSreen()
          ],
        ),
      ),
    );
  }
}
