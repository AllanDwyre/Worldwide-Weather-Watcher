import 'package:flutter/material.dart';
import 'package:worldwide_weather_watcher/Componements/background_widget.dart';

class ChartBgElements extends StatelessWidget {
  final Size size;

  const ChartBgElements(
    this.size, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const ChartBackgroundWidget(),
      Container(
        height: size.height * 0.57,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(.7),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            )),
      )
    ]);
  }
}
