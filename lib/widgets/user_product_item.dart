import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/product_provider.dart';
import 'package:shopapp/screens/edit_products.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.id,
  });

  final String id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProductsScreen.routeName,
                  arguments: id,
                );
              },
              icon: const Icon(Icons.edit),
              color: Theme.of(context).colorScheme.primary,
            ),
            IconButton(
              onPressed: () {
                Provider.of<ProductsProvider>(context,listen: false).deleteProduct(id);
              },
              icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}
