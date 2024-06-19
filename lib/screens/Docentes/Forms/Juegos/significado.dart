import 'package:flutter/material.dart';

class FormSignificado extends StatefulWidget {
  const FormSignificado({super.key});

  @override
  State<FormSignificado> createState() => _Significado();
}

class _Significado extends State<FormSignificado> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Dale un significado'),
    );
  }
}
