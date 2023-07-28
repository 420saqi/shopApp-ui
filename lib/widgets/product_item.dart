import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';
import '../provider/product.dart';

class ProductItem extends StatelessWidget {
  static const routeName = 'product_detail_screen';

  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context , listen: false);
    final cartProvider = Provider.of<CartProvider>(context , listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          footer: GridTileBar(
            title: Text(product.title),
            backgroundColor: Colors.black54,
            leading: Consumer<Product>(
              builder: (context, value, child) =>IconButton(
                onPressed: () {
                  product.toogleFavouriteStatus();
                },
                icon: Icon(
                    product.isFavourite ? Icons.favorite : Icons.favorite_border),
                color: Theme.of(context).iconTheme.color,
              ),

            ),
            trailing: IconButton(
              onPressed: () {
                cartProvider.addItem(product.id, product.price, product.title);
              },
              icon: const Icon(Icons.shopping_cart),
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  routeName,
                  arguments: product.id,
                );
              },
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ))),
    );
  }
}
