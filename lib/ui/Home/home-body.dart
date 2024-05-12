import 'package:delhimetrov/provider/homeprovider.dart';


import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';





class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeState();
}

class _HomeState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child){
      return Container(
        decoration:BoxDecoration(
            gradient:LinearGradient(
                begin:Alignment.topCenter,
                colors:[
                  Colors.grey.withOpacity(.8),
                  Colors.grey.withOpacity(.5),
                  Colors.grey.withOpacity(.1),
                ]
            )
        ),
        child:SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width:380,
                height:300,

                decoration:BoxDecoration(
                    image:DecorationImage(
                        image:AssetImage('assets/images/core/homeLogo.png')
                    )
                ),
              ).animate().fadeIn().move(delay: 100.ms, duration: 100.ms),

              //source
              Container(
                  margin: const EdgeInsets.symmetric(horizontal:10),
                  child:sourceWidget(homeProvider)
              ).animate().fadeIn() .move(delay: 200.ms, duration: 100.ms) // runs after the above w/new duration
              ,
              SizedBox(height:10,),
              SizedBox(
                height: 50,
                child:
                Center(child: Image.asset("assets/images/core/arrow.png")),
              ).animate().fadeIn() .move(delay: 200.ms, duration: 100.ms),
              SizedBox(height:10,),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal:10),
                  child:destinationWidget(homeProvider)
              ).animate().fadeIn() .move(delay: 300.ms, duration: 100.ms),
              SizedBox(height:20,),
              searchButtonWidget(homeProvider,context).animate().fadeIn() .move(delay: 400.ms, duration: 100.ms),
            ],
          ),
        ),
      );
    });
  }

  Widget sourceWidget(homeProvider){
    return RawAutocomplete(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }else{
          List<String> matches = <String>[];
          matches.addAll(homeProvider.locationSuggestion);

          matches.retainWhere((s){
            return s.toLowerCase().contains(textEditingValue.text.toLowerCase());
          });
          return matches;
        }
      },

      onSelected: (String selection) {
        homeProvider.source.text=selection;
      },

      fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          decoration: const InputDecoration(
              labelText: 'Source',
              prefixIcon: Icon(Icons.location_on_rounded),
              border: OutlineInputBorder()
          ),
          controller: textEditingController,
          focusNode: focusNode,
          onSubmitted: (String value) {

          },
        );
      },

      optionsViewBuilder: (BuildContext context, void Function(String) onSelected,
          Iterable<String> options) {
        return Container(

            decoration:BoxDecoration(
              gradient:LinearGradient(
                begin:Alignment.topRight,
                colors:[
                  Colors.white.withOpacity(.9),
                  Colors.grey.withOpacity(1),
                ]
              )
            ),
            child:SizedBox(
                height: 200,
                child:SingleChildScrollView(
                    child: Column(
                      children: options.map((opt){
                        return InkWell(
                            onTap: (){
                              onSelected(opt);
                            },
                            child:Container(
                                padding: const EdgeInsets.only(right:30),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  child:Text(opt,style:TextStyle(fontWeight:FontWeight.w500),),
                                )

                            )
                        );
                      }).toList(),
                    )
                )
            )
        );
      },
    );
  }

  Widget destinationWidget(homeProvider){

    return RawAutocomplete(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }else{
          List<String> matches = <String>[];
          matches.addAll(homeProvider.locationSuggestion);
          matches.retainWhere((s){
            return s.toLowerCase().contains(textEditingValue.text.toLowerCase());
          });
          return matches;
        }
      },

      onSelected: (String selection) {
        homeProvider.destination.text=selection;
      },

      fieldViewBuilder: (BuildContext context, TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextField(
          decoration: const InputDecoration(
              labelText: 'Destination',
              border: OutlineInputBorder()
          ),
          controller: textEditingController,
          focusNode: focusNode,
          onSubmitted: (String value) {
          },
        );
      },

      optionsViewBuilder: (BuildContext context, void Function(String) onSelected,
          Iterable<String> options) {
        return Container(
            decoration:BoxDecoration(
                gradient:LinearGradient(
                    begin:Alignment.topRight,
                    colors:[
                      Colors.white.withOpacity(.9),
                      Colors.grey.withOpacity(1),
                    ]
                )
            ),
            child:SizedBox(
                height: 200,
                child:SingleChildScrollView(
                    child: Column(
                      children: options.map((opt){
                        return InkWell(
                            onTap: (){
                              onSelected(opt);
                            },
                            child:Container(
                                padding: const EdgeInsets.only(right:30),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  child:Text(opt,style:TextStyle(fontWeight:FontWeight.w500),),
                                )

                            )
                        );
                      }).toList(),
                    )
                )
            )
        );
      },
    );
  }

  Widget searchButtonWidget(homeProvider,context){
    return  GestureDetector(
        onTap:(){

          homeProvider.findRoute(context);

        },
        child:Container(
          width: 300,
          height: 40,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            gradient: LinearGradient(
              colors: [Colors.blueGrey, Colors.grey],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child:Row(
            mainAxisAlignment:MainAxisAlignment.start,
            children: [
              SizedBox(width:10.0,),
              Icon(Icons.search),
              SizedBox(width:80.0,),
              Text("Search",style: TextStyle(fontSize: 20),),
            ],
          ),
        )
    );

  }
  }

