import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  Position? _currentPosition;
  String? _currentAddress;
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_currentPosition != null && _currentAddress != null)
          Text(
            _currentAddress!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: .5,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
      ],
    );
  }

  getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        print(position.latitude);
        print(position.longitude);
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.subLocality}";
        print(_currentAddress);
      });
    } catch (e) {
      print(e);
    }
  }
}
