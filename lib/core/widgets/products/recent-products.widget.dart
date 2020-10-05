import 'package:flutter/material.dart';

class RecentProducts extends StatefulWidget {
  @override
  _RecentProductsState createState() => _RecentProductsState();
}

class _RecentProductsState extends State<RecentProducts> {
  List products = [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 8,
            offset: Offset.zero,
            spreadRadius: .3,
          ),
        ],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text('Itens recentes'),
          Row(
            children: products.map((product) {
              return Expanded(
                child: Container(
                  child: Text(product.toString()),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
