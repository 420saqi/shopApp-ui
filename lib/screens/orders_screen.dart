import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/orderProvider.dart';
import 'package:shopapp/widgets/order_item.dart';

import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {

  static const routeName = '/All_Orders' ;

  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersData= Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Your Orders'),),
      body: ListView.builder(itemBuilder: (context, index) {
        return OrderItem(orderData: ordersData.orderItemsList[index]);
      },
      itemCount: ordersData.orderItemsList.length,
      ),
      drawer: const AppDrawer(),
    );
  }
}
