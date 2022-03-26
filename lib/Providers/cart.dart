import 'package:flutter/material.dart';

class CartItem with ChangeNotifier {
  String productId;
  String title;
  String imageUrl;
  String size;
  Color color;
  double price;
  int quantity;
  CartItem({
    required this.productId,
    required this.title,
    required this.imageUrl,
    required this.size,
    required this.color,
    required this.price,
    required this.quantity,
  });
}

class Cart with ChangeNotifier {
  List<CartItem> _items = [
    CartItem(
        productId: "15",
        title: "BIYLACLESEN Women's 3-in-1 Snowboard Jacket Winter Coats",
        imageUrl: "https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg",
        size: "M",
        color: Color(0XFF033213),
        price: 56.99,
        quantity: 1),
    CartItem(
        productId: "16",
        title:
            "Lock and Love Women's Removable Hooded Faux Leather Moto Biker Jacket",
        imageUrl: "https://fakestoreapi.com/img/81XH0e8fefL._AC_UY879_.jpg",
        size: "S",
        color: Colors.black,
        price: 29.95,
        quantity: 1),
    CartItem(
        productId: "17",
        title: "Rain Jacket Women Windbreaker Striped Climbing Raincoats",
        imageUrl: "https://fakestoreapi.com/img/71HblAHs5xL._AC_UY879_-2.jpg",
        size: "M",
        color: Colors.blueGrey,
        price: 39.99,
        quantity: 1),
    CartItem(
        productId: "18",
        title: "MBJ Women's Solid Short Sleeve Boat Neck V",
        imageUrl: "https://fakestoreapi.com/img/71z3kpMAYsL._AC_UY879_.jpg",
        size: "M",
        color: Colors.white,
        price: 9.85,
        quantity: 1)
  ];
  List<CartItem> items() {
    return _items;
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    for (var itemm in _items) {
      total += itemm.quantity * itemm.price;
    }
    return total;
  }

  void changeColor(String productId, Color replacedColor) {
    int index = _items.indexWhere((element) => element.productId == productId);
    var temp = _items[index];
    _items[index] = CartItem(
        productId: temp.productId,
        title: temp.title,
        imageUrl: temp.imageUrl,
        size: temp.size,
        color: replacedColor,
        price: temp.price,
        quantity: temp.quantity);
    notifyListeners();
  }

  void changeSize(String productId, String size) {
    int index = _items.indexWhere((element) => element.productId == productId);
    var temp = _items[index];
    _items[index] = CartItem(
        productId: temp.productId,
        title: temp.title,
        imageUrl: temp.imageUrl,
        size: size,
        color: temp.color,
        price: temp.price,
        quantity: temp.quantity);
    notifyListeners();
  }

  void quantityPlus(String productId) {
    int index = _items.indexWhere((element) => element.productId == productId);
    var temp = _items[index];
    _items[index] = CartItem(
        productId: temp.productId,
        title: temp.title,
        imageUrl: temp.imageUrl,
        size: temp.size,
        color: temp.color,
        price: temp.price,
        quantity: temp.quantity + 1);
    notifyListeners();
  }

  void quantityMinus(String productId) {
    int index = _items.indexWhere((element) => element.productId == productId);
    var temp = _items[index];
    _items[index] = CartItem(
        productId: temp.productId,
        title: temp.title,
        imageUrl: temp.imageUrl,
        size: temp.size,
        color: temp.color,
        price: temp.price,
        quantity: temp.quantity - 1);
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.removeWhere((element) => element.productId == productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    int index = _items.indexWhere((element) => element.productId == productId);
    if (index == -1) {
      return;
    }
    if (_items[index].quantity > 1) {
      var temp = _items[index];
      _items[index] = CartItem(
          productId: temp.productId,
          title: temp.title,
          imageUrl: temp.imageUrl,
          size: temp.size,
          color: temp.color,
          price: temp.price,
          quantity: temp.quantity - 1);
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void clearCart() {
    _items = [];
    notifyListeners();
  }
}
