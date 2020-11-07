import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/core/models/user/user.model.dart';
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

    return widget.user == null
        ? Container()
        : Container(
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
                Text(
                  '${widget.user.firstName} ${widget.user.lastName}',
                  style: theme.textTheme.headline6.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text('Total de vendas: ${widget.user.madeInvoices.length}'),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: 24,
                    left: 24,
                    right: 24,
                  ),
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
                      Get.to(
                        UserManagerScreen(
                          user: widget.user,
                        ),
                      );
                    },
                    padding: EdgeInsets.zero,
                    elevation: 0,
                    color: Colors.transparent,
                    child: Text(
                      'Ver vendedor',
                      style: theme.textTheme.bodyText2.copyWith(
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: 24,
                    left: 24,
                    right: 24,
                  ),
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
                      Get.toNamed('/invoice-manager');
                    },
                    padding: EdgeInsets.zero,
                    elevation: 0,
                    color: Colors.transparent,
                    child: Text(
                      'Ver todos usuários',
                      style: theme.textTheme.bodyText2.copyWith(
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
