import 'package:flutter/material.dart';
import 'package:invictus/core/widgets/card/products/product.card.widget.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Text(
                    'Itens em estoque',
                    style: theme.textTheme.headline5,
                  ),
                  TextField(
                    controller: TextEditingController(text: 'oi'),
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
                  ),
                ],
              ),
              Column(
                children: [
                  ProductCard(theme: theme, product: null),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
