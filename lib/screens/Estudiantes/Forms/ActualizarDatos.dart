import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lectoya/api/apiEstudiantes.dart';
import 'package:lectoya/screens/Estudiantes/indexEstudiante.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActualizarEstudiante extends StatefulWidget {
  const ActualizarEstudiante({super.key});

  @override
  State<ActualizarEstudiante> createState() => _Actualizar();
}

class _Actualizar extends State<ActualizarEstudiante> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final EstudiantesAPI estudiantesAPI = EstudiantesAPI();
  TextEditingController nombreController = TextEditingController();
  TextEditingController paternoController = TextEditingController();
  TextEditingController maternoController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController numeroController = TextEditingController();

  String correo = '';
  String password = '';

  Map<String, dynamic> datosToken = {};

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      try {
        final decodedToken = JwtDecoder.decode(token);
        datosToken = decodedToken;
        setState(() {
          nombreController.text = decodedToken['nombre'];
          paternoController.text = decodedToken['apaterno'];
          maternoController.text = decodedToken['amaterno'];
          correoController.text = decodedToken['correo'];
          correo = decodedToken['correo'];
          password = decodedToken['password'];
          numeroController.text = decodedToken['numero'];
        });
      } catch (e) {
        print('Error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0), // Adjust height as needed
          child: AppBar(
              backgroundColor: const Color.fromARGB(255, 9, 36, 82),
              title: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Actualizar datos',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 27),
                    ),
                  ])),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: nombreController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                            labelText: 'Nombre',
                            labelStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            floatingLabelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            prefixIcon: Icon(Icons.person)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Escriba su nombre';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: paternoController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                            labelText: 'Apellido paterno',
                            labelStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            floatingLabelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            prefixIcon: Icon(Icons.people_alt)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Escriba su Apellido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: maternoController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                            labelText: 'Apellido materno',
                            labelStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            floatingLabelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            prefixIcon: Icon(Icons.people_alt)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Escriba su apellido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: correoController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            labelText: 'Correo',
                            labelStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            floatingLabelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            prefixIcon: Icon(Icons.email)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese su correo electrónico';
                          } else if (!value.contains('@')) {
                            return 'Ingrese un correo valido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: numeroController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: 'Telefono',
                            labelStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            floatingLabelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            prefixIcon: Icon(Icons.phone_android)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Escriba su telefono';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: () async {
                            if (formkey.currentState!.validate()) {
                              final String nombre = nombreController.text;
                              final String apaterno = paternoController.text;
                              final String amaterno = maternoController.text;
                              final String correo = correoController.text;
                              final String numero = numeroController.text;

                              final response =
                                  await estudiantesAPI.ActualizarEstudiante(
                                      nombre,
                                      apaterno,
                                      amaterno,
                                      correo,
                                      numero);

                              if (response == "Error en el servidor") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Error en el servidor, intentelo de nuevo más tarde'),
                                  ),
                                );
                              } else {
                                await estudiantesAPI.LoginEstudiantes(
                                    correo, password);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Row(
                                      children: [
                                        Icon(Icons.check),
                                        Text(
                                            'Estudiante actualizado con éxito'),
                                      ],
                                    ),
                                    backgroundColor:
                                        Color.fromARGB(255, 19, 87, 14),
                                  ),
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeEstudiante()),
                                );
                              }
                            }
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 20, 22, 100),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: Text(
                                'Actualizar',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
