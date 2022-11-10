import 'widgets/main_widget.dart';

import 'package:flutter/material.dart';
import 'package:weather_app_1/widgets/weather_title.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<WeatherInfo> fetchWeather() async {
  const zipCode = "6205";
  final apiKey = "5385ee950371ca21a34d833d96b3a9b7";
  final requestUrl =
      "https://api.openweathermap.org/data/2.5/weather?zip=${zipCode},bd&appid=${apiKey}";
  final response = await http.get(Uri.parse(requestUrl));
  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Error loading request URL info");
  }
}

class WeatherInfo {
  final String location;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String weather;
  final int humidity;
  final double windSpeed;

  WeatherInfo(
      {required this.location,
      required this.temp,
      required this.tempMin,
      required this.tempMax,
      required this.weather,
      required this.humidity,
      required this.windSpeed});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
        location: json['name'],
        temp: json['main']['temp'],
        tempMin: json['main']['temp_min'],
        tempMax: json['main']['temp_max'],
        weather: json['weather'][0]['description'],
        humidity: json['main']['humidity'],
        windSpeed: json['wind']['speed']);
  }
}

void main() => runApp(MaterialApp(
      title: 'Weather app',
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  late Future<WeatherInfo> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<WeatherInfo>(
      future: futureWeather,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MainWidget(
            location: snapshot.data!.location,
            temp: snapshot.data!.temp,
            tempMin: snapshot.data!.tempMin,
            tempMax: snapshot.data!.tempMax,
            weather: snapshot.data!.weather,
            humidity: snapshot.data!.humidity,
            windSpeed: snapshot.data!.windSpeed,
          );
        } else {
          return Center(
            child: Text(
              '${snapshot.error}',
              selectionColor: Colors.redAccent,
            ),
          );
        }
      },
    ));
  }
}
