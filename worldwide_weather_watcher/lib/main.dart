import 'package:flutter/material.dart';

import 'package:worldwide_weather_watcher/Screens/chart/chart_screen.dart';
import 'package:worldwide_weather_watcher/Screens/home/home_screen.dart';
import 'package:worldwide_weather_watcher/constants.dart';

import 'Componements/background_widget.dart';
import 'Componements/bottom_nav_bar.dart';
import 'Screens/archive/archive_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String appTitle = "Worldwide Weather Watcher";
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        primaryColor: kPrimaryColor,
      ),
      home: const MainAppWidget(),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MainAppWidget extends StatelessWidget {
  const MainAppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return Scaffold(
      body: Stack(children: [
        const BackGroundWidget(),
        PageView(
          scrollDirection: Axis.horizontal,
          controller: controller,
          children: const <Widget>[
            HomeScreen(),
            ChartScreen(),
            ArchiveScreen()
          ],
        ),
        const BottomBarWidget()
      ]),
    );
  }
}
