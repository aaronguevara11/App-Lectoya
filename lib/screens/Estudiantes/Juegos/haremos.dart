import 'package:flutter/material.dart';

class HaremosHoyEstudiantes extends StatefulWidget {
  const HaremosHoyEstudiantes({super.key});

  @override
  State<HaremosHoyEstudiantes> createState() => _Haremos();
}

class _Haremos extends State<HaremosHoyEstudiantes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Que haremos hoy'),
    );
  }
}
