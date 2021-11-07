import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// dart :
import 'package:worldwide_weather_watcher/Componements/background_widget.dart';
import 'package:worldwide_weather_watcher/Componements/data_manager.dart';
import 'package:worldwide_weather_watcher/constants.dart';

//https://www.youtube.com/watch?v=ZtfItHwFlZ8
class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
        children: [const ArchiveBackgroundWidget(), ArchiveBody(size)]);
  }
}

class ArchiveBody extends StatelessWidget {
  final Size size;

  const ArchiveBody(
    this.size, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: kSecondaryPadding,
          vertical: kDefaultPadding,
        ),
        padding: const EdgeInsets.only(
            top: kSecondaryPadding, bottom: kSecondaryPadding),
        height: size.height * 0.76,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          children: [
            Text(
              "DATA TABLE",
              style: GoogleFonts.roboto(
                  color: const Color(0xff101010),
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  shadows: [
                    Shadow(
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(.15),
                    )
                  ]),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 3,
              ),
              padding: const EdgeInsets.only(
                  top: kDefaultPadding, bottom: kSecondaryPadding),
              width: size.width,
              height: 520,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                      spreadRadius: 4,
                      color: Colors.black.withOpacity(.15))
                ],
              ),
              child: const DataBuilder(),
            )
          ],
        ),
      ),
    );
  }
}

class DataBuilder extends StatelessWidget {
  const DataBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> color = <Color>[
      Colors.black.withOpacity(.06),
      Colors.white
    ];

    return FutureBuilder<List<Data>>(
        future: readJsonData(),
        builder: (context, data) {
          if (data.connectionState != ConnectionState.waiting && data.hasData) {
            var dataList = data.data;
            if (dataList!.isNotEmpty) {
              return ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var dataData = dataList[dataList.length - index - 1];
                    return RowData(
                      bgColor: color[index % 2],
                      temperature: dataData.temperature.toInt().toString(),
                      luminosity: dataData.luminosity.toInt().toString(),
                      pressure: dataData.pressure.toInt().toString(),
                      humidity: dataData.humidity.toString(),
                      time: formatDate(dataData.date, [hh, ':', nn, ' ', am])
                          .toString(),
                    );
                  });
            }
            return Container();
          }
          return Container();
        });
  }
}

class RowData extends StatelessWidget {
  const RowData({
    required this.bgColor,
    required this.temperature,
    required this.luminosity,
    required this.pressure,
    required this.humidity,
    required this.time,
    Key? key,
  }) : super(key: key);
  final Color bgColor;
  final String temperature, luminosity, pressure, humidity, time;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          top: BorderSide(
            color: Colors.black.withOpacity(.5),
            width: .2,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            time,
            style: GoogleFonts.roboto(
              color: Colors.black.withOpacity(.5),
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            temperature + "°C",
            style: GoogleFonts.roboto(
              color: Colors.black.withOpacity(.5),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            luminosity + " LUX",
            style: GoogleFonts.roboto(
              color: Colors.black.withOpacity(.5),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            pressure + " hPa",
            style: GoogleFonts.roboto(
              color: Colors.black.withOpacity(.5),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            humidity + " %",
            style: GoogleFonts.roboto(
              color: Colors.black.withOpacity(.5),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "Montpellier,\nHérault",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 11,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
