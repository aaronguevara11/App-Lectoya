import 'package:flutter/material.dart';
import 'package:lectoya/api/apiDocentes.dart';

class RespuestasDadoPreguntas extends StatefulWidget {
  const RespuestasDadoPreguntas({Key? key}) : super(key: key);

  @override
  State<RespuestasDadoPreguntas> createState() => _Dado();
}

class _Dado extends State<RespuestasDadoPreguntas> {
  final DocentesAPI docentesAPI = DocentesAPI();
  List<Map<String, String>> respuestas = [];
  Map<String, dynamic>? juego;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final data = await docentesAPI.VerRespuestas();
      setState(() {
        juego = data['juego'];
        if (juego != null && juego!['respuesta_dado'] != null) {
          respuestas = (juego!['respuesta_dado'] as List)
              .map((respuesta) => {
                    'nombre': '${respuesta['nombre']} ${respuesta['apaterno']}',
                    'pregunta': respuesta['pregunta'] as String,
                    'respuesta': respuesta['respuesta'] as String,
                  })
              .toList();
        }
      });
    } catch (e) {
      print('Error al cargar los datos: $e');
    }
  }

  Widget buildRespuestaCard(Map<String, String> respuesta) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              respuesta['nombre']!,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            const SizedBox(height: 3),
            const Text(
              'Pregunta del juego:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              respuesta['pregunta']!,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              'Respuesta del estudiante:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              respuesta['respuesta']!,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 9, 36, 82),
          title: const Text(
            'El dado de las preguntas',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 26,
            ),
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Respuestas'.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const Divider(),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: respuestas.length,
                  itemBuilder: (context, index) {
                    final respuesta = respuestas[index];
                    return buildRespuestaCard(respuesta);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
