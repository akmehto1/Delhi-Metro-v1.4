import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:delhimetrov/models/station-class.dart';
import 'package:delhimetrov/static%20data/graph-map.dart';


List<List<String>>searchRoute(int source,int destination,bool method){
  int k;
  if(method){
    k=4;
  }
  else{
    k=1;
  }


  // int source=138;
  // int destination=55;
  // gps_alaram();
  // print(source);
  // source=1;
  // destination=10;
  Map<int,List<dynamic>>adj=stationmap();

  Queue<List<dynamic>>queue =Queue();

  PriorityQueue<dynamic> minPriorityQueue = PriorityQueue<dynamic>();

  minPriorityQueue.add([0,[source,[0,-1]]]);
  // final queue= PriorityQueue<List<dynamic>>();
  List<Station>StationList=parseJsonToStationList();


  List<int>distance=List<int>.filled(279,1000000);
  List<int>pathVector=List<int>.filled(279,-1);
  List<String>colorPath=List<String>.filled(279," ");

  // PriorityQueue<int, String> priorityQueue =PriorityQueue<int, String>();



  //         k  node dis parent
  queue.add([0, [source, [0, source]]]);
  distance[source]=0;


  // List<dynamic>? elements =adj[122];
  // print(elements);


  // queue.add([5, [6, [7, 8]]]);
  // queue.add([9, [10, [11, 12]]]);


  while (queue.isNotEmpty) {
    var pair = queue.removeFirst();
    var steps= pair[0];           // Access the first element of the pair
    var nestedPair = pair[1];    // Access the nested pair as a list

    var node = nestedPair[0];        // Access the first element of the nested pair
    var nestedNestedPair = nestedPair[1]; // Access the second nested pair as a list

    var dis = nestedNestedPair[0];        // Access the first element of the second nested pair
    var parent = nestedNestedPair[1];


    if(steps>k || node==destination)continue;


    List<dynamic>? elements = adj[node];
    for (int element in elements!) {
      if(distance[element]>dis+1  && steps<k){
        distance[element]=dis+1;
        pathVector[element]=node;
        // if(parent!=-1 && colorPath[parent]==colorPath[element]){
        //   print("match");
        // }
        // else print("Exchange");

        int childcolorSize=StationList[element].line.length;
        int parentcolorsize=StationList[node].line.length;


        bool check=false;
        String whichColor="blue";

        int parentparentsize=StationList[parent].line.length;
        int childparentsize=StationList[node].line.length;

        for(int i=0;i<parentparentsize;i++){
          for(int j=0;j<childparentsize;j++){
            if(StationList[parent].line[i]==StationList[node].line[j]){
              check=true;
              break;

            }
          }
        }


        for(int i=0;i<childcolorSize;i++){
          for(int j=0;j<parentcolorsize;j++){
            if(StationList[element].line[i]==StationList[node].line[j]){
              whichColor=StationList[element].line[j];
              break;
            }
          }
          // if(StationList[element].line[i]==StationList[node])
          // print(StationList[element].line[i]);
        }

        if(check){
          colorPath[element]=whichColor;
          queue.add([steps, [element, [dis+1, parent]]]);
        }
        else {
          colorPath[element]=whichColor;
          queue.add([steps+1, [element, [dis+1,node]]]);
        }

        // print("${StationList[element].name} ");
      }



    }



  }


  int pre=destination;
  List<int> reversedNumbers=[];
  List<String>ans1=[];
  List<String>ans2=[];
  List<String>reversedcolor=[];




  while( true){
    if(pre==source)break;
    print("pre==$pre   pathvector==${pathVector[pre]}");

    reversedNumbers.add(pathVector[pre]);
    reversedcolor.add(colorPath[pre]);

    pre=pathVector[pre];
  }




  // reversedNumbers.add(source);
  // reversedcolor.add(colorPath[pre]);
  reversedNumbers = reversedNumbers.reversed.toList();
  reversedcolor= reversedcolor.reversed.toList();

// print(reversedNumbers);
// print(reversedcolor);

  String temp="xyz";

  for(int i=0;i<reversedNumbers.length;i++){
    if(StationList[reversedNumbers[i]].name!=temp){
      ans1.add(StationList[reversedNumbers[i]].name);
      ans2.add(reversedcolor[i]);
      temp=StationList[reversedNumbers[i]].name;
      // print(StationList[reversedNumbers[i]].name);
    }

  }

  ans1.add(StationList[destination].name);
  ans2.add(ans2[ans2.length-1]);
  // ans2.insert(0, ans2[0]);
  // ans1.insert(0,StationList[source].name);
  //


  // print(ans1.length);
  //
  // print(ans2.length);

  //
  // print("hello---${pathVector[destination]}");


  return [ans1,ans2];

}