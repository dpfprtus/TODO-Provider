import 'package:flutter/material.dart';
import 'package:open_weather_provider/constants/constants.dart';
import 'package:open_weather_provider/pages/search_page.dart';
import 'package:open_weather_provider/pages/settings_page.dart';
import 'package:open_weather_provider/providers/providers.dart';
import 'package:open_weather_provider/widgets/error_dialog.dart';
import 'package:provider/provider.dart';

import 'package:open_weather_provider/providers/weather/weather_provider.dart';
import 'package:recase/recase.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final WeatherProvider _weatherProvider;
  late final void Function() _removeListener;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _weatherProvider = context.read<WeatherProvider>();
    _removeListener = _weatherProvider.addListener(_registerListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _removeListener();
    super.dispose();
  }

  void _registerListener(WeatherState ws) {
    if (ws.status == WeatherStatus.error) {
      errorDialog(context, ws.error.errMsg);
    }
  }

  String showTemparature(double temparature) {
    final tempUnit = context.watch<TempSettingsState>().tempUnit;
    if (tempUnit == TempUnit.fahrenheit) {
      return (temparature * 9 / 5 + 32).toStringAsFixed(2) + '℉';
    }
    return temparature.toStringAsFixed(2) + '℃';
  }

  Widget _showWeather() {
    final state = context.watch<WeatherState>();
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

    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 6,
        ),
        Text(
          state.weather.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              TimeOfDay.fromDateTime(state.weather.lastUpdated).format(context),
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '(${state.weather.country})',
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
        SizedBox(
          height: 60,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              showTemparature(state.weather.temp),
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              children: [
                Text(
                  showTemparature(state.weather.tempMax),
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  showTemparature(state.weather.tempMin),
                  style: TextStyle(fontSize: 16),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Spacer(),
            showIcon(state.weather.icon),
            Expanded(flex: 3, child: formatText(state.weather.description)),
            Spacer(),
          ],
        )
      ],
    );
  }

  Widget showIcon(String icon) {
    //이미지를 받아오기 까지 로딩되는 이미지
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/loading.gif',
      image: 'http://$kIconHost/img/wn/$icon@4x.png',
      width: 96,
      height: 96,
    );
  }

  Widget formatText(String description) {
    //recase 패키지를 이용해 매 단어의 시작이 대문자인 titleCase로 변환.
    final formattedString = description.titleCase;
    return Text(
      formattedString,
      style: TextStyle(fontSize: 24),
      textAlign: TextAlign.center,
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
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SettingsPage();
                  },
                ),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: _showWeather(),
    );
  }
}
