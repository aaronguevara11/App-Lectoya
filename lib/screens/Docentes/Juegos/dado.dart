import 'package:flutter/material.dart';

class DadoPreguntas extends StatefulWidget {
  const DadoPreguntas({super.key});

  @override
  State<DadoPreguntas> createState() => _Dado();
}

class _Dado extends State<DadoPreguntas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Dado de las preguntas'),
    );
  }
}
