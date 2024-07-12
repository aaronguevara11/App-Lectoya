import 'package:flutter/material.dart';
import 'package:lectoya/api/apiDocentes.dart';

class CambialoYa extends StatefulWidget {
  const CambialoYa({super.key});

  @override
  State<CambialoYa> createState() => _Cambialo();
}

class _Cambialo extends State<CambialoYa> {
  final DocentesAPI docentesAPI = DocentesAPI();
  Map<String, dynamic>? juego;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final data = await docentesAPI.VerCambialo();
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
            'Cambialo YA',
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
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Agregale un final con la emoción planteada',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Divider(),
                    juego != null && juego!['enunciado'] != null
                        ? Text(
                            juego!['enunciado'],
                            style: const TextStyle(fontSize: 18),
                          )
                        : const Text(
                            'Cargando enunciado...',
                            style: TextStyle(fontSize: 17),
                          ),
                    Card(
                      color: const Color.fromARGB(255, 233, 233, 233),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: juego != null && juego!['enunciado'] != null
                                ? Text(
                                    juego!['emocion'],
                                    style: const TextStyle(fontSize: 17),
                                  )
                                : const Text(
                                    'Cargando enunciado...',
                                    style: TextStyle(fontSize: 17),
                                  ),
                          )),
                    )
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
