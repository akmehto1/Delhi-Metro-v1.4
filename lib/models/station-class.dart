import 'dart:convert';

import 'package:delhimetrov/static%20data/station-json-data.dart';


String jsonString=station();

class Station {
  final String name;
  final List<String> line;
  // final double dist;

  Station(this.name, this.line);
}



List<Station> parseJsonToStationList() {
  final Map<String, dynamic> jsonMap = json.decode(jsonString);
  final List<Station> stationList = [];

  jsonMap.forEach((key, value) {
    final name = value["name"] as String;
    final line = (value["line"] as List).cast<String>();
    // final dist = value["dist"] as double;
    // print("${name}  ${dist}");
    final station = Station(name, line);
    stationList.add(station);
  });




  return stationList;
}




//
// void main() {
//   final List<Station> stations = parseJsonToStationList(jsonStr);
//   for (final station in stations) {
//     print("Name: ${station.name}");
//     print("Line: ${station.line}");
//     print("Distance: ${station.dist}");
//     print("\n");
//   }
// }
