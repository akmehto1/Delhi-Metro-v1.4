import 'dart:async';
import 'dart:isolate';

import 'package:delhimetrov/provider/alaram_provider.dart';
import 'package:delhimetrov/shared/widgets/autocomplete_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:provider/provider.dart';


import '../../services/ForegroundTaskService.dart';
import '../../tasks/someTask.dart';

class AlaramPage extends StatefulWidget {
  const AlaramPage({super.key});

  @override
  State<AlaramPage> createState() => _AlaramPageState();
}

class _AlaramPageState extends State<AlaramPage> {

  ReceivePort? receivePort;
  late SomeTask taskObj;

  @override
  void initState(){
    super.initState();

    // This is used to listen to the messages that senderPort sends from ForegroundTaskService we created
    receivePort = FlutterForegroundTask.receivePort;
    taskObj = SomeTask();
    if (receivePort != null){
      receivePort!.listen((data){
        if(data == "startTask"){
          taskObj.performTask();
        }
        else if (data == "killTask"){
          taskObj.killTask();
        }
      });
    }
  }


  void startService()async{
    if (await FlutterForegroundTask.isRunningService) {
      FlutterForegroundTask.restartService();
    }
    else {
      FlutterForegroundTask.startService(
        notificationTitle: 'Foreground Service is running',
        notificationText: 'Tap to return to the app',
        callback: startCallback, // Function imported from ForegroundService.dart
      );

    }

  }


  void stopService() async {
    if (await FlutterForegroundTask.isRunningService) {
      FlutterForegroundTask.stopService();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          title: Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [const Text("Destination Alaram")],
          ),
        ),
        body: Consumer<AlaramProvider>(builder: (context, alaramProvider, child) {
          return SingleChildScrollView(
            child: Container(
              margin:const EdgeInsets.all(10.0),
              child:Column(
                children: [
                  const SizedBox(height: 10.0,),
                  //for destination
                  Autocomplete_text_Widget(alaramProvider),
                  const SizedBox(height: 10.0,),
                  ElevatedButton(onPressed: (){
                    String stationName=alaramProvider.destination.text;
                    alaramProvider.destinationCoordinationFetching(stationName);

                         startService();
                    Timer.periodic(const Duration(seconds:2), (timer) {
                      alaramProvider.fetchingCurrentLocationDataInInterval();
                    });

                  }, child:const Text("Track")),
                  alaramProvider.isTracking?locationWidget(alaramProvider):const SizedBox()
                ],
              ),
            ),
          );
        }));
  }

  Widget locationWidget(alaramProvider){
    TextStyle style1=const TextStyle(
      fontSize:30,
      color:Colors.white,
      fontWeight:FontWeight.bold
    );

    TextStyle style2=const TextStyle(
        fontSize:20,
        color:Colors.white,
        fontWeight:FontWeight.bold
    );
    return AspectRatio(aspectRatio:2/1,
    child:Container(
      decoration:BoxDecoration(
          color:Colors.grey,
       borderRadius:BorderRadius.circular(10.0)
      ),

      child:Column(
        children: [
          Text("Distance Left",style:style1,),
          Text("For Destination",style:style2,),
          alaramProvider.currentLocation != null
              ? Text(
            'Distance: ${alaramProvider.distance} KM',
            style: const TextStyle(fontSize: 30,fontWeight:FontWeight.w700),
          )
              :SizedBox(),
        ],
      ),
    ),
    );
  }
}
