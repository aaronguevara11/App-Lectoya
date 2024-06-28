import 'package:flutter/material.dart';
import 'package:lectoya/api/apiEstudiantes.dart';

class DetalleTemaEstudiantes extends StatefulWidget {
  const DetalleTemaEstudiantes({super.key});

  @override
  State<DetalleTemaEstudiantes> createState() => _DetalleTemaEstudiantes();
}

class _DetalleTemaEstudiantes extends State<DetalleTemaEstudiantes> {
  EstudiantesAPI estudiantesAPI = EstudiantesAPI();
  Map<String, dynamic> temaData = {};

  @override
  void initState() {
    super.initState();
    _getTemaDetails();
  }

  Future<void> _getTemaDetails() async {
    try {
      final Map<String, dynamic> data = await estudiantesAPI.DetallesTema();
      setState(() {
        temaData = data;
      });
    } catch (e) {
      print(e);
    }
  }

  void _showJuegosModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 300),
              curve: Curves.decelerate,
              child: Container(
                height: 420,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Juegos agregados:'.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 27, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider(),
                      Expanded(
                          child: ListView.builder(
                        itemCount: temaData['juegos'].length,
                        itemBuilder: (context, index) {
                          final juego = temaData['juegos'][index];
                          return Card(
                            key: ValueKey(juego['id']),
                            margin: const EdgeInsets.only(top: 6, bottom: 6),
                            elevation: 4,
                            shadowColor:
                                const Color.fromARGB(119, 33, 149, 243),
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: GestureDetector(
                                onTap: () {
                                  final id = juego['id'].toString();
                                  print('Juego seleccionado ID: $id');
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.gamepad_rounded),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      juego['nombreJuego'],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ))
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 9, 36, 82),
        title: Text(
          'Tema'.toUpperCase(),
          textAlign: TextAlign.start,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: temaData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(25),
                child: Column(
                  children: [
                    CardDetalle(temaData: temaData),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                        elevation: 9,
                        child: GestureDetector(
                          onTap: _showJuegosModal,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 65,
                            child: Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Row(
                                children: [
                                  const Icon(Icons.gamepad_rounded),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Juegos'.toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
    );
  }
}

class CardDetalle extends StatelessWidget {
  final Map<String, dynamic> temaData;

  const CardDetalle({Key? key, required this.temaData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 3 + 130,
        child: Card(
          elevation: 7,
          shadowColor: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lectura',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(color: Color.fromARGB(255, 155, 155, 155)),
                Container(
                  height: MediaQuery.of(context).size.height / 2 - 100,
                  child: SingleChildScrollView(
                    child: Text(
                      temaData['lectura'],
                      style: const TextStyle(fontSize: 19),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
