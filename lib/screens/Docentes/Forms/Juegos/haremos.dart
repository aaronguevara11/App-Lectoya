import 'package:flutter/material.dart';

class FormHaremos extends StatefulWidget {
  const FormHaremos({super.key});

  @override
  State<FormHaremos> createState() => _Haremos();
}

class _Haremos extends State<FormHaremos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Que haremos hoy'),
    );
  }
}
