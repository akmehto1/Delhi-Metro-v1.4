
import '../models/station-class.dart';
Map<dynamic,int>?stationToCode(){
  List<Station>stationList=parseJsonToStationList();
  int  size=stationList.length;
  Map<String, int> ans = {};
  for(int i=0;i<size;i++){
    String name=stationList[i].name;
    ans[name]=i;
  }
  return ans;
}