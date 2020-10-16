import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/controller/product/product.controller.dart';
import 'package:invictus/core/models/product/product.model.dart';
import 'package:invictus/core/widgets/card/products/product.card.widget.dart';
import 'package:invictus/screens/product/product.screen.dart';
import 'package:invictus/services/product/product.service.dart';
import 'package:invictus/utils/currency/currency.utils.dart';

class RecentProducts extends StatefulWidget {
  @override
  _RecentProductsState createState() => _RecentProductsState();
}

class _RecentProductsState extends State<RecentProducts> {
  final productController = Get.put(ProductController());
  bool loading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setState(() {
      loading = true;
    });
    await productController.getMany();

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
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
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Text(
              'Itens adicionados recentemente',
              style: theme.textTheme.headline5,
            ),
          ),
          loading
              ? CircularProgressIndicator()
              : Obx(() {
                  final List<Product> products = productController.products;

                  return Row(
                    children: products
                        .sublist(0, products.length > 3 ? 3 : products.length)
                        .map((product) {
                      return Flexible(
                        child: GestureDetector(
                          onTap: () => Get.off(
                            ProductScreen(
                              id: product.id,
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(12),
                            margin: products.last == product
                                ? EdgeInsets.zero
                                : EdgeInsets.only(right: 12),
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProductCard(
                                  theme: theme,
                                  product: product,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
        ],
      ),
    );
  }
}
