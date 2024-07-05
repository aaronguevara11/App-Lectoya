import 'package:flutter/material.dart';

class HaremosHoy extends StatefulWidget {
  const HaremosHoy({super.key});

  @override
  State<HaremosHoy> createState() => _Haremos();
}

class _Haremos extends State<HaremosHoy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Que haremos hoy'),
    );
  }
}
