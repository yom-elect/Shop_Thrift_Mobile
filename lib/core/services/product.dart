import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  static const url = 'https://social-app-ac019.firebaseio.com/';

  static Future updateFavoriteStatus(
      String id, bool isFavorite, String token, String userId) async {
    try {
      final response = await http.put(
          url + 'userFavorites/$userId/$id.json?auth=$token',
          body: json.encode(isFavorite));
      return response;
    } catch (err) {
      print(err);
      throw err;
    }
  }

  static Future getUserInfo(String userId, String token) async {
    try {
      final response =
          await http.get(url + 'userFavorites/$userId.json?auth=$token');
      final data = json.decode(response.body);
      return data;
    } catch (err) {
      throw err;
    }
  }
}
