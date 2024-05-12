import 'package:delhimetrov/models/station-class.dart';
import 'package:delhimetrov/static%20data/bfs-search-route.dart';
import 'package:delhimetrov/static%20data/location-suggestion-list.dart';
import 'package:delhimetrov/static%20data/station-to-code.dart';
import 'package:delhimetrov/ui/RoutePathPage/routePath.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/showDialogBox.dart';

class HomeProvider with ChangeNotifier{

  List<String> locationSuggestion=locationSuggestionList();
   TextEditingController source = TextEditingController();
   TextEditingController destination = TextEditingController();
  // get source => null;
  late final FocusNode node = FocusNode();


  Map<dynamic, int>? stationToCodeMap=stationToCode();

  findRoute(context){

    int src = stationToCodeMap![source.text]!;
    int des = stationToCodeMap![destination.text]!;
    if (src == null || des == null) {
      return showAlertDialog(context);
    }

    List<List<String>> result =searchRoute(src, des,true);
    if(result.length==0){
      print("not able");
    }
    List<String> routePath = result[0];
    List<String> colorPath = result[1];


    Future.delayed(const Duration(seconds: 2), () {

      Navigator.push(
          context,
        MaterialPageRoute(
           builder: (context) => RoutePath(routePath,
              colorPath, routePath.length)),
      );
    });

  }




}