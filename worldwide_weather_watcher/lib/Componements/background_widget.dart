import 'package:flutter/material.dart';

import '../constants.dart';

class BackGroundWidget extends StatelessWidget {
  const BackGroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/forest.jpg"),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(kBackgroundColor, BlendMode.multiply)))),
      Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  tileMode: TileMode.clamp,
                  stops: const [
            // les positions des couleurs :
            .3,
            .6,
            .6,
            .85
          ],
                  colors: [
            Colors.grey.withOpacity(0.4),
            Colors.white.withOpacity(0),
            Colors.white.withOpacity(0),
            Colors.grey.withOpacity(.5),
          ])))
    ]);
  }
}

class ChartBackgroundWidget extends StatelessWidget {
  const ChartBackgroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: kPrimaryColor.withOpacity(.05)),
    );
  }
}

class ArchiveBackgroundWidget extends StatelessWidget {
  const ArchiveBackgroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black.withOpacity(.4)),
    );
  }
}
