import 'package:firebase_auth/firebase_auth.dart';
import 'CAUser.dart';

class Admin extends CAUser {
  String? firebaseUID;
  String? userName;
  String? email;
  String? phoneNumber;
  final userType = UserType.admin;
  Admin({
    required String firebaseUID,
    required String userName,
    required String email,
    required String phoneNumber,
  }) {
    this.firebaseUID = firebaseUID;
    this.userName = userName;
    this.email = email;
    this.phoneNumber = phoneNumber;
  }
  Map<String, dynamic> toJSON() => {
        "firebaseUID": firebaseUID,
        "userName": userName,
        "email": email,
        "phoneNumber": phoneNumber
      };
  static Admin fromJSON(Map<String, dynamic> json) => Admin(
        firebaseUID: json["firebaseUID"],
        userName: json["userName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
      );
}
