import 'package:canteen_app/Models/CAUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Auth Services/Firestore_Services.dart';
import '../Models/Customer_Model.dart';

class CustomerHomePage extends StatelessWidget {
  final CAUser caUser;
  const CustomerHomePage({super.key, required this.caUser});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            color: Colors.lightBlueAccent,
            child: Text("Signed in as ${caUser.email!}")),
        ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // FirestoreServices.currentUserStreamController.add(CAUser());

              print("Signed out successfully!");
              Navigator.pop(context);
            },
            child: Text("Log Out"))
      ],
    )));
  }
}
