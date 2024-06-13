import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lectoya/api/apiDocentes.dart'; // Assuming this imports your DocentesAPI class
import 'package:lectoya/screens/Docentes/Forms/ActualizarDatos.dart';
import 'package:lectoya/screens/Inicio/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilDocente extends StatefulWidget {
  const PerfilDocente({super.key});

  @override
  State<PerfilDocente> createState() => _Perfil();
}

class _Perfil extends State<PerfilDocente> {
  final DocentesAPI docentesAPI = DocentesAPI();
  Map<String, dynamic> datosToken = {};
  bool isLoading = false;
  String inicial = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');

    if (token != null) {
      try {
        final decodedToken = JwtDecoder.decode(token);
        datosToken = decodedToken;

        if (datosToken.containsKey('nombre')) {
          String name = datosToken['nombre'];
          if (name.isNotEmpty) {
            inicial = name.substring(0, 1);
            print(inicial);
          }
        }
      } catch (e) {
        print('Error');
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String dni = '';
    String nombre = '';
    String apaterno = '';
    String amaterno = '';
    String correo = '';
    String numero = '';

    if (datosToken.isNotEmpty) {
      dni = datosToken['dni'.toString()];
      nombre = datosToken['nombre'];
      apaterno = datosToken['apaterno'];
      amaterno = datosToken['amaterno'];
      correo = datosToken['correo'];
      numero = datosToken['numero'];
    }

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0), // Adjust height as needed
          child: AppBar(
            backgroundColor: const Color.fromARGB(255, 9, 36, 82),
            title: Text(
              'Perfil'.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 40),
            ),
          ),
        ),
        body: Center(
            child: isLoading
                ? const CircularProgressIndicator()
                : SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.black38, width: 5),
                              ),
                              child: Center(
                                child: Text(
                                  inicial,
                                  style: const TextStyle(
                                      color: Colors.black38,
                                      fontSize: 90,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Text(
                              nombre,
                              style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: GestureDetector(
                                onTap: () async {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ActualizarDocente()),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 160,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Color.fromARGB(255, 19, 15, 124),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Center(
                                          child: Text(
                                            'Cambiar datos',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 160,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Color.fromARGB(255, 136, 0, 0),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Center(
                                          child: Text(
                                            'Cerrar sesion',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  elevation: 12,
                                  shadowColor: Colors.black54,
                                  child: Padding(
                                    padding: const EdgeInsets.all(25),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Datos personales:',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Dni:',
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black26),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding: EdgeInsets.all(7),
                                                child: Text(
                                                  dni,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black38),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Nombres:',
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black26),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding: EdgeInsets.all(7),
                                                child: Text(
                                                  nombre,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black38),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Apellidos:',
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black26),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding: EdgeInsets.all(7),
                                                child: Text(
                                                  apaterno + ' ' + amaterno,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black38),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Correo:',
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black26),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding: EdgeInsets.all(7),
                                                child: Text(
                                                  correo,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black38),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Número:',
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black26),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding: EdgeInsets.all(7),
                                                child: Text(
                                                  numero,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black38),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  )));
  }
}
