import 'package:flutter/material.dart';


int price=20;
Text getfare(int size){
  if(size<=6){
    price=20;
  }

  else if(size>6 && size<=13){
    price=30;
  }
  else if(size>13 && size<=19){
    price=40;
  }
  else if(size>19 && size<=26)price=50;

  else if(size>26 && size<=38)price=60;

  else price=70;

  return Text("Fare:$price",
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
      // ],
    ),
  );
}
