import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/cart_provider.dart';
import 'package:shopapp/screens/cart_screen.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/badge.dart';
import 'package:shopapp/widgets/product_grid.dart';

enum FilterOption {
  favourites,
  allProducts,
}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOption selectedItemValue) {
              if (selectedItemValue == FilterOption.favourites) {
                setState(() {
                  isFavourite = true;
                });
              } else {
                setState(() {
                  isFavourite = false;
                });
              }
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: FilterOption.favourites,
                child: Text('Favourites'),
              ),
              const PopupMenuItem(
                value: FilterOption.allProducts,
                child: Text('All Products'),
              ),
            ],
          ),
          Consumer<CartProvider>(
            builder: (_, cartData, ch) {
              return BadgeForCart(
                value: cartData.itemCount.toString(),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
              );
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ProductGridView(isFavourite: isFavourite),
    );
  }
}
