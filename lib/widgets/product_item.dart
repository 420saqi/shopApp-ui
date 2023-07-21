import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String imageUrl;
  final String id;
  final String title;


  ProductItem({
    required this.imageUrl,
    required this.id,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer:GridTileBar(
        title: Text(title),
        backgroundColor: Colors.black54,
        leading: IconButton(
          onPressed: (){},
          icon:const Icon(Icons.favorite),
        ),
        trailing: IconButton(
          onPressed: (){},
          icon:const Icon(Icons.shopping_cart),
        ),
      ),
      child: Image.network(imageUrl,fit: BoxFit.cover,)


    );
  }
}
