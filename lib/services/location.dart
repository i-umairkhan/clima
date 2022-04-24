import 'package:geolocator/geolocator.dart';

class Location {
  late double latitute;
  late double longitute;
  Future<void> getCurrentLocation() async {
    try {
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitute = position.latitude;
      longitute = position.latitude;
    } catch (e) {
      // print(e);
    }
  }
}
