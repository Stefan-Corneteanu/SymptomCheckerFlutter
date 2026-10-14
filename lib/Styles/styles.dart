import 'package:flutter/material.dart';

Color backgroundWhite = Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE);
Color textBlack = Color.fromARGB(0xFF, 0x19, 0x19, 0x19);
Color myGreen = Color.fromARGB(0xFF, 0x64, 0xCC, 0x03);

ButtonStyle nextButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: myGreen
);

ButtonStyle otherButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.blue
);

TextStyle textSmallStyle = TextStyle(
    fontSize: 25,
    color: textBlack,
);

TextStyle textBigStyle = TextStyle(
    fontSize: 30,
    color: myGreen,
    fontWeight: FontWeight.bold
);

TextStyle textErrorStyle = TextStyle(
    fontSize: 30,
    color: Colors.red,
    fontWeight: FontWeight.bold
);