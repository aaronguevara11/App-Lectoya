import 'package:flutter/material.dart';
import 'package:lectoya/api/apiDocentes.dart';

class HaremosHoy extends StatefulWidget {
  const HaremosHoy({Key? key}) : super(key: key);

  @override
  _HaremosHoyState createState() => _HaremosHoyState();
}

class _HaremosHoyState extends State<HaremosHoy> {
  final DocentesAPI docentesAPI = DocentesAPI();
  Map<String, dynamic>? juego;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final data = await docentesAPI.VerHaremos();
      setState(() {
        juego = data['juego'];
      });
    } catch (e) {
      print('Error al cargar los datos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 9, 36, 82),
          title: const Text(
            '¿Ahora qué haremos?',
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
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Lee atentamente',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Divider(),
                    juego != null
                        ? Text(
                            juego!['pregunta'],
                            style: const TextStyle(fontSize: 17),
                          )
                        : const Text(
                            'Cargando pregunta...',
                            style: TextStyle(fontSize: 17),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
