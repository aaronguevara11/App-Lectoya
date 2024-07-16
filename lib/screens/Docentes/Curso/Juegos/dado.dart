import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lectoya/api/apiDocentes.dart';
import 'package:shake/shake.dart';

class DadoPreguntas extends StatefulWidget {
  const DadoPreguntas({Key? key}) : super(key: key);

  @override
  State<DadoPreguntas> createState() => _Dado();
}

class _Dado extends State<DadoPreguntas> {
  final DocentesAPI docentesAPI = DocentesAPI();
  Map<String, dynamic>? juego;

  Future<void> fetchData() async {
    try {
      final data = await docentesAPI.VerDado();
      setState(() {
        juego = data['juego'];
      });
    } catch (e) {
      print('Error al cargar los datos: $e');
    }
  }

  static const List<String> imgs = [
    'assets/dice_1.png',
    'assets/dice_2.png',
    'assets/dice_3.png',
    'assets/dice_4.png',
    'assets/dice_5.png',
    'assets/dice_6.png',
  ];

  static const List<String> preguntas = [
    'primera_pre',
    'segunda_pre',
    'tercera_pre',
    'cuarta_pre',
    'quinta_pre',
    'sexta_pre',
  ];

  String imgDado1 = imgs.first;
  String preguntaActual = '';

  int random(int min, int max) {
    final rnd = Random();
    return min + rnd.nextInt(max - min + 1);
  }

  void tirarDados() {
    setState(() {
      int resultado = random(0, 5);
      imgDado1 = imgs[resultado];
      preguntaActual = juego != null ? juego![preguntas[resultado]] : '';
    });
  }

  ShakeDetector? detector;

  @override
  void initState() {
    super.initState();
    detector = ShakeDetector.autoStart(onPhoneShake: tirarDados);
    fetchData();
  }

  @override
  void dispose() {
    detector?.stopListening();
    super.dispose();
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 8,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: const Text(
                            'Mueve tu teléfono para ver la pregunta',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Divider(),
                        Container(
                          width: MediaQuery.of(context).size.width - 160,
                          margin: const EdgeInsets.all(20),
                          child: Image.asset(
                            imgDado1,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (preguntaActual.isNotEmpty) ...[
                          Container(
                              width: MediaQuery.of(context).size.width,
                              padding:
                                  const EdgeInsets.only(bottom: 5, left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pregunta:',
                                    style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    preguntaActual,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              )),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
