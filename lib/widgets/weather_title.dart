import 'package:flutter/material.dart';

class weather_title extends StatelessWidget {
  var icon;
  var title;
  var subtitle;

  // ignore: use_key_in_widget_constructors
  weather_title(
      {@required this.icon, @required this.title, @required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20.0,
            color: Colors.purpleAccent,
          )
        ],
      ),
      title: Text(
        title,
        style: TextStyle(
            //color: Colors.red,
            fontSize: 20.0,
            fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
            color: Colors.amber, fontSize: 16.0, fontWeight: FontWeight.normal),
      ),
    );
  }
}
