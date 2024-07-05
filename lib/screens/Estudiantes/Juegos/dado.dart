import 'package:flutter/material.dart';

class DadoPreguntasEstudiantes extends StatefulWidget {
  const DadoPreguntasEstudiantes({super.key});

  @override
  State<DadoPreguntasEstudiantes> createState() => _Dado();
}

class _Dado extends State<DadoPreguntasEstudiantes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Dado de las preguntas'),
    );
  }
}
