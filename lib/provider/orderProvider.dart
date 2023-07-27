import 'package:flutter/cupertino.dart';

import 'cart_provider.dart';

class OrdersItem {
  final String id;
  final double price;
  final List<CartItem> items;
  final DateTime dateTime;

  OrdersItem({
    required this.id,
    required this.price,
    required this.items,
    required this.dateTime,
  });
}

class OrderProvider with ChangeNotifier {

  List<OrdersItem> orderItemsList = [];

  void addOrderItem(List<CartItem> list, double totalAmount) {
    orderItemsList.insert(0, OrdersItem(id: DateTime.now().toString(),
        price: totalAmount,
        items: list,
        dateTime: DateTime.now()),
    );
  }
}