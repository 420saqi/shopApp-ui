
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

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

  Future<void> toogleFavouriteStatus()async{

    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    try{
      final url =
        'https://shopapp18gb-default-rtdb.firebaseio.com/products/$id.json';
      final response = await http.patch(Uri.parse(url),body: json.encode({
        'isFavourite' : isFavourite,
      }));
      print(isFavourite);
      print(oldStatus);
      print(response.statusCode);
      if(response.statusCode >=400)
        {
          isFavourite = oldStatus;
          notifyListeners();
        }
    }catch(error){
      isFavourite = oldStatus;
      notifyListeners();
    }

  }

}