import 'package:flutter/material.dart';
import 'package:open_weather_provider/pages/search_page.dart';
import 'package:open_weather_provider/widgets/error_dialog.dart';
import 'package:provider/provider.dart';

import 'package:open_weather_provider/providers/weather/weather_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final WeatherProvider _weatherProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _weatherProvider = context.read<WeatherProvider>();
    _weatherProvider.addListener(_registerListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _weatherProvider.removeListener(_registerListener);
    super.dispose();
  }

  void _registerListener() {
    final WeatherState ws = context.read<WeatherProvider>().state;
    if (ws.status == WeatherStatus.error) {
      errorDialog(context, ws.error.errMsg);
    }
  }

  Widget _showWeather() {
    final state = context.watch<WeatherProvider>().state;
    if (state.status == WeatherStatus.initial) {
      return Center(
        child: Text(
          'Select a city',
          style: TextStyle(fontSize: 20),
        ),
      );
    }

    if (state.status == WeatherStatus.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state.status == WeatherStatus.error && state.weather.name == '') {
      return Center(
        child: Text(
          'Select a city',
          style: TextStyle(fontSize: 20),
        ),
      );
    }

    return Center(
      child: Text(
        state.weather.name,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  String? _city;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        actions: [
          IconButton(
            onPressed: () async {
              _city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SearchPage();
                  },
                ),
              );
              print('city $_city');
              if (_city != null) {
                context.read<WeatherProvider>().fetchWeather(_city!);
              }
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: _showWeather(),
    );
  }
}
