import 'package:flutter/material.dart';

class FormDado extends StatefulWidget {
  const FormDado({super.key});

  @override
  State<FormDado> createState() => _Dado();
}

class _Dado extends State<FormDado> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Dado de las preguntas'),
    );
  }
}
