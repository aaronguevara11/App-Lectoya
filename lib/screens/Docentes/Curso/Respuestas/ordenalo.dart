import 'package:flutter/material.dart';
import 'package:lectoya/api/apiDocentes.dart';

class RespuestasOrdenaloYa extends StatefulWidget {
  const RespuestasOrdenaloYa({Key? key}) : super(key: key);

  @override
  State<RespuestasOrdenaloYa> createState() => _Ordenalo();
}

class _Ordenalo extends State<RespuestasOrdenaloYa> {
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
        if (juego != null && juego!['res_ordenalo'] != null) {
          respuestas = (juego!['res_ordenalo'] as List)
              .map((respuesta) => {
                    'nombre': '${respuesta['nombre']} ${respuesta['apaterno']}',
                    'orden1': respuesta['orden1'] as String,
                    'orden2': respuesta['orden2'] as String,
                    'orden3': respuesta['orden3'] as String,
                    'orden4': respuesta['orden4'] as String,
                    'orden5': respuesta['orden5'] as String,
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
            buildOrderedWord('Primer:', respuesta['orden1']!),
            buildOrderedWord('Segundo:', respuesta['orden2']!),
            buildOrderedWord('Tercero:', respuesta['orden3']!),
            buildOrderedWord('Cuarto:', respuesta['orden4']!),
            buildOrderedWord('Quinto:', respuesta['orden5']!),
          ],
        ),
      ),
    );
  }

  Widget buildOrderedWord(String title, String word) {
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
            'ORDENALO YA',
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
