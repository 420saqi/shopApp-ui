import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert'; // for converting a map to json structure
import 'package:http/http.dart' as http;
import 'product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get items {
    return [..._items]; // reutrn a copy of _items list
  }

  List<Product> get favouriteItems {
    return _items.where((product) => product.isFavourite).toList();
  }

  Future<void> fetchAndSetData() async {
    try {
      const url =
          'https://shopapp18gb-default-rtdb.firebaseio.com/products.json';
      final response = await http.get(Uri.parse(url));
      // print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

        final List<Product> loadedProductList = [];
      extractedData.forEach((prodKey, prodData) {
        loadedProductList.add(Product(
          id: prodKey,
          title: prodData['title'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          description: prodData['description'],
          isFavourite: prodData['isFavourite'],
        ));
        _items = loadedProductList;
        notifyListeners();
      });
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://shopapp18gb-default-rtdb.firebaseio.com/products.json';
    try {
      final result = await http.post(Uri.parse(url),
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'isFavourite': product.isFavourite,
            'price': product.price,
          }));
      // print(json.decode(result.body)['name']);
      // below code will execute only when above await code will be completed
      // if any error occur it skip the below product and goto catch block.
      final newProduct = Product(
          id: json.decode(result.body)['name'],
          title: product.title,
          price: product.price,
          imageUrl: product.imageUrl,
          description: product.description);

      _items.add(newProduct); // add at the end of the list
      // _items.insert(0, newProduct); // add at the beginning of the list
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }
  }

  Product findById(String id) {
    return _items.firstWhere((productItem) => productItem.id == id);
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final getIndexOfExistedProduct = _items.indexWhere((prod) => prod.id == id);
    final url =
        'https://shopapp18gb-default-rtdb.firebaseio.com/products/$id.json';
    await http.patch(Uri.parse(url),
        body: json.encode({
          'title': newProduct.title,
          'description': newProduct.description,
          'price': newProduct.price,
          'imageUrl': newProduct.imageUrl,
        }));
    _items[getIndexOfExistedProduct] = newProduct;
    notifyListeners();
  }

  void deleteProduct(String id) {
    // it will get the index of the item we wanna delete
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    // it will get the item itself that user wants to delete
    Product? existingProduct = _items.firstWhere((prod) => prod.id == id);
    //url of db where we want to delete product
    final url =
        'https://shopapp18gb-default-rtdb.firebaseio.com/products/$id.json';
    http.delete(Uri.parse(url)).then((response) {
      // if deletion is successful then status code would be 200
      // but if status code >= 400 then some error has occur
      print(response.statusCode);
      if(response.statusCode >=400)
        {
          throw const HttpException('could not delete the item');
        }
      // if deleteing is successful then existingproduct will be null means
      // it would be removed from the memory
      existingProduct = null ;
    }).catchError((_){
      //if error occur then existing product that is stored in memory
      // will readded to _items list
      _items[existingProductIndex] = existingProduct as Product;
      notifyListeners();
    });
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
