import 'package:flutter/material.dart';

class EditProductsScreen extends StatefulWidget {
  const EditProductsScreen({super.key});
  static const routeName = '/edit-products';

  @override
  State<EditProductsScreen> createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {

  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();

  @override
  void dispose() {
    _priceFocusNode.dispose(); // dispose them otherwise they lead to memory leaks
    _descFocusNode.dispose();
        super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                decoration:const InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration:const InputDecoration(
                  labelText: 'price',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descFocusNode);
                },
                focusNode: _priceFocusNode,
              ),
              TextFormField(
                decoration:const InputDecoration(
                  labelText: 'Description',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _descFocusNode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
