import 'dart:math';

import 'package:delhimetrov/ui/Home/home-body.dart';
import 'package:delhimetrov/ui/alaram/alaram.dart';
import 'package:delhimetrov/ui/map/map-page.dart';

import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Map', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Theme', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('History',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];
  final PageController _controller = PageController(initialPage: 0);
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      print(index);
      _controller.animateToPage(
        index, // Index of page 3
        duration: Duration(milliseconds: 10),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
        actions: [
          IconButton(onPressed:(){}, icon:Icon(Icons.access_alarms_rounded))
        ],
        title:Row(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Text("Delhi Metro",style:TextStyle(color:Colors.black,fontSize:32,fontWeight:FontWeight.bold),)
          ],
        )
      ),
      body:Body(),
      bottomNavigationBar: bottomNavigation(),
    );
  }

  Widget  Body() {
    return PageView(
      onPageChanged:_onItemTapped,
      controller: _controller,
      children: [
        HomeBody(),
        AlaramPage(),
        Container(
          color: Colors.green,
          child: Center(
            child: Text('Page 3'),
          ),
        ),
       mapPage()
      ],
    );
  }

  Widget bottomNavigation() {
    return Container(
      height: 80,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: _selectedIndex == 0 ? 40 : 25,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm,size: _selectedIndex == 1 ? 40 : 25,),
            label: 'Alaram',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map,size: _selectedIndex == 2 ? 40 : 25,),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map,size: _selectedIndex == 3 ? 40 : 25,),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:Color.fromRGBO(137, 107, 74,1),
        onTap: _onItemTapped,
        backgroundColor:Colors.white24,

      ),
    );
  }
}
