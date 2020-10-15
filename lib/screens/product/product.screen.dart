import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/controller/product/product.controller.dart';
import 'package:invictus/core/models/product/product.model.dart';
import 'package:invictus/utils/currency/currency.utils.dart';

class ProductScreen extends StatefulWidget {
  final String id;

  ProductScreen({this.id});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    productController.getOne(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final Product product = productController.activeProduct.value;
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(maxWidth: 1200),
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              decoration: product.imageUrl == null
                  ? null
                  : BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          product.imageUrl,
                        ),
                      ),
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Obx(
                      () => Text(
                        product.id ?? '',
                      ),
                    ),
                    //Text(product.name ?? ''),
                    //Text('Quantidade: ${product.quantity?.toString() ?? ''}'),
                    //Text(
                    //CurrencyUtil.addCurrencyMask(product.price ?? 0),
                    //),
                    //Text('Dimensão: ${product.dimension ?? ''}'),
                  ],
                ),
                Wrap(
                  children: [
                    //Container(child: ),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    blurRadius: 8,
                    offset: Offset.zero,
                    spreadRadius: .3,
                  ),
                ],
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Text('Observações'),
                  Text(product.description ?? ''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
