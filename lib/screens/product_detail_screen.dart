import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId= ModalRoute.of(context)?.settings.arguments ;
    return Scaffold(
      appBar: AppBar(title: Text('title'),),
      body:Text('hello world') ,
    );
  }
}
