import 'package:lectoya/api/apiEstudiantes.dart';
import 'package:lectoya/screens/inicio/login.dart';
import 'package:flutter/material.dart';

class RegistroVentana extends StatefulWidget {
  const RegistroVentana({super.key});

  @override
  State<RegistroVentana> createState() => _Registro();
}

class _Registro extends State<RegistroVentana> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final EstudiantesAPI _estudiantesAPI = EstudiantesAPI();
  TextEditingController nombreController = TextEditingController();
  TextEditingController paternoController = TextEditingController();
  TextEditingController maternoController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController dniController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 90, 126, 159),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Card(
                elevation: 8,
                shadowColor: Colors.grey[800],
                margin: const EdgeInsets.all(24),
                child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'REGISTRO',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 50),
                          ),
                          SizedBox(
                            height: 270,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: nombreController,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: const InputDecoration(
                                        labelText: 'Nombre',
                                        labelStyle: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
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
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
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
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
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
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
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
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
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
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: dniController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        labelText: 'Dni',
                                        labelStyle: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        floatingLabelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        prefixIcon: Icon(
                                            Icons.assignment_ind_outlined)),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Escriba su número de dni';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: const InputDecoration(
                                        labelText: 'Contraseña',
                                        labelStyle: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        floatingLabelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        prefixIcon:
                                            Icon(Icons.password_outlined)),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Escriba su contraseña';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                              onTap: () async {
                                if (formkey.currentState!.validate()) {
                                  final String nombre = nombreController.text;
                                  final String apaterno =
                                      paternoController.text;
                                  final String amaterno =
                                      maternoController.text;
                                  final String correo = correoController.text;
                                  final String numero = numeroController.text;
                                  final String dni = dniController.text;
                                  final String password =
                                      passwordController.text;

                                  final response =
                                      await _estudiantesAPI.RegistrarEstudiante(
                                          nombre,
                                          apaterno,
                                          amaterno,
                                          correo,
                                          numero,
                                          dni,
                                          password);

                                  if (response == "El docente ya existe") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('El docente ya existe'),
                                        backgroundColor:
                                            Color.fromARGB(255, 80, 17, 13),
                                      ),
                                    );
                                  } else if (response ==
                                      "Error en el servidor") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Error en el servidor, intentelo de nuevo más tarde'),
                                      ),
                                    );
                                  } else {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginVentana()),
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
                                    'Registrarse',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginVentana()));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 15, 18, 107))),
                              child: const Center(
                                child: Text(
                                  "Ya tengo cuenta",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 20, 22, 100)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            )
          ],
        ));
  }
}
