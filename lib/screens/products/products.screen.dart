import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/controller/product/product.controller.dart';
import 'package:invictus/core/widgets/appbar/invictus-appbar.widget.dart';
import 'package:invictus/core/widgets/card/products/product.card.widget.dart';
import 'package:invictus/core/widgets/input/input.widget.dart';
import 'package:invictus/screens/products/product-manager.screen.dart';
import 'package:invictus/screens/products/product.screen.dart';
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
                    child: SizedBox(
                      height: 50,
                      child: Input(
                        controller: searchController,
                        labelText: 'Digite o nome da venda',
                        rounded: true,
                        prefixIcon: Icon(
                          Icons.search,
                          color: theme.primaryColor,
                        ),
                        onChanged: (String term) {
                          debounce.run(() async {
                            return await productController.searchProducts(term);
                          }).onCancel(() {});
                        },
                      ),
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
                                  ProductScreen(
                                    product: product,
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(12),
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
                                margin:
                                    productController.products.last == product
                                        ? EdgeInsets.symmetric(
                                            horizontal: 24,
                                          )
                                        : EdgeInsets.symmetric(
                                            vertical: 24,
                                            horizontal: 24,
                                          ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (product.imageUrl != null) ...{
                                      ProductCard(
                                        theme: theme,
                                        product: product,
                                      ),
                                    },
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
