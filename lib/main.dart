import 'package:flutter/material.dart';
import 'HomePage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Color(hexColor('#a9c9e7')),
            primarySwatch: Colors.blueGrey),
        home: const HomePage());
  }
}

int hexColor(String c) {
  String sColor = '0xff$c';
  sColor = sColor.replaceAll('#', '');
  int dColor = int.parse(sColor);
  return dColor;
}
