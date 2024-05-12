import 'package:flutter/material.dart';

void showAlertDialog(context) {
  // int randomNumber = generateRandomNumber(1, 10); // Close the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.yellow,
        title: const Text('Something Miss'),
        content: SizedBox(
            width: 100,
            height: 100,
            // child: Image.asset("assets/images/show$randomNumber.gif")),
      child: Image.asset("assets/images/default/loading.gif")),
        actions: <Widget>[
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      );
    },
  );
}