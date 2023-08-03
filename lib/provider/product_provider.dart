import 'package:flutter/cupertino.dart';

import 'product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
      'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
      'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    return [..._items]; // reutrn a copy of _items list
  }

  List<Product> get favouriteItems {
    return _items.where((product) => product.isFavourite).toList();
  }

  void addProduct(Product product) {
    final newProduct = Product(
        id: DateTime.now().toString(),
        title: product.title,
        price: product.price,
        imageUrl: product.imageUrl,
        description: product.description);

    _items.add(newProduct); // add at the end of the list
    // _items.insert(0, newProduct); // add at the beginning of the list
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((productItem) => productItem.id == id);
  }

  void updateProduct(String id, Product newProduct)
  {
    final getIndexOfExistedProduct = _items.indexWhere((prod) => prod.id == id );
    _items[getIndexOfExistedProduct] = newProduct ;
    notifyListeners();
  }

  void deleteProduct(String id)
  {
    _items.removeWhere((prod) => prod.id== id);
    notifyListeners();
  }
}