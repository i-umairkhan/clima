import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../screens/location_screen.dart';
import '../services/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double longitute;
  late double latitute;
  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LocationScreen(
          locationData: weatherData,
        );
      }),
    );
  }

  @override
  void initState() {
    getLocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SpinKitDoubleBounce(
        color: Colors.amber,
        size: 100,
      ),
    );
  }
}
