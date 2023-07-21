import 'package:flutter/material.dart';
import 'package:shopapp/screens/product_detail_screen.dart';
import 'package:shopapp/screens/product_overview_screen.dart';
import 'package:shopapp/widgets/product_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          iconTheme: const IconThemeData(
            color: Colors.deepOrange,
          ),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
              .copyWith(background: Colors.grey.shade300)),
      home: ProductOverviewScreen(),
      routes: {
        ProductItem.routeName : (context) => ProductDetailScreen(),
      },
    );
  }
}
