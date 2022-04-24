import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import '../services/location.dart';

const String apiKey = 'a1fcda43d56ae6c3d755de2a5f4f15d8';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double longitute;
  late double latitute;
  void getLocationData() async {
    Location myLocation = Location();
    await myLocation.getCurrentLocation();
    latitute = myLocation.latitute;
    longitute = myLocation.longitute;
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitute&lon=$longitute&appid=$apiKey');

    var weatherData = await networkHelper.getData();
  }

  @override
  void initState() {
    getLocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Location')),
    );
  }
}
