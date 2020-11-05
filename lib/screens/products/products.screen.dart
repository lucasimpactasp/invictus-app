import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/controller/product/product.controller.dart';
import 'package:invictus/core/models/product/product.model.dart';
import 'package:invictus/core/widgets/appbar/invictus-appbar.widget.dart';
import 'package:invictus/core/widgets/card/products/product.card.widget.dart';
import 'package:invictus/screens/products/product-manager.screen.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ProductController productController = Get.put(ProductController());
    final List<Product> products = productController.products.value;

    return Scaffold(
      appBar: InvictusAppBar.getAppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Get.toNamed('/create-product');
        },
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Text(
                'Itens em estoque',
                style: theme.textTheme.headline5,
              ),
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: 'oi'),
                  decoration: InputDecoration(
                    labelText: 'Digite o nome do produto',
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey[200],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: Colors.grey[200], width: 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
          /* Column(
            children: products == null
                ? []
                : products
                    .map(
                      (product) => GestureDetector(
                        onTap: () {
                          Get.to(
                            ProductManager(
                              product: product,
                            ),
                          );
                        },
                        child: Container(
                          color: Colors.transparent,
                          height: 300,
                          child: ProductCard(
                            theme: theme,
                            product: product,
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ), */
        ],
      ),
    );
  }
}
