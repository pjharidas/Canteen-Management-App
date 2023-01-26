import 'package:canteen_app/Auth%20Services/Firestore_Services.dart';
import 'package:canteen_app/Models/Customer_Model.dart';
import 'package:canteen_app/Models/CAUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Models/Admin_Model.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final FirestoreServices _firestoreServices = FirestoreServices();

  // log in
// Cannot Make a return type as Customer coz we don't know whether the person logged
// in was a customer or an Admin
  Future<void> logInCustomerUsingEmailAndPassword(
    String email,
    String password,
    String userName,
    String phoneNumber,
  ) async {
    final caUser;
    // Logging the user in
    UserCredential creds = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    caUser = await _firestoreServices.uidToCAUser(creds.user!.uid);
          // print("Sending The User Via Stream");
      // FirestoreServices.currentUserStreamController.sink.add(caUser);

      // print("User Sent Via Stream");

    print(
      "User Logged in With UID : ${creds.user != null ? creds.user!.uid : "Error"}",
    );
    // return caUser;
  }

  // Create
  Future<void> createCustomerUsingEmailAndPassword(
    String email,
    String password,
    String userName,
    String phoneNumber,
    bool? isCustomer,
  ) async {
    Customer customer;
    Admin admin;
    // Logging the user in
    UserCredential creds = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    print(
      "User Created With UID : ${creds.user != null ? creds.user!.uid : "Error"}",
    );
    // if (isCustomer) {
    // Creating a Customer object using Firebase user
    if (isCustomer ?? true) {
      customer = Customer(
          firebaseUID: creds.user!.uid,
          userName: userName,
          email: creds.user!.email!,
          phoneNumber: phoneNumber);
      // Adding the user<Customer> to our database with doc ID being the FirebaseAuth UID.
      final docUser = db.collection("Customer").doc(creds.user!.uid.toString());
      await docUser.set(customer.toJSON());
      // print("Sending The User Via Stream");
      // FirestoreServices.currentUserStreamController.add(customer);
      // print("User Sent Via Stream");

      // return customer;
    } else {
      admin = Admin(
          firebaseUID: creds.user!.uid,
          userName: userName,
          email: creds.user!.email!,
          phoneNumber: phoneNumber);
      // Adding the user<Customer> to our database with doc ID being the FirebaseAuth UID.
      final docUser = db.collection("Admin").doc(creds.user!.uid.toString());
      await docUser.set(admin.toJSON());
      // print("Sending The User Via Stream");
      // FirestoreServices.currentUserStreamController.add(admin);
      // print("User Sent Via Stream");
      // return admin;
    }
  }
  // Forgot Password
}
