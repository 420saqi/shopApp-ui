import 'package:flutter/material.dart';
import 'package:shopapp/widgets/product_grid.dart';

enum FilterOption{
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
            onSelected: (FilterOption selectedItemValue){
              if(selectedItemValue == FilterOption.favourites)
                {
                  setState(() {
                    isFavourite= true;
                  });
                }
              else
                {
                  setState(() {
                    isFavourite= false;
                  });
                }
            },
            icon:const Icon(Icons.more_vert),
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
          )
        ],
      ),
      body: ProductGridView(isFavourite: isFavourite),
    );
  }
}
