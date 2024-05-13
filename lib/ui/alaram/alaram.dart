import 'dart:async';

import 'package:delhimetrov/provider/alaram_provider.dart';
import 'package:delhimetrov/shared/widgets/autocomplete_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlaramPage extends StatefulWidget {
  const AlaramPage({super.key});

  @override
  State<AlaramPage> createState() => _AlaramPageState();
}

class _AlaramPageState extends State<AlaramPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text("Destination Alaram"),
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

                    Timer.periodic(Duration(seconds:2), (timer) {
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
    TextStyle _style1=TextStyle(
      fontSize:30,
      color:Colors.white,
      fontWeight:FontWeight.bold
    );

    TextStyle _style2=TextStyle(
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
          Text("Distance Left",style:_style1,),
          Text("For Destination",style:_style2,),
          alaramProvider.currentLocation != null
              ? Text(
            'Distance: ${alaramProvider.distance} KM',
            style: TextStyle(fontSize: 30,fontWeight:FontWeight.w700),
          )
              : CircularProgressIndicator(),
        ],
      ),
    ),
    );
  }
}
