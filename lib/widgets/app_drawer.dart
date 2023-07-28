import 'package:flutter/material.dart';
import 'package:shopapp/screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello there!'),
          automaticallyImplyLeading: false,
          ),
          const Divider(), // horizontal line
          Card(
            child: ListTile(
              title: const Text('Shop'),
              leading: const Icon(Icons.shop),
              onTap: (){
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
          ),
          const Divider(), // horizontal line
          Card(
            child: ListTile(
              title: const Text('Orders'),
              leading: const Icon(Icons.payment),
              onTap: (){
                Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
