import 'Food_Item_Model.dart';

class Restaurant {
  String? firebaseUID;
  String? restaurantName;
  String? email;
  String? phoneNumber;
  List<FoodItem>? menu;
  Restaurant({
    required String firebaseUID,
    required String restaurantName,
    required String email,
    required String phoneNumber,
    required List<FoodItem> menu,

  }) {
    this.firebaseUID = firebaseUID;
    this.restaurantName = restaurantName;
    this.email = email;
    this.phoneNumber = phoneNumber;
    this.menu = menu;
  }

  Map<String, dynamic> toJSON() => {
        "firebaseUID": firebaseUID,
        "restaurantName": restaurantName,
        "email": email,
        "phoneNumber": phoneNumber,
        "menue": menu
      };
}
