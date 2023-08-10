import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/orderProvider.dart';
import 'package:shopapp/widgets/order_item.dart';

import '../widgets/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/All_Orders';

  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {

  late Future _future ;
  @override
  void initState() {
    _future = _orderFuture();
    super.initState();
  }

  Future _orderFuture(){
    return Provider.of<OrderProvider>(context, listen: false).fetchAndSetOrders();
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: FutureBuilder(
        future: _future ,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return OrderItem(orderData: ordersData.orderItemsList[index]);
              },
              itemCount: ordersData.orderItemsList.length,
            );
          }
          else
            {
              return const Center(child: Text('An error occurred'),);
            }
        },
      ),
      drawer: const AppDrawer(),
    );
  }
}
