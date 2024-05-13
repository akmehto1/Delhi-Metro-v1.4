import 'package:delhimetrov/provider/alaram_provider.dart';
import 'package:delhimetrov/provider/homeprovider.dart';
import 'package:delhimetrov/ui/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
    ChangeNotifierProvider(
    create: (context) => HomeProvider(),
    ),
          ChangeNotifierProvider(create:(context)=>AlaramProvider())
    ],
    child:MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      home:HomeView(),
    ));
  }
}
