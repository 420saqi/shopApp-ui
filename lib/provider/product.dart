
import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final String description;
  bool isFavourite;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.description,
    this.isFavourite=false,
  });

  void toogleFavouriteStatus(){
    isFavourite = !isFavourite;
    notifyListeners();
  }

}