import 'package:canteen_app/Auth%20Services/Firestore_Services.dart';
import 'package:canteen_app/Models/CAUser.dart';
import 'package:canteen_app/Screens/AdminHomePage.dart';
import 'package:canteen_app/Screens/LogInPage.dart';
import 'package:canteen_app/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Models/Customer_Model.dart';
import 'Screens/CustomerHomePage.dart';

// Platform  Firebase App Id
// web       1:234122021539:web:0b0d35e31d90934dac4d16
// android   1:234122021539:android:b91f9303ec821b2cac4d16
// ios       1:234122021539:ios:14d0aeb1df475652ac4d16
// macos     1:234122021539:ios:14d0aeb1df475652ac4d16
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: StreamBuilder(
              initialData: null,
              stream: FirebaseAuth.instance.authStateChanges().map(
      (event) async* {
      yield await FirestoreServices().uidToCAUser(event!.uid);
    }),
              //  FirestoreServices.currentUserStream,
              builder: (context, snapshot) {
                Widget widget = LogInPage();

                  if (snapshot.data != null) {
                    // Go to AdminHomePage if the logged in User is a Admin
                    print("Logged in Usertype : ${snapshot.data!.userType.toString()}");
                    if (snapshot.data!.userType == UserType.admin) {
                      widget = AdminHomePage(caUser: snapshot.data!);
                    }
                    // Go to CustomerHomePage if the logged in User is a Customer
                    else if (snapshot.data?.userType == UserType.customer) {
                      widget = CustomerHomePage(
                        caUser: snapshot.data!,
                      );
                    }
                    // else if (snapshot.data?.userType == UserType.caUser) {
                    //   widget = LogInPage();
                    // }
                  } else {
                    widget = LogInPage();
                  }
                return widget;
              }),
        ));
  }
}
