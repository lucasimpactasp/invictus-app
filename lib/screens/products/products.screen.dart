import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/controller/product/product.controller.dart';
import 'package:invictus/core/widgets/appbar/invictus-appbar.widget.dart';
import 'package:invictus/core/widgets/card/products/product.card.widget.dart';
import 'package:invictus/screens/products/product-manager.screen.dart';
import 'package:invictus/utils/debounce/debounce.util.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductController productController = Get.put(ProductController());
  final TextEditingController searchController = TextEditingController();
  final Debounce debounce = Debounce(Duration(milliseconds: 500));

  @override
  void initState() {
    productController.getMany();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: InvictusAppBar.getAppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Get.toNamed('/product-manager');
        },
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Itens em estoque',
                      style: theme.textTheme.headline5,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        labelText: 'Digite o nome do produto',
                        icon: Icon(
                          Icons.search,
                          color: Colors.grey[200],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide:
                              BorderSide(color: Colors.grey[200], width: 1),
                        ),
                      ),
                      onChanged: (String term) {
                        debounce.run(() async {
                          return await productController.searchProducts(term);
                        }).onCancel(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: productController.products == null
                      ? []
                      : productController.products
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
                                margin:
                                    productController.products.last == product
                                        ? EdgeInsets.zero
                                        : EdgeInsets.symmetric(vertical: 24),
                                child: Row(
                                  children: [
                                    ProductCard(
                                      theme: theme,
                                      product: product,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
