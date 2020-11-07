import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/controller/product/product.controller.dart';
import 'package:invictus/core/models/product/product.model.dart';
import 'package:invictus/core/models/widgets/responsive/responsive.model.dart';
import 'package:invictus/core/widgets/card/products/product.card.widget.dart';
import 'package:invictus/core/widgets/responsive/responsive.widget.dart';
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
    final List<Product> products = productController.products;

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
          if (widget.loading) ...{
            CircularProgressIndicator(),
          } else ...{
            if (products != null) ...{
              if (products.length > 0) ...{
                ResponsiveLayout(
                  mobile: Column(
                    children: products
                        .sublist(0, products.length > 3 ? 3 : products.length)
                        .map((product) {
                      return Container(
                        padding: products.last != product
                            ? const EdgeInsets.only(bottom: 24)
                            : EdgeInsets.zero,
                        width: double.infinity,
                        child: RecentProductCard(
                          products: products,
                          theme: theme,
                          product: product,
                        ),
                      );
                    }).toList(),
                  ),
                  desktop: Row(
                    children: products
                        .sublist(0, products.length > 3 ? 3 : products.length)
                        .map((product) {
                      return RecentProductCard(
                        products: products,
                        theme: theme,
                        product: product,
                      );
                    }).toList(),
                  ),
                ),
              } else ...{
                Text('Não há produtos cadastrados')
              }
            },
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 24),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: theme.primaryColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: RaisedButton(
                onPressed: () {
                  Get.toNamed('/products');
                },
                padding: EdgeInsets.zero,
                elevation: 0,
                color: Colors.transparent,
                child: Text(
                  'Ver todos',
                  style: theme.textTheme.bodyText2.copyWith(
                    color: theme.primaryColor,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 24),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: theme.primaryColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: RaisedButton(
                onPressed: () {
                  Get.toNamed('/product-manager');
                },
                padding: EdgeInsets.zero,
                elevation: 0,
                color: Colors.transparent,
                child: Text(
                  'Cadastrar produto',
                  style: theme.textTheme.bodyText2.copyWith(
                    color: theme.primaryColor,
                  ),
                ),
              ),
            ),
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
