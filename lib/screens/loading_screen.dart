import 'package:flutter/material.dart';
import '../services/location.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocation() async {
    Location myLocation = Location();
    await myLocation.getCurrentLocation();
    // print(myLocation.longitute);
    // print(myLocation.latitute);
  }

  void getData() async {
    http.Response response =
        await http.get(Uri.parse('https://anapioficeandfire.com/api/houses/1'));
    if (response.statusCode == 200) {
      // String data = response.body;
      // print(data);
    } else {
      // print(response.statusCode);
    }
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return const Scaffold(
      body: Center(child: Text('Location')),
    );
  }
}
