import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments;
    final loadedItemProduct = Provider.of<ProductsProvider>(
      context,
      listen: false, // listen is false becuase whenever something
      // change this widget do not get rebuild because it
      // only shows product details once user tap on it..
    ).findById(productId.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedItemProduct.title),
      ),
      body: const Text('hello world'),
    );
  }
}
