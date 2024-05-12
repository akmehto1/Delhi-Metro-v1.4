import 'package:delhimetrov/models/station-class.dart';

List<String> locationSuggestionList(){

  List<Station>stationList=parseJsonToStationList();

  List<String>delhiMetroStations=[];
  int size=stationList.length;
  Map<String,int>umap={};


  for(int i=0;i<size;i++){
    if(umap[stationList[i].name]==null){
      delhiMetroStations.add(stationList[i].name);
      umap[stationList[i].name]=1;
    }

  }
  return delhiMetroStations;
}