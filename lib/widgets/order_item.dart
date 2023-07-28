import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopapp/provider/orderProvider.dart';

class OrderItem extends StatefulWidget {
   const OrderItem({super.key,required this.orderData});
final OrdersItem orderData;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
bool _expanded =false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.orderData.price}'),
            subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.orderData.dateTime),),
            trailing:  IconButton(
                onPressed: (){
                  setState(() {
                    _expanded= !_expanded ;
                  });
                },
                icon:_expanded ?
                const Icon(Icons.expand_circle_down_outlined) :
                const Icon(Icons.expand_circle_down)),
          ),

          if(_expanded)
          SizedBox(
            height: min(widget.orderData.items.length * 20 +60 , 100),
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical : 4 ,horizontal: 10),
              children: widget.orderData.items.map((prod) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [ Text(prod.title,style:const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),),
                    Text('${prod.quantity} \$${prod.price}',style:const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),),
                    ],
                  ),
                );
              }).toList(),
            )
          ),
        ],
      ),
    );
  }
}
