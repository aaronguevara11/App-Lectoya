import 'package:flutter/material.dart';
import 'package:lectoya/api/apiEstudiantes.dart';
import 'package:lectoya/screens/inicio/login.dart';

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
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 38, 41, 103),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 22, left: 32, right: 32, bottom: 25),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'REGISTRO',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 250,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: nombreController,
                              decoration: const InputDecoration(
                                labelText: 'Nombre',
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                floatingLabelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                prefixIcon: Icon(Icons.person),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Escriba su nombre';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              controller: paternoController,
                              decoration: const InputDecoration(
                                labelText: 'Apellido paterno',
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                floatingLabelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                prefixIcon: Icon(Icons.people_alt),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Escriba su Apellido paterno';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              controller: maternoController,
                              decoration: const InputDecoration(
                                labelText: 'Apellido materno',
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                floatingLabelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                prefixIcon: Icon(Icons.people_alt),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Escriba su Apellido materno';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              controller: correoController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Correo',
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                floatingLabelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                prefixIcon: Icon(Icons.email),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ingrese su correo electrónico';
                                } else if (!value.contains('@')) {
                                  return 'Ingrese un correo valido';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              controller: numeroController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Teléfono',
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                floatingLabelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                prefixIcon: Icon(Icons.phone_android),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Escriba su teléfono';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              controller: dniController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'DNI',
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                floatingLabelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                prefixIcon: Icon(Icons.assignment_ind_outlined),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Escriba su número de DNI';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: const InputDecoration(
                                labelText: 'Contraseña',
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                floatingLabelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                prefixIcon: Icon(Icons.password_outlined),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Escriba su contraseña';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (formkey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });

                          final String nombre = nombreController.text;
                          final String apaterno = paternoController.text;
                          final String amaterno = maternoController.text;
                          final String correo = correoController.text;
                          final String numero = numeroController.text;
                          final String dni = dniController.text;
                          final String password = passwordController.text;

                          final response =
                              await _estudiantesAPI.RegistrarEstudiante(
                                  nombre,
                                  apaterno,
                                  amaterno,
                                  correo,
                                  numero,
                                  dni,
                                  password);

                          setState(() {
                            isLoading = false;
                          });

                          if (response == "El estudiante ya existe") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('El estudiante ya existe'),
                                backgroundColor:
                                    Color.fromARGB(255, 80, 17, 13),
                              ),
                            );
                          } else if (response == "Error en el servidor") {
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
                                  builder: (context) => const LoginVentana()),
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
                        child: Center(
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Registrarse',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginVentana(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color.fromARGB(255, 15, 18, 107),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Ya tengo cuenta",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 20, 22, 100),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
