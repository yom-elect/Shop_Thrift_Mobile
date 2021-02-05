import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../providers/product.dart';

class ProductsService {
  static const url = 'https://social-app-ac019.firebaseio.com/';

  static Future addNewProduct(Product product) async {
    try {
      final response = await http.post(
        url + 'products.json',
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      return response;
    } catch (err) {
      throw err;
    }
  }

  static Future<Map<String, dynamic>> fetchProducts() async {
    try {
      final response = await http.get(url + 'products.json');
      return json.decode(response.body);
    } catch (err) {
      throw err;
    }
  }

  static Future updateProduct(String id, Product product) async {
    try {
      final response = await http.patch(url + 'products/$id.json',
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price
          }));
      return response;
    } catch (err) {
      throw err;
    }
  }

  static Future deleteProduct(String id) async {
    try {
      final response = await http.delete(url + "/products/$id.json");
      return response;
    } catch (err) {
      throw err;
    }
  }
}
