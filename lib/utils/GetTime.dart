import 'package:flutter/material.dart';

Text gettime(int size){
  int time=2;
  time=time*size;
  return Text("Time:$time",
    style:const TextStyle(
      color:Color.fromRGBO(65, 52, 48, 1.0),
      fontWeight:FontWeight.w700,
      fontSize:25,
      // shadows: [
      //   Shadow(
      //     color: Colors.black,
      //     offset: Offset(2, 2),
      //     blurRadius: 3,
      //   ),

    ),
  );
}
