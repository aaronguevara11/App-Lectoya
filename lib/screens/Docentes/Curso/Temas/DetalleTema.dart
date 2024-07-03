import 'package:flutter/material.dart';
import 'package:lectoya/api/apiDocentes.dart';
import 'package:lectoya/screens/Docentes/Curso/Juegos/cambialo.dart';
import 'package:lectoya/screens/Docentes/Curso/Juegos/dado.dart';
import 'package:lectoya/screens/Docentes/Curso/Juegos/haremos.dart';
import 'package:lectoya/screens/Docentes/Curso/Juegos/interactivas.dart';
import 'package:lectoya/screens/Docentes/Curso/Juegos/ordenalo.dart';
import 'package:lectoya/screens/Docentes/Curso/Juegos/ruleteando.dart';
import 'package:lectoya/screens/Docentes/Curso/Juegos/significado.dart';
import 'package:lectoya/screens/Docentes/Forms/Juegos/cambialo.dart';
import 'package:lectoya/screens/Docentes/Forms/Juegos/dado.dart';
import 'package:lectoya/screens/Docentes/Forms/Juegos/haremos.dart';
import 'package:lectoya/screens/Docentes/Forms/Juegos/interactivas.dart';
import 'package:lectoya/screens/Docentes/Forms/Juegos/ordenalo.dart';
import 'package:lectoya/screens/Docentes/Forms/Juegos/ruleteando.dart';
import 'package:lectoya/screens/Docentes/Forms/Juegos/significado.dart';

class DetalleTemaDocente extends StatefulWidget {
  const DetalleTemaDocente({super.key});

  @override
  State<DetalleTemaDocente> createState() => _DetalleTemaDocentes();
}

class _DetalleTemaDocentes extends State<DetalleTemaDocente> {
  DocentesAPI docentesAPI = DocentesAPI();
  Map<String, dynamic> temaData = {};

  @override
  void initState() {
    super.initState();
    _getTemaDetails();
  }

  Future<void> _getTemaDetails() async {
    try {
      final Map<String, dynamic> data = await docentesAPI.DetallesTema();
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
                                onTap: () async {
                                  final id = juego['id'].toString();
                                  print('Juego seleccionado ID: $id');
                                  if (juego['nombreJuego'] ==
                                      'Historias interactivas') {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HistoriasInteractivas()),
                                    );
                                  } else if (juego['nombreJuego'] ==
                                      '¿Ahora que haremos?') {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HaremosHoy()),
                                    );
                                  } else if (juego['nombreJuego'] ==
                                      'El dado de las preguntas') {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DadoPreguntas()),
                                    );
                                  } else if (juego['nombreJuego'] ==
                                      'Cambialo YA') {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CambialoYa()),
                                    );
                                  } else if (juego['nombreJuego'] ==
                                      'Ordenalo YA') {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OrdenaloYa()),
                                    );
                                  } else if (juego['nombreJuego'] ==
                                      'Ruleteando') {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Ruleteando()),
                                    );
                                  } else if (juego['nombreJuego'] ==
                                      'Dale un significado') {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DaleSignificado()),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Row(
                                          children: [
                                            Icon(
                                              Icons.error_outline,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              'Hubo un error, intentalo de nuevo más tarde',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        backgroundColor:
                                            Color.fromARGB(255, 87, 14, 14),
                                      ),
                                    );
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DetalleTemaDocente()),
                                    );
                                  }
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
                                  Icon(Icons.gamepad_rounded),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Juegos'.toUpperCase(),
                                    style: TextStyle(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          onPressed: () {
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
                        height: 480,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  'Agregar juegos',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Divider(),
                              Container(
                                height: 400,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Card(
                                        elevation: 7,
                                        shadowColor: Colors.black87,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const FormInteractivas()),
                                            );
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: const Padding(
                                              padding: EdgeInsets.all(15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Preguntas interactivas',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                  Text(
                                                      'Transforma historias y explora finales inesperados al controlar los destinos de los personajes.')
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Card(
                                        elevation: 7,
                                        shadowColor: Colors.black87,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const FormHaremos()),
                                            );
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: const Padding(
                                              padding: EdgeInsets.all(15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '¿Ahora qué haremos?',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                  Text(
                                                      'Este juego te desafía a resolver dilemas narrativos guiando personajes hacia soluciones ingeniosas.')
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Card(
                                        elevation: 7,
                                        shadowColor: Colors.black87,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const FormDado()),
                                            );
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: const Padding(
                                              padding: EdgeInsets.all(15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'El dado de las preguntas',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                  Text(
                                                      'Haz que la lectura sea interactiva: lanza dados, responde preguntas específicas y profundiza tu comprensión de manera única y entretenida.')
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Card(
                                        elevation: 7,
                                        shadowColor: Colors.black87,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const FormCambialo()),
                                            );
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: const Padding(
                                              padding: EdgeInsets.all(15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Cambialo ya!',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                  Text(
                                                      'Con las emociones propuestas crea el final como si fueras el personaje. ¡Adopta la emoción y cambia el destino!')
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Card(
                                        elevation: 7,
                                        shadowColor: Colors.black87,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const FormOrdenalo()),
                                            );
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: const Padding(
                                              padding: EdgeInsets.all(15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Ordenalo ya!',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                  Text(
                                                      'Organiza la historia en 5 pequeñas oraciones para que pueda recordar toda la obra. Acompáñalo con 5 imágenes propuestas.')
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Card(
                                        elevation: 7,
                                        shadowColor: Colors.black87,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const FormRuleteando()),
                                            );
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: const Padding(
                                              padding: EdgeInsets.all(15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Ruleteando',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                  Text(
                                                      'Las preguntas más difíciles se encuentra en la ruleta de LECTO YA!. Es momento de probar tu suerte y que  respondas correctamente la pregunta.')
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Card(
                                        elevation: 7,
                                        shadowColor: Colors.black87,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const FormSignificado()),
                                            );
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: const Padding(
                                              padding: EdgeInsets.all(15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Dale un significado',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                  Text(
                                                      'Desafía tu interpretación seleccionando tres palabras clave para desbloquear etapas y descubrir significados ocultos, mejorando tu habilidad de forma divertida.')
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
          backgroundColor: Colors.white,
          shape: const CircleBorder(
            side: BorderSide(width: 5, color: Color.fromARGB(255, 22, 27, 124)),
          ),
          child: const Icon(
            Icons.add,
            size: 24.0,
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
