import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:my_shop/core/services/orders.dart';
import 'package:my_shop/providers/cart.dart';

import 'cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  final String authToken;
  final String userId;

  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    try {
      final orders = await OrdersService.fetchOrders(authToken, userId);
      final List<OrderItem> loadedOrders = [];
      if (orders == null) {
        return;
      }
      orders.forEach((orderId, orderData) {
        loadedOrders.add(OrderItem(
          id: orderId,
          amount: orderData['amount'],
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                    id: item['id'],
                    price: item['price'],
                    title: item['title'],
                    quantity: item['quantity'],
                  ))
              .toList(),
          dateTime: DateTime.parse(orderData['dateTime']),
        ));
      });

      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final timestamp = DateTime.now();
    try {
      final response = await OrdersService.addOrder(
          cartProducts, total, timestamp, userId, authToken);
      _orders.insert(
          0,
          OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            products: cartProducts,
            dateTime: timestamp,
          ));
    } catch (err) {
      throw err;
    }
    notifyListeners();
  }
}
