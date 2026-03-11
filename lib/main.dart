// main.dart

import 'package:flutter/material.dart';
import 'ui/solar_system_view.dart';

void main() {

  runApp(const SolarApp());

}

class SolarApp extends StatelessWidget {

  const SolarApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SolarSystemView(),
      ),
    );

  }

}