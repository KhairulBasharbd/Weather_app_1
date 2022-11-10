import 'package:flutter/material.dart';
import 'weather_title.dart';

class MainWidget extends StatelessWidget {
  final String location;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String weather;
  final int humidity;
  final double windSpeed;

  MainWidget(
      {required this.location,
      required this.temp,
      required this.tempMin,
      required this.tempMax,
      required this.weather,
      required this.humidity,
      required this.windSpeed});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
        color: Colors.cyan,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Text(
              "${location.todo.toString()}",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(
                '${temp.toInt().toString()}',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              'High of ${tempMin.toInt().toString()}, Low of ${tempMax.toInt().toString()}',
              style: TextStyle(
                  color: Colors.purple,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
      Expanded(
          child: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            weather_title(
                icon: Icons.thermostat_auto_outlined,
                title: 'Temperature',
                subtitle: '${temp.toString()}'),
            weather_title(
                icon: Icons.cloud_circle_sharp,
                title: 'Weather',
                subtitle: '${weather.toString()}'),
            weather_title(
                icon: Icons.wb_sunny_outlined,
                title: 'Humidity',
                subtitle: '${humidity.toInt().toString()}'),
            weather_title(
                icon: Icons.waves_outlined,
                title: 'Wind',
                subtitle: '${windSpeed.toInt().toString()} MPH  '),
          ],
        ),
      ))
    ]);
  }
}
