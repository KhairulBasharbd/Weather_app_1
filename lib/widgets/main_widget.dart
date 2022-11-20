import 'package:flutter/material.dart';
import 'weather_title.dart';
import 'package:time/time.dart';
import 'package:intl/intl.dart';

class MainWidget extends StatelessWidget {
  final String location;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String weather;
  final int humidity;
  final double windSpeed;
  var sunrise;
  var sunset;

  MainWidget(
      {required this.location,
      required this.temp,
      required this.tempMin,
      required this.tempMax,
      required this.weather,
      required this.humidity,
      required this.windSpeed,
      required this.sunrise,
      required this.sunset});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                /*  colorFilter:
                    ColorFilter.mode(Colors.cyanAccent, BlendMode.darken),*/
                image: AssetImage("lib/Image/Back.webp"),
                fit: BoxFit.cover)),
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
        //color: Colors.cyan,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Text(
              "${location.toString()}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(
                '${temp.toInt().toString()}° C',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              'High of ${tempMin.toInt().toString()}° C, Low of ${tempMax.toInt().toString()}° C',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
      Expanded(
          child: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            weather_title(
                icon: Icons.thermostat_auto_outlined,
                title: 'তাপমাত্রা',
                subtitle: '${temp.toString()}° C'),
            weather_title(
                icon: Icons.cloud_circle_sharp,
                title: 'আবহাওয়া',
                subtitle: '${weather.toString()}'),
            weather_title(
                icon: Icons.wb_sunny_outlined,
                title: 'আর্দ্রতা',
                subtitle: '${humidity.toInt().toString()}%'),
            weather_title(
                icon: Icons.waves_outlined,
                title: 'বায়ুপ্রবাহ',
                subtitle: '${windSpeed.toInt().toString()} MPH  '),
            weather_title(
                icon: Icons.sunny,
                title: 'সূর্যোদয়',
                subtitle: formatted(sunrise)),
            weather_title(
                icon: Icons.sunny_snowing,
                title: 'সূর্যাস্ত',
                subtitle: formatted(sunset)),
          ],
        ),
      ))
    ]);
  }

  String formatted(int timeStamp) {
    final DateTime date1 =
        DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return DateFormat('hh:mm a').format(date1);
  }
}
