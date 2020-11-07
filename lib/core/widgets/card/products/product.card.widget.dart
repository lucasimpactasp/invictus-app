import 'package:flutter/material.dart';
import 'package:invictus/core/models/product/product.model.dart';
import 'package:invictus/utils/currency/currency.utils.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    @required this.theme,
    @required this.product,
  }) : super(key: key);

  final ThemeData theme;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 12, bottom: 6),
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: theme.primaryColor,
                    image: product.imageUrl.isNotEmpty
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(product.imageUrl),
                          )
                        : null,
                  ),
                ),
                Container(
                  width: 150,
                  child: Text(
                    '#${product.id?.substring(0, 8) ?? ''}',
                    style: theme.textTheme.caption,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product?.category?.name ?? '-----',
                  style: theme.textTheme.caption.copyWith(fontSize: 18),
                ),
                Text(
                  product.name ?? '',
                  style: theme.textTheme.headline6,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Quantidade: ',
                        style: theme.textTheme.headline6.copyWith(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: '${product.quantity.toString()}',
                        style: theme.textTheme.headline6.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Text(
                  CurrencyUtil.addCurrencyMask((product.price ?? 0) / 100),
                  style: theme.textTheme.headline6.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
