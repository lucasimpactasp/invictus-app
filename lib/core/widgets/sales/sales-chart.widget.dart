import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invictus/controller/payment/invoice.controller.dart';
import 'package:invictus/core/models/invoice/invoice.model.dart';
import 'package:invictus/core/widgets/button/button.widget.dart';
import 'package:invictus/utils/currency/currency.utils.dart';
import 'package:line_chart/charts/line-chart.widget.dart';
import 'package:line_chart/model/line-chart.model.dart';

class SalesChart extends StatefulWidget {
  final double width;
  final double height;
  final List<LineChartModel> data;

  SalesChart({
    @required this.data,
    @required this.width,
    @required this.height,
  });

  @override
  _SalesChartState createState() => _SalesChartState();
}

class _SalesChartState extends State<SalesChart> {
  final Paint insideCirclePaint = Paint()..color = Colors.white;

  final InvoiceController invoiceController = Get.put(InvoiceController());

  double actualValue;

  String getTotal(List<Invoice> invoices) {
    double total = 0;

    if (invoices != null) {
      total = invoices.fold(
        0,
        (previousValue, element) {
          return previousValue + element.total / 100;
        },
      );
    }

    return CurrencyUtil.addCurrencyMask(total);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<Invoice> invoices = invoiceController.invoices;

    final Paint linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = theme.primaryColor;
    final Paint circlePaint = Paint()..color = theme.primaryColor;

    return Container(
      width: double.infinity,
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
            padding: EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Vendas',
                  style: theme.textTheme.headline5.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total: ${invoices != null ? invoices.length : 0}',
                      style: theme.textTheme.bodyText2,
                    ),
                    Text(
                      actualValue != null
                          ? 'Preço: ${CurrencyUtil.addCurrencyMask(actualValue / 100)}'
                          : 'Preço total: ${this.getTotal(invoices)}',
                      style: theme.textTheme.bodyText2,
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (widget.data.length > 0) ...{
            LineChart(
              linePaint: linePaint,
              width: widget.width,
              height: widget.height,
              data: widget.data,
              showCircles: true,
              circlePaint: circlePaint,
              insideCirclePaint: insideCirclePaint,
              insidePadding: 24,
              showPointer: true,
              linePointerDecoration: BoxDecoration(
                color: theme.primaryColor,
              ),
              pointerDecoration: BoxDecoration(
                color: theme.primaryColor,
                shape: BoxShape.circle,
              ),
              onDropPointer: () {
                setState(() => actualValue = null);
              },
              onValuePointer: (LineChartModelCallback value) {
                setState(() => actualValue = value.chart.amount);
              },
            ),
            Container(
              margin: EdgeInsets.only(
                left: 24,
                right: 24,
              ),
              child: InvictusButton(
                onPressed: () {
                  Get.toNamed('/invoices');
                },
                title: 'Ver todas',
              ),
            )
          },
          Container(
            margin: EdgeInsets.only(
              bottom: 24,
              left: 24,
              right: 24,
            ),
            child: InvictusButton(
              onPressed: () {
                Get.toNamed('/invoice-manager');
              },
              title: 'Cadastrar venda',
            ),
          )
        ],
      ),
    );
  }
}
