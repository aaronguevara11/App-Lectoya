import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lectoya/api/apiDocentes.dart';
import 'package:lectoya/screens/Docentes/Curso/Juegos/cambialo.dart';
import 'package:lectoya/screens/Docentes/Curso/Juegos/dado.dart';
import 'package:lectoya/screens/Docentes/Curso/Juegos/haremos.dart';
import 'package:lectoya/screens/Docentes/Curso/Juegos/interactivas.dart';
import 'package:lectoya/screens/Docentes/Curso/Juegos/ordenalo.dart';
import 'package:lectoya/screens/Docentes/Curso/Juegos/ruleteando.dart';
import 'package:lectoya/screens/Docentes/Curso/Juegos/significado.dart';
import 'package:lectoya/screens/Docentes/Curso/Respuestas/cambialo.dart';
import 'package:lectoya/screens/Docentes/Curso/Respuestas/dado.dart';
import 'package:lectoya/screens/Docentes/Curso/Respuestas/haremos.dart';
import 'package:lectoya/screens/Docentes/Curso/Respuestas/interactivas.dart';
import 'package:lectoya/screens/Docentes/Curso/Respuestas/ordenalo.dart';
import 'package:lectoya/screens/Docentes/Curso/Respuestas/ruleteando.dart';
import 'package:lectoya/screens/Docentes/Curso/Respuestas/significado.dart';
import 'package:lectoya/screens/Docentes/Forms/Juegos/cambialo.dart';
import 'package:lectoya/screens/Docentes/Forms/Juegos/dado.dart';
import 'package:lectoya/screens/Docentes/Forms/Juegos/haremos.dart';
import 'package:lectoya/screens/Docentes/Forms/Juegos/interactivas.dart';
import 'package:lectoya/screens/Docentes/Forms/Juegos/ordenalo.dart';
import 'package:lectoya/screens/Docentes/Forms/Juegos/ruleteando.dart';
import 'package:lectoya/screens/Docentes/Forms/Juegos/significado.dart';
import 'package:lectoya/screens/Docentes/indexDocente.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    BuildContext? dialogContext;

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
              child: Builder(
                builder: (BuildContext context) {
                  dialogContext = context;
                  return Container(
                    height: 420,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Juegos agregados:'.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                              ),
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
                                  margin:
                                      const EdgeInsets.only(top: 6, bottom: 6),
                                  elevation: 4,
                                  shadowColor:
                                      const Color.fromARGB(119, 33, 149, 243),
                                  child: Dismissible(
                                    key: ValueKey<int>(juego['id']),
                                    background: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color.fromARGB(
                                            255, 86, 23, 19),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                    direction: DismissDirection.endToStart,
                                    confirmDismiss: (direction) async {
                                      bool confirm = false;
                                      if (dialogContext != null) {
                                        await showDialog(
                                          context: dialogContext!,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              contentPadding: EdgeInsets.only(
                                                  left: 18, right: 18, top: 10),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Borrar juego"
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: 26,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Divider(),
                                                  const Text(
                                                    "¿Estás seguro que deseas borrar este juego?",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  SizedBox(height: 16),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          confirm = false;
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.all(0),
                                                          height: 40,
                                                          child: Text(
                                                            'Cancelar',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 14),
                                                      GestureDetector(
                                                        onTap: () {
                                                          confirm = true;
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.all(0),
                                                          height: 40,
                                                          child: Text(
                                                            'Borrar',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: const Color
                                                                  .fromARGB(255,
                                                                  107, 33, 28),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      }
                                      return confirm;
                                    },
                                    onDismissed: (direction) async {
                                      try {
                                        final response =
                                            await docentesAPI.BorrarJuego();
                                        if (response ==
                                            "El nivel no ha sido encontrado") {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Row(
                                                children: [
                                                  Icon(Icons.error_outline,
                                                      color: Colors.white),
                                                  Text(
                                                    'Hubo un error, inténtalo de nuevo más tarde',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              backgroundColor: Color.fromARGB(
                                                  255, 87, 14, 14),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Row(
                                                children: [
                                                  Icon(Icons.check,
                                                      color: Colors.white),
                                                  Text(
                                                    'El nivel ha sido borrado con éxito',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              backgroundColor: Color.fromARGB(
                                                  255, 23, 87, 14),
                                            ),
                                          );
                                          setState(() {
                                            temaData['juegos'].removeAt(index);
                                          });
                                        }
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Row(
                                              children: [
                                                Icon(Icons.error_outline,
                                                    color: Colors.white),
                                                Text(
                                                  'Hubo un error, inténtalo de nuevo más tarde',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            backgroundColor:
                                                Color.fromARGB(255, 87, 14, 14),
                                          ),
                                        );
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: GestureDetector(
                                        onTap: () async {
                                          final id =
                                              juego['idJuego'].toString();
                                          final idJuegoOrdenalo =
                                              juego['id'].toString();

                                          print(
                                              'Juego seleccionado ID: $idJuegoOrdenalo');

                                          print('Juego: $id');
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.setString('idNivel', id);
                                          prefs.setString(
                                              'idOrdenalo', idJuegoOrdenalo);

                                          try {
                                            switch (juego['nombreJuego']) {
                                              case 'Historias interactivas':
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HistoriasInteractivas()),
                                                );
                                                break;
                                              case '¿Ahora que haremos?':
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HaremosHoy()),
                                                );
                                                break;
                                              case 'El dado de las preguntas':
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DadoPreguntas()),
                                                );
                                                break;
                                              case 'Cambialo YA':
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CambialoYa()),
                                                );
                                                break;
                                              case 'Ordenalo YA':
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrdenaloYa()),
                                                );
                                                break;
                                              case 'Ruleteando':
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RuleteandoDocentes()),
                                                );
                                                break;
                                              case 'Dale un significado':
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DaleSignificado()),
                                                );
                                                break;
                                              default:
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Row(
                                                      children: [
                                                        Icon(
                                                            Icons.error_outline,
                                                            color:
                                                                Colors.white),
                                                        Text(
                                                          'Hubo un error, inténtalo de nuevo más tarde',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 87, 14, 14),
                                                  ),
                                                );
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const DetalleTemaDocente()),
                                                );
                                            }
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Row(
                                                  children: [
                                                    Icon(Icons.error_outline,
                                                        color: Colors.white),
                                                    Text(
                                                      'Hubo un error, inténtalo de nuevo más tarde',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                backgroundColor: Color.fromARGB(
                                                    255, 87, 14, 14),
                                              ),
                                            );
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(Icons.gamepad_rounded),
                                                const SizedBox(width: 10),
                                                Text(
                                                  juego['nombreJuego'],
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    final id =
                                                        juego['id'].toString();
                                                    print(
                                                        'Juego seleccionado ID: $id');
                                                    SharedPreferences prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    prefs.setString(
                                                        'idNivel', id);

                                                    try {
                                                      switch (juego[
                                                          'nombreJuego']) {
                                                        case 'Historias interactivas':
                                                          await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        RespuestasHistoriasInteractivas()),
                                                          );
                                                          break;
                                                        case '¿Ahora que haremos?':
                                                          await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        RespuestasHaremosHoy()),
                                                          );
                                                          break;
                                                        case 'El dado de las preguntas':
                                                          await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        RespuestasDadoPreguntas()),
                                                          );
                                                          break;
                                                        case 'Cambialo YA':
                                                          await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        RespuestasCambialoYa()),
                                                          );
                                                          break;
                                                        case 'Ordenalo YA':
                                                          await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        RespuestasOrdenaloYa()),
                                                          );
                                                          break;
                                                        case 'Ruleteando':
                                                          await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        RespuestasRuleteandoDocentes()),
                                                          );
                                                          break;
                                                        case 'Dale un significado':
                                                          await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        RespuestasDaleSignificado()),
                                                          );
                                                          break;
                                                        default:
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                              content: Row(
                                                                children: [
                                                                  Icon(
                                                                      Icons
                                                                          .error_outline,
                                                                      color: Colors
                                                                          .white),
                                                                  Text(
                                                                    'Hubo un error, inténtalo de nuevo más tarde',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ],
                                                              ),
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          87,
                                                                          14,
                                                                          14),
                                                            ),
                                                          );
                                                          Navigator
                                                              .pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const DetalleTemaDocente()),
                                                          );
                                                      }
                                                    } catch (e) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: Row(
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .error_outline,
                                                                  color: Colors
                                                                      .white),
                                                              Text(
                                                                'Hubo un error, inténtalo de nuevo más tarde',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ],
                                                          ),
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  87,
                                                                  14,
                                                                  14),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: Container(
                                                    width: 160,
                                                    decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 12, 19, 91),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .remove_red_eye_outlined,
                                                            color: Colors.white,
                                                            size: 15,
                                                          ),
                                                          SizedBox(
                                                            width: 6,
                                                          ),
                                                          Text(
                                                            'Ver respuestas',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .white),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
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
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22),
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () async {
                bool confirm = false;
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(
                      child: Container(
                        height: 250,
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding:
                              EdgeInsets.only(top: 15, left: 18, right: 18),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Borrar tema".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold),
                              ),
                              Divider(),
                              const Text(
                                "¿Estás seguro que deseas borrar este tema?",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      confirm = false;
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(0),
                                      height: 40,
                                      child: Text(
                                        'Cancelar',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 14,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      final response =
                                          await docentesAPI.BorrarTema();
                                      if (response ==
                                          "El nivel no ha sido encontrado") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Row(
                                              children: [
                                                Icon(Icons.error_outline,
                                                    color: Colors.white),
                                                Text(
                                                  'Hubo un error, inténtalo de nuevo más tarde',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            backgroundColor:
                                                Color.fromARGB(255, 87, 14, 14),
                                          ),
                                        );
                                      } else if (response ==
                                          "Nivel borrado exitosamente") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Row(
                                              children: [
                                                Icon(Icons.check,
                                                    color: Colors.white),
                                                Text(
                                                  'El tema ha sido borrado con éxito',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            backgroundColor:
                                                Color.fromARGB(255, 23, 87, 14),
                                          ),
                                        );
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeDocente()),
                                        );
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(0),
                                      height: 40,
                                      child: Text(
                                        'Borrar',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: const Color.fromARGB(
                                                255, 107, 33, 28),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
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
                                                    'Historias interactivas',
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
