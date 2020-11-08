import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/core/models/user/user.model.dart';
import 'package:invictus/core/widgets/button/button.widget.dart';
import 'package:invictus/screens/user/user-manager.screen.dart';

class BestSeller extends StatefulWidget {
  final User user;

  BestSeller({this.user});

  @override
  _BestSellerState createState() => _BestSellerState();
}

class _BestSellerState extends State<BestSeller> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        vertical: 24,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 24,
      ),
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
            padding: EdgeInsets.only(
              bottom: 12,
              top: 12,
            ),
            child: Text(
              'Melhor vendedor',
              style: theme.textTheme.headline5.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (widget.user != null) ...{
            Text(
              '${widget.user.firstName} ${widget.user.lastName}',
              style: theme.textTheme.headline6.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
            Text('Total de vendas: ${widget.user.madeInvoices.length}'),
            InvictusButton(
              onPressed: () {
                Get.to(
                  UserManagerScreen(
                    user: widget.user,
                  ),
                );
              },
              title: 'Ver vendedor',
            ),
          } else ...{
            Text('Não há nenhum vendedor.')
          },
          InvictusButton(
            onPressed: () {
              Get.toNamed('/invoice-manager');
            },
            title: 'Ver todos',
          ),
        ],
      ),
    );
  }
}
