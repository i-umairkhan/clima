import 'package:clima/services/networking.dart';
import '../services/location.dart';

const String apiKey = 'a1fcda43d56ae6c3d755de2a5f4f15d8';
const String openWeatherUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location myLocation = Location();
    await myLocation.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherUrl?lat=${myLocation.latitute}&lon=${myLocation.longitute}&appid=$apiKey&units=metric');

    final weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
