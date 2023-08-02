import 'package:flutter/material.dart';
import 'package:shopapp/provider/product.dart';

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
  var _existingProduct = Product(
    id: '',
    title: '',
    price: 0.0,
    imageUrl: '',
    description: '',
  );

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
    _formKey.currentState?.save();
    print(_existingProduct.title);
    print(_existingProduct.price);
    print(_existingProduct.description);
    print(_existingProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Products'),
        actions: [
          TextButton(
            onPressed: _saveFormData,
            child: const Text('Save',style: TextStyle(color: Colors.white),),
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
                    title: newValue.toString(),
                    price: _existingProduct.price,
                    imageUrl: _existingProduct.imageUrl,
                    description: _existingProduct.description,
                  );
                },
              ),
              TextFormField(
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
                    title: _existingProduct.title,
                    price: double.parse(newValue!),
                    imageUrl: _existingProduct.imageUrl,
                    description: _existingProduct.description,
                  );
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _descFocusNode,
                onSaved: (newValue) {
                  _existingProduct = Product(
                    id: _existingProduct.id,
                    title: _existingProduct.title,
                    price: _existingProduct.price,
                    imageUrl: _existingProduct.imageUrl,
                    description: newValue.toString(),
                  );
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
                          title: _existingProduct.title,
                          price: _existingProduct.price,
                          imageUrl: newValue.toString(),
                          description: _existingProduct.description,
                        );
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
