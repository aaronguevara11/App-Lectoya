import 'package:flutter/material.dart';

class DaleSignificadoEstudiantes extends StatefulWidget {
  const DaleSignificadoEstudiantes({super.key});

  @override
  State<DaleSignificadoEstudiantes> createState() => _Significado();
}

class _Significado extends State<DaleSignificadoEstudiantes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Dale un significado'),
    );
  }
}
