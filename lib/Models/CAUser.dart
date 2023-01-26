enum UserType { admin, customer, caUser}

class CAUser {
  String? firebaseUID;
  String? userName;
  String? email;
  String? phoneNumber;
  Enum? userType;
  // CAUser({
  //    String firebaseUID,
  //    String userName,
  //    String email,
  //    String phoneNumber,
  // }) {
  //   this.firebaseUID = firebaseUID;
  //   this.userName = userName;
  //   this.email = email;
  //   this.phoneNumber = phoneNumber;
  // }
  Map<String, dynamic> toJSON() => {
        "firebaseUID": firebaseUID,
        "userName": userName,
        "email": email,
        "phoneNumber": phoneNumber
      };
}
