import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_shop/providers/cart.dart';

class OrdersService {
  static const url = 'https://social-app-ac019.firebaseio.com/';

  static Future addOrder(
    List<CartItem> cartProducts,
    double total,
    DateTime timestamp,
  ) async {
    try {
      return await http.post(
        url + 'orders.json',
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price
                  })
              .toList(),
        }),
      );
    } catch (err) {
      throw err;
    }
  }

  static Future<Map<String, dynamic>> fetchOrders() async {
    try {
      final response = await http.get(url + 'orders.json');
      return json.decode(response.body);
    } catch (err) {
      throw err;
    }
  }
}
