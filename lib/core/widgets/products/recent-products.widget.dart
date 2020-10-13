import 'package:flutter/material.dart';
import 'package:invictus/core/models/product/product.model.dart';
import 'package:invictus/services/product/product.service.dart';

class RecentProducts extends StatefulWidget {
  @override
  _RecentProductsState createState() => _RecentProductsState();
}

class _RecentProductsState extends State<RecentProducts> {
  List<Product> products;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    final List productsResponse = await productService.getMany();

    setState(() {
      products =
          productsResponse.map((product) => Product.fromJson(product)).toList();
    });
  }

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
                  child: Text(product.name),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
