
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/product_provider.dart';
import 'package:shopapp/widgets/product_item.dart';


class ProductGridView extends StatelessWidget {
  const ProductGridView({super.key,required this.isFavourite});
final bool isFavourite;
  @override
  Widget build(BuildContext context) {

    final productData = Provider.of<ProductsProvider>(context);
    final productsList = isFavourite ? productData.favouriteItems : productData.items ;
    return
      GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3/2,
        ),
        itemBuilder: (context, index) =>ChangeNotifierProvider.value(
            // create: (context) => productsList[index],
          // using .value notation is beneficial if we are parsing through
          // a list or grid as we are doing here we parse through the
          // productsList for each item , so .value will save us from errors
          // that might can occur if we used without .value notation of provider
          value: productsList[index],
                child: ProductItem(
        ),),
        itemCount: productsList.length,
      );
  }
}


