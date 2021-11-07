import 'package:date_format/date_format.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worldwide_weather_watcher/Componements/data_manager.dart';
import 'package:worldwide_weather_watcher/constants.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({Key? key, required this.currentPage})
      : super(key: key);
  final int currentPage;
  @override
  _LineChartWidgetState createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  List<int> maxSensorsValue = <int>[
    50,
    800,
    1050,
    100
  ]; // temp , lum , pre , hum
  List<int> minSensorsValue = <int>[0, 0, 1000, 0]; // temp , lum , pre , hum
  List<FlSpot> value = <FlSpot>[];
  List<String> time = <String>[];
  int nombreOfValue = 10 * 6 * 2; // interval = 10 ; 10 * 6 = 1 heure et 1h * 10

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Data>>(
        future: readJsonData(),
        builder: (context, data) {
          if (data.connectionState != ConnectionState.waiting && data.hasData) {
            var dataList = data.data;
            if (dataList!.isNotEmpty) {
              Data dataData;
              for (int i = nombreOfValue; i >= 0; i--) {
                dataData = dataList[dataList.length - i - 1];
                switch (widget.currentPage) {
                  case 0:
                    value.add(FlSpot(
                        (i.toDouble() / nombreOfValue) * 6,
                        ((dataData.temperature.toDouble() -
                                    minSensorsValue[widget.currentPage]
                                        .toDouble()) /
                                (maxSensorsValue[widget.currentPage]
                                        .toDouble() -
                                    minSensorsValue[widget.currentPage]
                                        .toDouble())) *
                            5.0));
                    break;
                  case 1:
                    value.add(FlSpot(
                        (i.toDouble() / nombreOfValue) * 6,
                        ((dataData.luminosity.toDouble() -
                                    minSensorsValue[widget.currentPage]
                                        .toDouble()) /
                                (maxSensorsValue[widget.currentPage]
                                        .toDouble() -
                                    minSensorsValue[widget.currentPage]
                                        .toDouble())) *
                            5.0));
                    break;
                  case 2:
                    value.add(
                      FlSpot(
                          (i.toDouble() / nombreOfValue) * 6,
                          ((dataData.pressure.toDouble() -
                                      minSensorsValue[widget.currentPage]
                                          .toDouble()) /
                                  (maxSensorsValue[widget.currentPage]
                                          .toDouble() -
                                      minSensorsValue[widget.currentPage]
                                          .toDouble())) *
                              5.0),
                    );
                    break;
                  case 3:
                    value.add(FlSpot(
                        (i.toDouble() / nombreOfValue) * 6,
                        ((dataData.humidity.toDouble() -
                                    minSensorsValue[widget.currentPage]
                                        .toDouble()) /
                                (maxSensorsValue[widget.currentPage]
                                        .toDouble() -
                                    minSensorsValue[widget.currentPage]
                                        .toDouble())) *
                            5.0));
                    break;
                  default:
                    break;
                }
                if (i % (nombreOfValue / 6) == 0) {
                  time.add(formatDate(dataData.date, [HH, ':', nn]));
                }
              }
              return GraphBuilder(
                currentPage: widget.currentPage,
                spots: value,
                maxSensorsValue: maxSensorsValue,
                minSensorsValue: minSensorsValue,
                time: time,
              );
            }
          }
          return Container();
        });
  }
}

class GraphBuilder extends StatefulWidget {
  const GraphBuilder({
    Key? key,
    required this.currentPage,
    required this.spots,
    required this.maxSensorsValue,
    required this.minSensorsValue,
    required this.time,
  }) : super(key: key);

  final int currentPage;
  final List<FlSpot> spots;
  final List<String> time;

  final List<int> maxSensorsValue; // temp , lum , pre , hum
  final List<int> minSensorsValue; // temp , lum , pre , hum

  @override
  _GraphBuilderState createState() => _GraphBuilderState();
}

class _GraphBuilderState extends State<GraphBuilder> {
  @override
  Widget build(BuildContext context) {
    final List<String> unitsName = <String>[" °C", " LUX", " hPa", " %"];
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 6,
        minY: 0, //minSensors[widget.currentPage].toDouble()
        maxY: 5, //maxSensors[widget.currentPage].toDouble()
        lineBarsData: [
          LineChartBarData(
            spots: widget.spots,
            colors: [Colors.blue.withOpacity(.5), Colors.cyanAccent],
            isCurved: true,
            curveSmoothness: .3,
            colorStops: [0.0, 1],
            barWidth: 2,
            dotData: FlDotData(
              show: false,
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                return LineTooltipItem(
                  '',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: double.parse(((flSpot.y / 5) *
                                      (widget.maxSensorsValue[
                                              widget.currentPage] -
                                          widget.minSensorsValue[
                                              widget.currentPage]) +
                                  widget.minSensorsValue[widget.currentPage])
                              .toStringAsFixed(2))
                          .toString(),
                      style: TextStyle(
                        color: Colors.grey[100],
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(
                      text: unitsName[widget.currentPage],
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                );
              }).toList();
            },
          ),
        ),
        titlesData: FlTitlesData(
          leftTitles: SideTitles(
            showTitles: true,
            getTitles: (value) {
              return (((widget.maxSensorsValue[widget.currentPage].toDouble() -
                                  widget.minSensorsValue[widget.currentPage]
                                      .toDouble()) /
                              5) *
                          value +
                      widget.minSensorsValue[widget.currentPage].toDouble())
                  .toInt()
                  .toString();
            },
            margin: 10,
            reservedSize: 23,
            getTextStyles: (context, value) => GoogleFonts.roboto(
              color: const Color(0xff8B8B8B),
              fontSize: 10,
            ),
          ),
          bottomTitles: SideTitles(
            showTitles: true,
            getTitles: (value) {
              return widget.time[value.toInt()];
            },
            margin: 15,
            reservedSize: kDefaultPadding,
            getTextStyles: (context, value) => GoogleFonts.roboto(
                color: const Color(0xff8B8B8B), fontSize: 10),
          ),
          rightTitles: SideTitles(showTitles: false),
          topTitles: SideTitles(showTitles: false),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: Colors.black.withOpacity(.1),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: false,
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Colors.black.withOpacity(.1),
              strokeWidth: 1,
            );
          },
        ),
      ),

      swapAnimationDuration: const Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear,
    );
  }
}
