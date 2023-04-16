import 'package:flutter/material.dart';
import 'package:food_waste_management_system/screens/donar/donationMade/all_donation.dart';
import 'package:food_waste_management_system/screens/donar/donationMade/confirmed_screen.dart';

class DonationMode extends StatelessWidget {
  const DonationMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: const [
              Tab(
                text: "All Donations",
              ),
              Tab(
                text: "Confirmed Donations",
              ),
            ],
          ),
          title: Text('Donations'),
        ),
        body: TabBarView(
          children: const [
            AllDonationScreen(),
            ConfirmedDonations(),
          ],
        ),
      ),
    );
  }
}
