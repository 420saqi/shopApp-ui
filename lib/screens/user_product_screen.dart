import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/product_provider.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({super.key});
  static const routeName = '/userProductScreen';

  @override
  Widget build(BuildContext context) {
    final listOfProduct = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('You Products'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding:const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: listOfProduct.items.length,
          itemBuilder: (_, index) => Column(
            children: [
              UserProductItem(
                title: listOfProduct.items[index].title,
                imageUrl: listOfProduct.items[index].imageUrl,
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
