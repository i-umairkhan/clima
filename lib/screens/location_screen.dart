import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import '../services/weather.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({required this.locationData, Key? key})
      : super(key: key);
  final dynamic locationData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late int temprature;
  late int condishion;
  late String cityName;
  late String weatherIcon;
  late String meesage;

  @override
  void initState() {
    updateUI(widget.locationData);
    super.initState();
  }

  void updateUI(dynamic weathrData) {
    setState(() {
      if (weathrData == null) {
        temprature = 0;
        cityName = '';
        weatherIcon = ':)';
        meesage = 'Erroe unable to get data';
      }
      double temp = weathrData['main']['temp'];
      temprature = temp.toInt();
      condishion = weathrData['weather'][0]['id'];
      cityName = weathrData['name'];
      weatherIcon = weather.getWeatherIcon(condishion);
      meesage = weather.getMessage(temprature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedNmae = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CityScreen()));

                      if (typedNmae != null) {
                        var weathetdata =
                            await weather.getCityWeather(typedNmae);
                        updateUI(weathetdata);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temprature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '$meesage in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
