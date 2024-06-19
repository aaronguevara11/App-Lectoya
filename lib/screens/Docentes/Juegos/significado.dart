import 'package:flutter/material.dart';

class DaleSignificado extends StatefulWidget {
  const DaleSignificado({super.key});

  @override
  State<DaleSignificado> createState() => _Significado();
}

class _Significado extends State<DaleSignificado> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Dale un significado'),
    );
  }
}
