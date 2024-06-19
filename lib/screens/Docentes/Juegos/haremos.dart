import 'package:flutter/material.dart';

class QueHaremos extends StatefulWidget {
  const QueHaremos({super.key});

  @override
  State<QueHaremos> createState() => _Haremos();
}

class _Haremos extends State<QueHaremos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Que haremos hoy'),
    );
  }
}
