
import 'package:flutter/cupertino.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });
}

class CartProvider with ChangeNotifier {
   Map<String, CartItem> _items= { };

  Map<String, CartItem> get items {
    return {..._items}; // returning a copy of _items
  }

   int get itemCount{
    return items.length;
   }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingItem) => CartItem(
                id: existingItem.id,
                title: existingItem.title,
                price: existingItem.price,
                quantity: existingItem.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  double get totalAmount{
    double total =0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity ;
    });
    return total;
  }

  void removeItem(String productKey)
  {
    _items.remove(productKey);
    notifyListeners();
  }

  void clearCartOnOrder(){
    _items= {};
    notifyListeners();
  }

}
