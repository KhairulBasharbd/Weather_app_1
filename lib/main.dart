import 'widgets/main_widget.dart';

import 'package:flutter/material.dart';
import 'package:weather_app_1/widgets/weather_title.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:geolocator/geolocator.dart';

Future<WeatherInfo> fetchWeather() async {
  //const zipCode = "6205";
  var lat = _MyApp().lat;
  //var lat = "24.37019177228249";
  //var lon = "88.6371962195062";
  var lon = _MyApp().lon;
  print('${lon} in 16');
  print('${lat} in 17');

  final apiKey = "5385ee950371ca21a34d833d96b3a9b7";
  final requestUrl =
      "https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${apiKey}&units=metric";
  final response = await http.get(Uri.parse(requestUrl));
  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Error loading request URL info ${response.statusCode}");
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
  var sunrise;
  var sunset;

  WeatherInfo(
      {required this.location,
      required this.temp,
      required this.tempMin,
      required this.tempMax,
      required this.weather,
      required this.humidity,
      required this.windSpeed,
      required this.sunrise,
      required this.sunset});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
        location: json['name'],
        temp: json['main']['temp'],
        tempMin: json['main']['temp_min'],
        tempMax: json['main']['temp_max'],
        weather: json['weather'][0]['description'],
        humidity: json['main']['humidity'],
        windSpeed: json['wind']['speed'],
        sunrise: json['sys']['sunrise'],
        sunset: json['sys']['sunset']);
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
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String lat = "24.37019177228249", lon = "88.6371962195062";
  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    checkGps();
    super.initState();
    //checkGps();
    futureWeather = fetchWeather();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    lon = position.longitude.toString();
    lat = position.latitude.toString();
    setState(() {
      //refresh UI
    });
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
            sunrise: snapshot.data!.sunrise,
            sunset: snapshot.data!.sunset,
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
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
