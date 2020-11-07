import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:invictus/core/models/invoice/installment.model.dart';
import 'package:invictus/core/models/invoice/invoice.model.dart';
import 'package:invictus/utils/banner/banner.utils.dart';
import 'package:invictus/utils/currency/currency.utils.dart';
import 'package:invictus/utils/dates/dates.util.dart';
import 'package:menu_button/menu_button.dart';

class PaymentParcel extends StatefulWidget {
  final Function onChangeParcels;
  final Function(List<Installment>) onUpdateParcels;
  final Function(String) onUpdateTotalValue;
  final GlobalKey<FormState> formKey;
  final Invoice invoice;
  final MoneyMaskedTextController valueController;
  final double width;
  final bool showLabel;

  PaymentParcel({
    this.onChangeParcels,
    this.onUpdateParcels,
    this.onUpdateTotalValue,
    this.formKey,
    this.invoice,
    this.valueController,
    this.width,
    this.showLabel = false,
  });

  @override
  _PaymentParcelState createState() => _PaymentParcelState();
}

class _PaymentParcelState extends State<PaymentParcel> {
  List<int> items = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
  ];

  bool toggle = false;
  bool ignoring = true;
  FocusNode valueFocus;
  List<Installment> parcels = [];
  int selectedItem = 0;
  bool available = false;
  bool loading = false;
  Color paymentColor = Colors.grey[400];
  double paymentFontSize = 14;

  Map<int, Map<String, dynamic>> defaultInstallments;

  void checkInstallment() {
    setState(() {
      if (defaultInstallments != null && defaultInstallments.length > 0) {
        items = defaultInstallments[selectedItem]["items"];
      } else {
        items = [];
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final height = MediaQuery.of(context).size.height - 500;
      defaultInstallments = {
        0: {
          "items": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
          "height": height
        },
        1: {
          "items": [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
          "height": height
        },
        2: {
          "items": [1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
          "height": height
        },
        3: {
          "items": [1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12],
          "height": height
        },
        4: {
          "items": [1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12],
          "height": height
        },
        5: {
          "items": [1, 2, 3, 4, 6, 7, 8, 9, 10, 11, 12],
          "height": height
        },
        6: {
          "items": [1, 2, 3, 4, 5, 7, 8, 9, 10, 11, 12],
          "height": height
        },
        7: {
          "items": [1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12],
          "height": height
        },
        8: {
          "items": [1, 2, 3, 4, 5, 6, 7, 9, 10, 11, 12],
          "height": height
        },
        9: {
          "items": [1, 2, 3, 4, 5, 6, 7, 8, 10, 11, 12],
          "height": height
        },
        10: {
          "items": [1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12],
          "height": height
        },
        11: {
          "items": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12],
          "height": height
        },
        12: {
          "items": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
          "height": height
        },
      };
    });
    valueFocus = FocusNode();
    widget.valueController.addListener(() {});

    if (widget.invoice != null) {
      if (widget.invoice.total != null && widget.invoice.total > 0) {
        setState(() {
          paymentColor = Colors.grey[600];
          ignoring = false;
          paymentFontSize = 16;
        });
      }

      if (widget.invoice.installments != null) {
        if (widget.invoice.installments.length > 0) {
          setState(() => selectedItem = widget.invoice.installments.length);
          widget.invoice.installments.forEach((element) {
            setState(() => parcels.add(element));
          });
        }
      }

      widget.valueController.text = widget.invoice.total?.toString() ?? '000';
    }
  }

  void checkParcels() {
    int total = 0;
    parcels.forEach((value) {
      total += value.price;
    });

    final int moneyValue =
        CurrencyUtil.cleanCurrencyMask(widget.valueController.text);

    if (total > moneyValue) {
      BannerUtils.showErrorBanner(
          'O valor das parcelas está acima do valor total.');
      return;
    }

    if (total < moneyValue) {
      BannerUtils.showErrorBanner(
          'O valor das parcelas está abaixo do valor total.');
      return;
    }

    return;
  }

  DateTime getNextDateParcel(int i) {
    final lastDateParcel = parcels[i].expirationDate;
    final date = DateTime(
        lastDateParcel.year, lastDateParcel.month + 1, lastDateParcel.day);

    return date;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    checkInstallment();

    // Botão personalizado
    final Widget installmentsButton = Container(
      width: widget.width,
      height: 43,
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(),
            Flexible(
              child: Text(
                selectedItem == 0
                    ? 'Prestações'
                    : selectedItem == 1
                        ? 'À Vista'
                        : '${selectedItem.toString()}x',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color:
                        selectedItem == 0 ? Colors.grey[400] : Colors.grey[600],
                    fontSize: selectedItem == 0 ? 12 : 14),
              ),
            ),
            FittedBox(
              fit: BoxFit.fill,
              child: Transform.rotate(
                angle: 90 * pi / 180,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 12,
                      right: 6,
                    ),
                    child: TextField(
                      controller: widget.valueController,
                      focusNode: valueFocus,
                      decoration: InputDecoration(
                        labelText: 'Valor da venda',
                      ),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: paymentFontSize,
                        color: paymentColor,
                      ),
                      onSubmitted: (val) => setState(() => available = true),
                      onChanged: (String text) {
                        setState(() {
                          paymentColor = Colors.grey[600];
                          paymentFontSize = 14;
                          ignoring = false;
                        });

                        final int textValue =
                            CurrencyUtil.cleanCurrencyMask(text);
                        if (text.isNotEmpty && textValue > 100) {
                          setState(() => loading = true);

                          Future.delayed(Duration(milliseconds: 300), () {
                            if (selectedItem != null) {
                              for (var i = 0; i < selectedItem; i++) {
                                if (parcels.asMap().containsKey(i)) {
                                  parcels[i].price = textValue ~/ selectedItem;
                                }
                              }

                              int total = 0;
                              parcels.forEach((value) {
                                total += value.price;
                              });

                              if (total < textValue) {
                                final count = textValue - total;
                                if (parcels.asMap().containsKey(0)) {
                                  setState(() => parcels[0].price += count);
                                }
                              }

                              setState(() => loading = false);
                            }
                          });
                          if (widget.onUpdateTotalValue != null) {
                            widget.onUpdateTotalValue(text);
                          }
                        }
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: IgnorePointer(
                    ignoring: ignoring,
                    child: MenuButton(
                      child: installmentsButton,
                      items: items,
                      label: selectedItem > 0
                          ? Text(
                              'Prestações',
                              style: theme.textTheme.bodyText2.copyWith(
                                fontSize: 10,
                                color: Colors.grey[400],
                              ),
                            )
                          : null,
                      popupHeight: defaultInstallments != null &&
                              defaultInstallments.length > 0
                          ? defaultInstallments[selectedItem]["height"]
                          : MediaQuery.of(context).size.height - 500,
                      scrollPhysics: AlwaysScrollableScrollPhysics(),
                      dontShowTheSameItemSelected: false,
                      itemBuilder: (value) => Container(
                        alignment: Alignment.center,
                        color: Colors.white,
                        padding: EdgeInsets.fromLTRB(
                          18,
                          12,
                          18,
                          12,
                        ),
                        child: Text(
                          value == 0
                              ? 'Prestações'
                              : value == 1
                                  ? 'À Vista'
                                  : '${value.toString()}x',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      toggledChild: Container(
                        child: installmentsButton,
                        color: Colors.white,
                        width: double.infinity,
                      ),
                      divider: Container(
                        height: 1,
                        color: Colors.grey[300],
                      ),
                      onMenuButtonToggle: (btnToggle) {
                        setState(() => toggle = btnToggle);
                      },
                      onItemSelected: (value) {
                        valueFocus.unfocus();
                        FocusScope.of(context).requestFocus(FocusNode());

                        setState(() => loading = true);
                        setState(() => parcels = []);
                        final int moneyValue = CurrencyUtil.cleanCurrencyMask(
                            widget.valueController.text);

                        if (widget.onChangeParcels != null) {
                          widget.onChangeParcels();
                        }

                        Future.delayed(Duration(milliseconds: 300), () {
                          setState(() {
                            selectedItem = value;

                            final dateNow = DateTime.now();

                            for (var i = 0; i < selectedItem; i++) {
                              DateTime initialDate = DateTime(
                                  dateNow.year, dateNow.month + 1, dateNow.day);

                              parcels.add(
                                Installment(
                                  price: moneyValue ~/ selectedItem,
                                  expirationDate: null,
                                ),
                              );

                              parcels[i].expirationDate = i == 0
                                  ? initialDate
                                  : getNextDateParcel(i - 1);
                            }

                            int total = 0;
                            parcels.forEach((value) {
                              total += value.price;
                            });

                            if (total < moneyValue) {
                              final count = moneyValue - total;
                              setState(() => parcels[0].price += count);
                            }
                            if (widget.onUpdateParcels != null) {
                              widget.onUpdateParcels(parcels);
                            }
                            loading = false;
                          });
                        });
                      },
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey[400]),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (selectedItem != null) ...{
            if (selectedItem > 1) ...{
              Padding(
                padding: EdgeInsets.only(
                  bottom: 6,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(),
                    Padding(
                      padding: EdgeInsets.only(left: 24, right: 18),
                      child: Text(
                        'Valor',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: Text(
                        'Vencimento',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              loading
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: selectedItem,
                      padding: EdgeInsets.zero,
                      itemBuilder: (ctx, value) {
                        MoneyMaskedTextController controller =
                            MoneyMaskedTextController(leftSymbol: 'R\$');

                        MaskedTextController dateMaskController =
                            MaskedTextController(mask: '00/00/0000');

                        final DateTime date = parcels[value].expirationDate;
                        final int valParcel = parcels[value].price;

                        final String dateTimeParcel =
                            DateUtils.dateFormatter.format(date);

                        controller.text = valParcel.toString();
                        dateMaskController.text = dateTimeParcel;

                        return Container(
                          margin: EdgeInsets.only(bottom: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                  minWidth: value < 9 ? 35 : 10,
                                ),
                                padding: EdgeInsets.only(right: 12),
                                child: Text(
                                  '${(value + 1).toString()}º',
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: TextField(
                                    controller: controller,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                    onChanged: (val) {
                                      final int parcelValue =
                                          CurrencyUtil.cleanCurrencyMask(val);

                                      parcels[value].price = parcelValue;

                                      checkParcels();
                                      if (widget.onUpdateParcels != null) {
                                        widget.onUpdateParcels(parcels);
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    padding: EdgeInsets.only(left: 6),
                                    child: TextField(
                                      enabled: false,
                                      controller: dateMaskController,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            },
          },
        ],
      ),
    );
  }
}
