import 'dart:convert';

import 'package:fashionstore/Providers/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final url = Uri.parse(
        "https://fakestoreapi.com/products/category/women's%20clothing");

    try {
      final response = await http.get(url);

      final List<Product> _updatedList = [];

      final extractedData = json.decode(response.body);

      if (extractedData == null) {
        return;
      }

      extractedData.forEach((prodData) {
        final newProduct = Product(
          id: prodData['id'],
          title: prodData['title'],
          price: prodData['price'],
          description: prodData['description'],
          category: prodData['category'],
          imageUrl: prodData['image'],
          rating: 1.1,
          count: 1,
        );

        _updatedList.add(newProduct);
      });
      _items = _updatedList;

      notifyListeners();
    } catch (error) {
      print(error);
    } finally {}
  }
}
