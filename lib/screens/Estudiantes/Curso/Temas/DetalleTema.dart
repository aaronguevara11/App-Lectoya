import 'package:flutter/material.dart';
import 'package:lectoya/api/apiEstudiantes.dart';
import 'package:lectoya/screens/Estudiantes/Juegos/cambialo.dart';
import 'package:lectoya/screens/Estudiantes/Juegos/dado.dart';
import 'package:lectoya/screens/Estudiantes/Juegos/haremos.dart';
import 'package:lectoya/screens/Estudiantes/Juegos/interactivas.dart';
import 'package:lectoya/screens/Estudiantes/Juegos/ordenalo.dart';
import 'package:lectoya/screens/Estudiantes/Juegos/ruleteando.dart';
import 'package:lectoya/screens/Estudiantes/Juegos/significado.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetalleTemaEstudiantes extends StatefulWidget {
  const DetalleTemaEstudiantes({Key? key}) : super(key: key);

  @override
  State<DetalleTemaEstudiantes> createState() => _DetalleTemaEstudiantesState();
}

class _DetalleTemaEstudiantesState extends State<DetalleTemaEstudiantes> {
  final EstudiantesAPI estudiantesAPI = EstudiantesAPI();
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
        return Container(
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
                      return GestureDetector(
                        onTap: () async {
                          final id = juego['idJuego'].toString();
                          print('Juego seleccionado ID: $id');
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          prefs.setString('idNivel', id);
                          if (juego['nombreJuego'] ==
                              'Historias interactivas') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HistoriasInteractivasEstudiantes()),
                            );
                          } else if (juego['nombreJuego'] ==
                              '¿Ahora que haremos?') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HaremosHoyEstudiantes()),
                            );
                          } else if (juego['nombreJuego'] ==
                              'El dado de las preguntas') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DadoPreguntasEstudiantes()),
                            );
                          } else if (juego['nombreJuego'] == 'Cambialo YA') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CambialoYaEstudiantes()),
                            );
                          } else if (juego['nombreJuego'] == 'Ordenalo YA') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OrdenaloYaEstudiantes()),
                            );
                          } else if (juego['nombreJuego'] == 'Ruleteando') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RuleteandoEstudiantes()),
                            );
                          } else if (juego['nombreJuego'] ==
                              'Dale un significado') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DaleSignificadoEstudiantes()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Hubo un error, intentalo de nuevo más tarde',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor:
                                    Color.fromARGB(255, 87, 14, 14),
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DetalleTemaEstudiantes()),
                            );
                          }
                        },
                        child: Card(
                          key: ValueKey(juego['id']),
                          margin: const EdgeInsets.only(top: 6, bottom: 6),
                          elevation: 4,
                          shadowColor: const Color.fromARGB(119, 33, 149, 243),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Icon(Icons.gamepad_rounded),
                                const SizedBox(width: 10),
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
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65.0),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 9, 36, 82),
          title: Text(
            temaData.isNotEmpty ? temaData['nombre'].toUpperCase() : 'Tema',
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 26),
          ),
          automaticallyImplyLeading: false,
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
                    const SizedBox(height: 10),
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
                                const SizedBox(width: 8),
                                Text(
                                  'Juegos'.toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class CardDetalle extends StatelessWidget {
  final Map<String, dynamic> temaData;

  const CardDetalle({required this.temaData});

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
                      fontSize: 25, fontWeight: FontWeight.bold),
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
