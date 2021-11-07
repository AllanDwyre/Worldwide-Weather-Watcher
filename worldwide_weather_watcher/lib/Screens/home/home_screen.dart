import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worldwide_weather_watcher/Componements/data_manager.dart';
// dart :
import 'package:worldwide_weather_watcher/constants.dart';

import 'Componements/divider_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return HomeBody(size);
  }
}

class HomeBody extends StatelessWidget {
  final Size size;

  const HomeBody(
    this.size, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.04,
            width: 0,
          ),
          const HeroWidget(),
          SizedBox(
            height: size.height * 0.25,
          ),
          Container(
            width: size.width,
            margin: const EdgeInsets.only(left: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                lastUpdate,
                DividerWidget(
                  right: 60,
                  color: kPrimaryColor.withOpacity(.7),
                ),
                const TimeSectionWidget(),
                Container(
                  margin: const EdgeInsetsDirectional.only(
                      top: kSecondaryPadding / 4),
                  width: 500,
                  child: Row(
                    children: const [WeatherIconSection(), WeatherInfo()],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 11),
      child: FutureBuilder<List<Data>>(
          future: readJsonData(),
          builder: (context, data) {
            if (data.connectionState != ConnectionState.waiting &&
                data.hasData) {
              var dataList = data.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Montpellier, Hérault",
                          style: GoogleFonts.roboto(
                              color: kTextColor.withOpacity(.7),
                              fontSize: 16,
                              fontWeight: FontWeight.w300)),
                      const SizedBox(
                        width: 6,
                      ),
                      Text("43.6112422 | 3.8767337",
                          style: GoogleFonts.roboto(
                              color: kTextColor.withOpacity(.8),
                              fontSize: 11,
                              fontWeight: FontWeight.w300)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                          (dataList?[dataList.length - 1]
                                      .luminosity
                                      .toInt()
                                      .toString() ??
                                  "") +
                              " LUX",
                          style: GoogleFonts.roboto(
                              color: kTextColor.withOpacity(.7),
                              fontSize: 12,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(width: 20),
                      Text(
                          (dataList?[dataList.length - 1]
                                      .humidity
                                      .toInt()
                                      .toString() ??
                                  "") +
                              " %",
                          style: GoogleFonts.roboto(
                              color: kTextColor.withOpacity(.7),
                              fontSize: 12,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(width: 20),
                      Text(
                          (dataList?[dataList.length - 1]
                                      .pressure
                                      .toInt()
                                      .toString() ??
                                  "") +
                              " hPa",
                          style: GoogleFonts.roboto(
                              color: kTextColor.withOpacity(.7),
                              fontSize: 12,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Text(
                      (dataList?[dataList.length - 1].temperature.toString() ??
                              "") +
                          "°C",
                      style: GoogleFonts.roboto(
                          color: kTextColor.withOpacity(.9),
                          fontSize: 16,
                          letterSpacing: 1)),
                ],
              );
            }
            return Container();
          }),
    );
  }
}

class WeatherIconSection extends StatelessWidget {
  const WeatherIconSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          color: const Color(0xff7DFFD0),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                offset: const Offset(1, 5),
                blurRadius: 5,
                color: Colors.black.withOpacity(.25))
          ]),
      child: const Icon(
        Icons.cloud_outlined,
        color: kPrimaryColor,
        size: 38,
      ),
    );
  }
}

class TimeSectionWidget extends StatelessWidget {
  const TimeSectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Data>>(
        future: readJsonData(),
        builder: (context, data) {
          if (data.connectionState != ConnectionState.waiting && data.hasData) {
            var dataList = data.data;
            if (dataList!.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatDate(dataList[dataList.length - 1].date,
                            [hh, ':', nn, ' ', am]) +
                        " | Today",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w300,
                        fontSize: 11,
                        letterSpacing: 2,
                        color: kTextColor.withOpacity(.85)),
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: formatDate(
                                  dataList[dataList.length - 1].date, [DD]) +
                              "\n",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w100,
                              fontSize: 46,
                              letterSpacing: 1.5)),
                      TextSpan(
                          text: formatDate(
                              dataList[dataList.length - 1].date, [dd]),
                          style: GoogleFonts.roboto(
                              color: const Color(0xff56BA5A),
                              fontWeight: FontWeight.bold,
                              fontSize: 46,
                              letterSpacing: 1.5)),
                      TextSpan(
                          text: " " +
                              formatDate(
                                  dataList[dataList.length - 1].date, [MM]),
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: 46,
                              letterSpacing: 1.5))
                    ]),
                  ),
                  DividerWidget(
                    right: 20,
                    color: kPrimaryColor.withOpacity(.5),
                  ),
                ],
              );
            }
          }
          return Container();
        });
  }
}

Widget lastUpdate = Text(
  "Last Update",
  style: GoogleFonts.roboto(
    fontWeight: FontWeight.w200,
    fontSize: 34,
    shadows: [
      Shadow(
          offset: const Offset(0, 4),
          blurRadius: 5,
          color: Colors.black.withOpacity(.25))
    ],
  ),
);

class HeroWidget extends StatelessWidget {
  const HeroWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Worldwide Weather\n Watcher",
          style: GoogleFonts.roboto(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              shadows: [
                Shadow(
                    offset: const Offset(0, 4),
                    blurRadius: 5,
                    color: Colors.black.withOpacity(.1))
              ]),
          textAlign: TextAlign.center,
        ),
        const DividerWidget(
            top: 11.0, left: kDefaultPadding * 2, right: kDefaultPadding * 2),
      ],
    );
  }
}
