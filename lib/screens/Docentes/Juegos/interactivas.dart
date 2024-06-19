import 'package:flutter/material.dart';

class PreguntasInteractivas extends StatefulWidget {
  const PreguntasInteractivas({super.key});

  @override
  State<PreguntasInteractivas> createState() => _Interactivas();
}

class _Interactivas extends State<PreguntasInteractivas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Preguntas interactivas'),
    );
  }
}
