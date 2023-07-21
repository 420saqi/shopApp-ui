import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {

  static const routeName= 'product_detail_screen';

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
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer:GridTileBar(
          title: Text(title),
          backgroundColor: Colors.black54,
          leading: IconButton(
            onPressed: (){},
            icon:const Icon(Icons.favorite),
            color: Theme.of(context).iconTheme.color,
          ),
          trailing: IconButton(
            onPressed: (){},
            icon:const Icon(Icons.shopping_cart),
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        child: GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed(routeName, arguments: id,);
            },
            child: Image.network(imageUrl,fit: BoxFit.cover,))


      ),
    );
  }
}
