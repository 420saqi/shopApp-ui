import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
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
  late List<OrdersItem> _orderItemsList = [];

  List<OrdersItem> get orderItemsList {
    return [..._orderItemsList];
  }

  Future<void> addOrderItem(
      List<CartItem> listOfCartItem, double totalAmount) async {
    const url = 'https://shopapp18gb-default-rtdb.firebaseio.com/orders.json';
    final timeStamp = DateTime.now();
    final response = await http.post(Uri.parse(url),
        body: json.encode({
          'amount': totalAmount,
          'dateTime': timeStamp.toIso8601String(),
          'products': listOfCartItem
              .map((item) => {
                    'title': item.title,
                    'id': item.id,
                    'quantity': item.quantity,
                    'price': item.price,
                  })
              .toList(),
        }));
    _orderItemsList.insert(
      0,
      OrdersItem(
          id: json.decode(response.body)['name'],
          price: totalAmount,
          items: listOfCartItem,
          dateTime: DateTime.now()),
    );
  }

  Future<void> fetchAndSetOrders() async {
    const url = 'https://shopapp18gb-default-rtdb.firebaseio.com/orders.json';
    final response = await http.get(Uri.parse(url));
    print(response.body);
    final extractedOrders = json.decode(response.body) ;
    if(extractedOrders == null)
      {return ;}
    List<OrdersItem> loadedProducts = [] ;
    extractedOrders.forEach((orderId, value) => loadedProducts.add(OrdersItem(
        id: orderId,
        price: value['amount'],
        dateTime: DateTime.parse(
          value['dateTime'],
        ),
        items: value['products']
            .map<CartItem>((item) => CartItem(
          id: item['id'],
          title: item['title'],
          price: item['price'],
          quantity: item['quantity'],
        ))
            .toList(),
    ),
    ),
    );
    _orderItemsList = loadedProducts.reversed.toList() ;
    notifyListeners();
  }
}
