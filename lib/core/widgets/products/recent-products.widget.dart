import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/controller/product/product.controller.dart';
import 'package:invictus/core/models/product/product.model.dart';
import 'package:invictus/core/models/widgets/responsive/responsive.model.dart';
import 'package:invictus/core/widgets/button/button.widget.dart';
import 'package:invictus/core/widgets/card/products/product.card.widget.dart';
import 'package:invictus/core/widgets/responsive/responsive.widget.dart';
import 'package:invictus/main.dart';
import 'package:invictus/screens/products/product.screen.dart';
import 'package:invictus/services/product/product.service.dart';
import 'package:invictus/utils/currency/currency.utils.dart';
import 'package:invictus/utils/responsive/responsive.utils.dart';

class RecentProducts extends StatefulWidget {
  final bool loading;

  RecentProducts({this.loading});

  @override
  _RecentProductsState createState() => _RecentProductsState();
}

class _RecentProductsState extends State<RecentProducts> {
  final productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Text(
              'Itens adicionados recentemente',
              style: theme.textTheme.headline5.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (widget.loading) ...{
            CircularProgressIndicator(),
          } else ...{
            Obx(() {
              if (productController.productsValue != null) {
                if (productController.productsValue.length > 0) {
                  return Column(
                    children: [
                      ResponsiveLayout(
                        mobile: Column(
                          children: productController.productsValue
                              .sublist(
                                  0,
                                  productController.productsValue.length > 3
                                      ? 3
                                      : productController.productsValue.length)
                              .map((product) {
                            return Container(
                              padding: productController.productsValue.last !=
                                      product
                                  ? const EdgeInsets.only(bottom: 24)
                                  : EdgeInsets.zero,
                              width: double.infinity,
                              child: RecentProductCard(
                                products: productController.productsValue,
                                theme: theme,
                                product: product,
                              ),
                            );
                          }).toList(),
                        ),
                        desktop: Row(
                          children: productController.productsValue
                              .sublist(
                                  0,
                                  productController.productsValue.length > 3
                                      ? 3
                                      : productController.productsValue.length)
                              .map((product) {
                            return RecentProductCard(
                              products: productController.productsValue,
                              theme: theme,
                              product: product,
                            );
                          }).toList(),
                        ),
                      ),
                      InvictusButton(
                        backgroundColor: theme.primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          Get.toNamed('/products');
                        },
                        title: 'Ver todos',
                      ),
                    ],
                  );
                } else {
                  return Text('Não há produtos cadastrados');
                }
              }

              return Container();
            }),
            if (InvictusApp.role == 'admin') ...{
              InvictusButton(
                backgroundColor: theme.primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  Get.toNamed('/product-manager');
                },
                title: 'Cadastrar produto',
              ),
            },
          },
        ],
      ),
    );
  }
}

class RecentProductCard extends StatelessWidget {
  const RecentProductCard({
    Key key,
    @required this.products,
    @required this.product,
    @required this.theme,
  }) : super(key: key);

  final List<Product> products;
  final Product product;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: RecentProductCardContent(
        product: product,
        products: products,
        theme: theme,
      ),
      desktop: Flexible(
        child: RecentProductCardContent(
          product: product,
          products: products,
          theme: theme,
        ),
      ),
    );
  }
}

class RecentProductCardContent extends StatelessWidget {
  const RecentProductCardContent({
    Key key,
    @required this.product,
    @required this.products,
    @required this.theme,
  }) : super(key: key);

  final Product product;
  final List<Product> products;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final BoxDecoration boxDecoration = BoxDecoration(
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
    );
    return GestureDetector(
      onTap: () => Get.to(
        ProductScreen(
          product: product,
        ),
      ),
      child: ResponsiveLayout(
        mobile: Container(
          padding: EdgeInsets.all(12),
          decoration: boxDecoration,
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
        desktop: Container(
          padding: EdgeInsets.all(12),
          margin: products.last == product
              ? EdgeInsets.zero
              : EdgeInsets.only(bottom: 12),
          decoration: boxDecoration,
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
    );
  }
}
