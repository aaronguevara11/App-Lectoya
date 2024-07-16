import 'package:flutter/material.dart';
import 'package:lectoya/api/apiDocentes.dart';

class RespuestasDaleSignificado extends StatefulWidget {
  const RespuestasDaleSignificado({Key? key}) : super(key: key);

  @override
  State<RespuestasDaleSignificado> createState() => _Significado();
}

class _Significado extends State<RespuestasDaleSignificado> {
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
        if (juego != null && juego!['res_significado'] != null) {
          respuestas = (juego!['res_significado'] as List)
              .map((respuesta) => {
                    'nombre': '${respuesta['nombre']} ${respuesta['apaterno']}',
                    'palabra1': respuesta['palabra1'] as String,
                    'palabra2': respuesta['palabra2'] as String,
                    'palabra3': respuesta['palabra3'] as String,
                    'significado1': respuesta['significado1'] as String,
                    'significado2': respuesta['significado2'] as String,
                    'significado3': respuesta['significado3'] as String,
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
            buildWordAndMeaning('Palabra 1:', respuesta['palabra1']!,
                respuesta['significado1']!),
            const SizedBox(height: 7),
            buildWordAndMeaning('Palabra 2:', respuesta['palabra2']!,
                respuesta['significado2']!),
            const SizedBox(height: 7),
            buildWordAndMeaning('Palabra 3:', respuesta['palabra3']!,
                respuesta['significado3']!),
          ],
        ),
      ),
    );
  }

  Widget buildWordAndMeaning(String title, String word, String meaning) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          word,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          'Respuesta del estudiante:',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          meaning,
          style: const TextStyle(fontSize: 16),
        ),
      ],
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
            'Dale un significado',
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
