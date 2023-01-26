

import 'Customer_Model.dart';

enum orderStatus { finished, pending, delivered, noShow }

class Order {
  String? firebaseUID;
  String? orderName;
  Customer? customer;
  String? phoneNumber;
  var orderStatus;
  Order({
    required String firebaseUID,
    required String userName,
    required Customer customer,
    required String phoneNumber,
    required orderStatus,
  }) {
    this.firebaseUID = firebaseUID;
    this.orderName = userName;
    this.customer = customer;
    this.phoneNumber = phoneNumber;
    this.orderStatus = orderStatus;
  }
  Map<String, dynamic> toJSON() => {
        "firebaseUID": firebaseUID,
        "userName": orderName,
        "email": customer,
        "phoneNumber": phoneNumber,
        "orderStatus": orderStatus
      };

  
}
