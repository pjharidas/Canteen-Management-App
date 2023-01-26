import 'dart:async';

import 'package:canteen_app/Models/CAUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Models/Admin_Model.dart';
import '../Models/Customer_Model.dart';

class FirestoreServices {
  FirebaseFirestore _dataBase = FirebaseFirestore.instance;

  Future<CAUser> uidToCAUser(String uid) async {
    DocumentSnapshot? adminDoc;
    DocumentSnapshot? customerDoc;
    var caUser = CAUser();
    bool doesTheUIDBelongToCustomer = true;
    try {
      customerDoc = await _dataBase.collection("Customer").doc(uid).get();
      adminDoc = await _dataBase.collection("Admin").doc(uid).get();

      doesTheUIDBelongToCustomer = customerDoc.exists;
      Map<String, dynamic> customerDocData =
          customerDoc.data() as Map<String, dynamic>;
      Map<String, dynamic> adminDocData =
          adminDoc.data() as Map<String, dynamic>;

      if (!doesTheUIDBelongToCustomer &&
          doesTheUIDBelongToCustomer == !adminDoc.exists) {
        caUser = Admin(
            firebaseUID: uid,
            userName: adminDocData["userName"],
            email: adminDocData["email"],
            phoneNumber: adminDocData["phoneNumber"]);
        // FirestoreServices.currentUserStreamController.add(caUser);
        // return caUser;
      } else if (doesTheUIDBelongToCustomer) {
        caUser = Customer(
            firebaseUID: uid,
            userName: customerDocData["userName"],
            email: customerDocData["email"],
            phoneNumber: customerDocData["phoneNumber"]);
        // FirestoreServices.currentUserStreamController.add(caUser);
      }
    } catch (e) {
      print(e);
    }
    return caUser;
  }

  // static StreamController<CAUser> currentUserStreamController =
  //     StreamController();
  static Stream<CAUser> get currentUserStream async*{
    FirebaseAuth.instance.authStateChanges().map(
      (event) async* {
      yield await FirestoreServices().uidToCAUser(event!.uid);
    });
  }
}
