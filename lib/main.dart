import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import './screens/edit_products.dart';
import './provider/cart_provider.dart';
import './provider/orderProvider.dart';
import './provider/product_provider.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import './screens/user_product_screen.dart';
import './widgets/product_item.dart';

void main() {
  runApp(const MyApp());
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
      ChangeNotifierProvider(create: (context) => OrderProvider(),)
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            iconTheme: const IconThemeData(
              color: Colors.deepOrange,
            ),
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
                 .copyWith(background: Colors.grey.shade300)),
        // home: ProductOverviewScreen(),
        initialRoute: '/',
        routes: {
          '/':(context) => const ProductOverviewScreen(),
          CartScreen.routeName :(context) => const CartScreen(),
          ProductItem.routeName : (context) => const ProductDetailScreen(),
          OrdersScreen.routeName: (context) => const OrdersScreen(),
          UserProductScreen.routeName:(context) => const UserProductScreen(),
          EditProductsScreen.routeName: (context) => const EditProductsScreen(),

        },
      ),
    );
  }
}



