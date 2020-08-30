import 'dart:async';

import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String time;
  String location;
  String url;
  String flag;
  String isDaytime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    Response response = await get('http://worldtimeapi.org/api/timezone/$url');
    Map data = jsonDecode(response.body);
    DateTime dateTime = DateTime.parse(data['datetime']);
    dateTime = dateTime.add(Duration(hours: int.parse(data['utc_offset'].substring(1,3))));
    if (dateTime.hour >= 6 && dateTime.hour < 18) {
      isDaytime = dateTime.hour < 12 ? 'sunrise' : 'day';
    } else {
      isDaytime = dateTime.hour > 0 && dateTime.hour < 6 ? 'night' : 'sunset';
    }
    time = DateFormat.jm().format(dateTime);

  }

}