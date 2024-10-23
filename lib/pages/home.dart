import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    // Esperar hasta que el widget esté montado para obtener los datos
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final receivedData = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (receivedData != null) {
        setState(() {
          data = receivedData; // Actualiza la variable de estado 'data'
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Establecer fondo
    String bgImage = data['isDaytime'] == true ? 'day.png' : 'night.png';
    Color? bgColor = data['isDaytime'] == true ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    if (result != null) {
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'flag': result['flag'],
                          'apiKey': result['apiKey'],
                          'isDaytime': result['isDaytime'],
                        };
                      });
                      print(data); // Para depuración
                    }
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: Colors.grey[300],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'] ?? 'Loading...',
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  data['time'] ?? 'Loading...',
                  style: TextStyle(
                    fontSize: 66.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}