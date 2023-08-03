import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/product.dart';
import 'package:shopapp/provider/product_provider.dart';

class EditProductsScreen extends StatefulWidget {
  const EditProductsScreen({super.key});

  static const routeName = '/edit-products';

  @override
  State<EditProductsScreen> createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imageController = TextEditingController();
  final _imageUrlFocuNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool isInit = true;
  var _existingProduct = Product(
    id: '',
    title: '',
    price: 0.0,
    imageUrl: '',
    description: '',
  );

  var initValues = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': '',
  };

  @override
  void dispose() {
    _priceFocusNode.dispose();
    // dispose them otherwise they lead to memory leaks
    _descFocusNode.dispose();
    _imageController.dispose();
    _imageUrlFocuNode.dispose();
    _imageUrlFocuNode.removeListener(_updateImageUrl);
    super.dispose();
  }

  @override
  void initState() {
    _imageUrlFocuNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    setState(() {});
  }

  void _saveFormData() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
    if (_existingProduct.id.isNotEmpty) // means product already exists
    {
      Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(_existingProduct.id, _existingProduct);
    } else {
      Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(_existingProduct);
    }
    Navigator.of(context).pop();
    // setState(() {
    //   // i have added setState because when i click the save button the
    //   // image in container doesn't previewed but when i click done button
    //   // on the keyboard the image was previewing .
    // });
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments as String?;
      print('Here is my product id in editProudct Screen : $productId');
      if (productId != null) {
        _existingProduct = Provider.of<ProductsProvider>(context, listen: false)
            .findById(productId);
        initValues = {
          'title': _existingProduct.title,
          'description': _existingProduct.description,
          'price': _existingProduct.price.toString(),
          'imageUrl': '',
        };
        _imageController.text = _existingProduct.imageUrl;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Products'),
        actions: [
          TextButton(
            onPressed: _saveFormData,
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: initValues['title'],
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                onSaved: (newValue) {
                  _existingProduct = Product(
                    id: _existingProduct.id,
                    isFavourite: _existingProduct.isFavourite,
                    title: newValue.toString(),
                    price: _existingProduct.price,
                    imageUrl: _existingProduct.imageUrl,
                    description: _existingProduct.description,
                  );
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter a valid title';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: initValues['price'],
                decoration: const InputDecoration(
                  labelText: 'price',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descFocusNode);
                },
                focusNode: _priceFocusNode,
                onSaved: (newValue) {
                  _existingProduct = Product(
                    id: _existingProduct.id,
                    isFavourite: _existingProduct.isFavourite,
                    title: _existingProduct.title,
                    price: double.parse(newValue!),
                    imageUrl: _existingProduct.imageUrl,
                    description: _existingProduct.description,
                  );
                },
                validator: (value) {
                  if (value!.isEmpty) return 'Enter Price';
                  if (double.tryParse(value) == null) {
                    return 'Enter a valid number';
                  }
                  if (double.parse(value) <= 0) return 'Enter price above zero';
                  return null;
                },
              ),
              TextFormField(
                initialValue: initValues['description'],
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _descFocusNode,
                onSaved: (newValue) {
                  _existingProduct = Product(
                    id: _existingProduct.id,
                    isFavourite: _existingProduct.isFavourite,
                    title: _existingProduct.title,
                    price: _existingProduct.price,
                    imageUrl: _existingProduct.imageUrl,
                    description: newValue.toString(),
                  );
                },
                validator: (value) {
                  if (value!.isEmpty) return 'Enter Price';
                  if (value.length < 10) {
                    return 'Length should be greater than 10';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 8.0, right: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: _imageController.text.isEmpty
                          ? const Center(child: Text('Enter Url'))
                          : FittedBox(
                              fit: BoxFit.fill,
                              child: Image.network(_imageController.text),
                            )),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Image Url',
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageController,
                      focusNode: _imageUrlFocuNode,
                      onFieldSubmitted: (value) => _saveFormData(),
                      onSaved: (newValue) {
                        _existingProduct = Product(
                          id: _existingProduct.id,
                          isFavourite: _existingProduct.isFavourite,
                          title: _existingProduct.title,
                          price: _existingProduct.price,
                          imageUrl: newValue.toString(),
                          description: _existingProduct.description,
                        );
                      },
                      validator: (value) {
                        if (value!.isEmpty) return 'Enter an Image Url';
                        if ((!_imageController.text.startsWith('http') &&
                                !_imageController.text.startsWith('https')) ||
                            (!_imageController.text.endsWith('.jpg') &&
                                !_imageController.text.endsWith('.png') &&
                                !_imageController.text.endsWith('.jpeg'))) {
                          return 'Enter a valid Url';
                        }
                        return null;
                      },
                      // onEditingComplete: () {
                      //   setState(() {});
                      // },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
