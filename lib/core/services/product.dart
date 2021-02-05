import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  static const url = 'https://social-app-ac019.firebaseio.com/';

  static Future updateFavoriteStatus(String id, bool isFavorite) async {
    try {
      return await http.patch(url + 'products/$id.json',
          body: json.encode({
            'isFavorite': isFavorite,
          }));
    } catch (err) {
      throw err;
    }
  }
}
