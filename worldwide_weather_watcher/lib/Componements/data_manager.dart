import 'package:flutter/services.dart' as root_bundle;
import 'dart:convert';
//https://pub.dev/documentation/date_format/latest/date_format/date_format-library.html

class Data {
  final double luminosity;
  final double humidity;
  final double pressure;
  final double temperature;
  final DateTime date;

  Data(this.luminosity, this.humidity, this.pressure, this.temperature,
      this.date);

  Data.fromJson(Map<String, dynamic> json)
      : luminosity = json['luminosity'],
        humidity = json['humidity'],
        pressure = json['atmo_pression'],
        temperature = json['temperature'],
        date = DateTime.parse(json['date']);

  Map<String, dynamic> toJson() => {
        'luminosity': luminosity,
        'humidity': humidity,
        'atmo_pression': pressure,
        'temperature': temperature,
        'date': date,
      };
}

Future<List<Data>> readJsonData() async {
  final jsondata = await root_bundle.rootBundle.loadString('assets/data.json');
  final list = json.decode(jsondata) as List<dynamic>;
  return list.map((e) => Data.fromJson(e)).toList();
}
