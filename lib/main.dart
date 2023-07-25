import 'package:flutter/material.dart';
import 'package:shopapp/provider/cart_provider.dart';
import 'package:shopapp/provider/product_provider.dart';
import 'package:shopapp/screens/product_detail_screen.dart';
import 'package:shopapp/screens/product_overview_screen.dart';
import 'package:shopapp/widgets/product_item.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
        ChangeNotifierProvider(
        // create: (context) => ProductsProvider(),
        // use provider without .value notation in main for greater efficiency
        // but im using .value notation because of the tutorial im watching
        create:(context)=> ProductsProvider(),
        ),
      ChangeNotifierProvider(
        // create: (context) => ProductsProvider(),
        // use provider without .value notation in main for greater efficiency
        // but im using .value notation because of the tutorial im watching
        create:(context)=> CartProvider(),
      ),
    ],
      child: MaterialApp(
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
      ),
    );
  }
}
