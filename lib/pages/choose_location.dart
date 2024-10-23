import 'package:flutter/material.dart';
import 'package:word_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png', apiKey: 'T76BSDF2CXKC'),
    WorldTime(url: 'Europe/Berlin', location: 'Berlin', flag: 'germany.png', apiKey: 'T76BSDF2CXKC'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png', apiKey: 'T76BSDF2CXKC'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png', apiKey: 'T76BSDF2CXKC'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png', apiKey: 'T76BSDF2CXKC'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png', apiKey: 'T76BSDF2CXKC'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png', apiKey: 'T76BSDF2CXKC'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png', apiKey: 'T76BSDF2CXKC'),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();

    // Verifica si el widget aún está montado antes de navegar
    if (!mounted) return;

    // Navega a la pantalla de inicio
    var result = {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'apiKey': instance.apiKey,
      'isDaytime': instance.isDaytime
    };
    print(result); // Verifica que el resultado esté correcto
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          'Choose a Location',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
