import 'package:flutter/material.dart';

dynamic getcolor(String color){
  if(color=='red')return Colors.red;

  if(color=='blue') return const Color.fromRGBO(84,118, 208,1);

  if(color=='green')return Colors.green;

  if(color=='pink')return Colors.pink;

  if(color=='violet')return const Color.fromRGBO(128,0,255,1);

  if(color=='yellow')return Colors.yellow;

  if(color=='magenta')return const Color.fromRGBO(255,0,144,1);

  if(color=='aqua')return const Color.fromRGBO(4, 194, 220,1);

  if(color=='grey')return const Color.fromRGBO(112,128,144,1);

  if(color=='orange')return Colors.orange;

  return Colors.amberAccent;
}
