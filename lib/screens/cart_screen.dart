import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/orderProvider.dart';
import 'package:shopapp/widgets/cart_item.dart';

import '../provider/cart_provider.dart' show CartProvider;

// show CartProvider means from this file we only need CartProvider class
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const routeName = '/cartItems';

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Items'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Text('Total '),
                const Spacer(),
                Chip(
                  backgroundColor: Colors.deepOrange,
                  label: Text('\$${cartData.totalAmount}'),
                ),
                TextButton(
                  onPressed: () {
                    Provider.of<OrderProvider>(context , listen: false).addOrderItem(
                        cartData.items.values.toList(), cartData.totalAmount);
                    cartData.clearCartOnOrder();
                  },
                  child: const Text('Order Now'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartData.items.length,
              itemBuilder: (context, index) {
                return MyCartItem(
                  id: cartData.items.values.toList()[index].id,
                  productKey: cartData.items.keys.toList()[index],
                  quantity: cartData.items.values.toList()[index].quantity,
                  price: cartData.items.values.toList()[index].price,
                  title: cartData.items.values.toList()[index].title,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
