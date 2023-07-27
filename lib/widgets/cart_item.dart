import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';

class MyCartItem extends StatelessWidget {
  const MyCartItem({
    super.key,
    required this.id,
    required this.quantity,
    required this.price,
    required this.title,
    required this.productKey,
  });

  final String id;
  final String productKey;
  final String title;
  final double price;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,

      key: ValueKey(id),
      onDismissed: (direction) {
        Provider.of<CartProvider>(context,listen: false).removeItem(productKey);
        // listen : false removes the items from cart but listen: true doesn't why?
      },
      background: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        alignment: Alignment.centerRight,
        color: Theme.of(context).colorScheme.error,
        child: const Icon(Icons.delete,color: Colors.white,),
      ),
      child: Card(
        margin: const EdgeInsets.all(10),
        child: ListTile(
          title: Text(title),
          trailing: Text('$quantity X'),
          leading: CircleAvatar(
            child: FittedBox(child: Text('\$$price'),
          ),
        ),
        ),
      ),
    );
  }
}
