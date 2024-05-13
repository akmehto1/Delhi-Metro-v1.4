
import 'dart:math';

import 'package:delhimetrov/services/location_service.dart';
import 'package:delhimetrov/static%20data/location-suggestion-list.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vibration/vibration.dart';
import '../static data/location_coordination_data.dart';

class AlaramProvider with ChangeNotifier{


  double lat=-1.0;
  double lon=-1.0;

  LocationService locationService = LocationService();
  Position? currentLocation;
  double?distance;


  double gpsCoordinateToDistance(lat1, lon1, lat2, lon2) {
    const p = 0.017453292519943295;
    final a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) *
            cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p)) /
            2;
    return 12742 * asin(sqrt(a));
  }
  double roundOff(double distance){
    String doubletostring=distance.toStringAsFixed(2);

    double doubleValue = double.parse(doubletostring);
    return doubleValue;
  }


  void fetchingCurrentLocationDataInInterval()async{
    Position position = await locationService.getLocation();

    currentLocation =position;

    // print(find.second);
    distance=gpsCoordinateToDistance(currentLocation!.latitude,currentLocation!.longitude,lat,lon);
    distance=roundOff(distance!);


    if(distance!<.100){
      Vibration.vibrate(pattern: [500, 1000, 500, 2000]);
    }
    if(distance!<10000){
      Vibration.vibrate(pattern: [500, 1000, 500, 2000]);
    }

    notifyListeners();
  }


  bool isTracking=true;
  List<String> locationSuggestion=locationSuggestionList();
  TextEditingController destination = TextEditingController();
  // get source => null;
  late final FocusNode node = FocusNode();


  void  destinationCoordinationFetching (String name) {

     lat=locationCoordinationMap[name]!.first;
     lon=locationCoordinationMap[name]!.second;

    return;
  }




}