import 'CAUser.dart';

class Customer extends CAUser{
  String? firebaseUID;
  String? userName;
  String? email;
  String? phoneNumber;
  @override
  final userType = UserType.customer;
  Customer({
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
  static Customer fromJSON (Map<String,dynamic> json) => Customer(
    firebaseUID: json["firebaseUID"],
    userName: json["userName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],

  );
}
