import 'package:flutter/material.dart';
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
  final Paint linePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3
    ..color = Colors.orangeAccent;

  final Paint circlePaint = Paint()..color = Colors.orangeAccent;

  final Paint insideCirclePaint = Paint()..color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 8,
            offset: Offset.zero,
            spreadRadius: .3,
          ),
        ],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          LineChart(
            linePaint: linePaint,
            width: widget.width,
            height: widget.height,
            data: widget.data,
            showCircles: true,
            circlePaint: circlePaint,
            insideCirclePaint: insideCirclePaint,
            insidePadding: 24,
          ),
        ],
      ),
    );
  }
}
