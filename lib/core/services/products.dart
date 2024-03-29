import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../providers/product.dart';

class ProductsService {
  static const url = 'https://social-app-ac019.firebaseio.com/';

  static Future addNewProduct(
      Product product, String userId, String token) async {
    try {
      final response = await http.post(
        url + 'products.json?auth=$token',
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'createdBy': userId,
        }),
      );
      return response;
    } catch (err) {
      throw err;
    }
  }

  static Future<Map<String, dynamic>> fetchProducts(
      String token, String userId, bool filterByUser) async {
    print(filterByUser);
    try {
      final filterString =
          filterByUser ? 'orderBy="createdBy"&equalTo="$userId"' : '';
      final response =
          await http.get(url + 'products.json?auth=$token&$filterString');
      return json.decode(response.body);
    } catch (err) {
      throw err;
    }
  }

  static Future updateProduct(String id, Product product, String token) async {
    try {
      final response = await http.patch(url + 'products/$id.json?auth=$token',
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

  static Future deleteProduct(String id, String token) async {
    try {
      final response =
          await http.delete(url + "/products/$id.json?auth=$token");
      return response;
    } catch (err) {
      throw err;
    }
  }
}
