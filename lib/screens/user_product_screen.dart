import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';
import './edit_products.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({super.key});
  static const routeName = '/userProductScreen';

  Future<void> _refreshPrudocts(BuildContext context)
  async {
   await Provider.of<ProductsProvider>(context,listen: false).fetchAndSetData();
  }

  @override
  Widget build(BuildContext context) {
    final listOfProduct = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('You Products'),
        actions: [
          IconButton(
            onPressed: () {
           Navigator.of(context).pushNamed(EditProductsScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: ()=>_refreshPrudocts(context),
        child: Padding(
          padding:const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: listOfProduct.items.length,
            itemBuilder: (_, index) => Column(
              children: [
                UserProductItem(
                  id: listOfProduct.items[index].id,
                  title: listOfProduct.items[index].title,
                  imageUrl: listOfProduct.items[index].imageUrl,
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
