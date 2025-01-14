import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // location name for the UI
  String time = ''; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  String apiKey;
  bool isDaytime = false; // true or false if daytime or not

  WorldTime({ required this.location, required this.flag, required this.url, required this.apiKey});

  Future<void> getTime() async {

    try {
      final response = await http.get(Uri.parse('https://api.timezonedb.com/v2.1/get-time-zone?key=$apiKey&format=json&by=zone&zone=$url'));
      //final response =  await http.get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      print(response.body);
      Map data = jsonDecode(response.body);
      //print(data);

      // get properties from data
      /*String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);*/
      String datetime = data['formatted']; // Usa el campo 'formatted'
      String offset = data['gmtOffset'].toString(); // Offset en segundos
      //print(datetime);
      //print(offset);

      // create DateTime object
      /*DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));*/
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(seconds: int.parse(offset))); // Usa segundos en lugar de horas

      // set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }

  }

}
