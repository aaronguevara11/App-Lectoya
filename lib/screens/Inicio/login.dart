import 'package:flutter/material.dart';
import 'package:lectoya/api/apiDocentes.dart';
import 'package:lectoya/api/apiEstudiantes.dart';
import 'package:lectoya/screens/Docentes/indexDocente.dart';
import 'package:lectoya/screens/Estudiantes/indexEstudiante.dart';
import 'package:lectoya/screens/Inicio/registro.dart';

class LoginVentana extends StatefulWidget {
  const LoginVentana({super.key});

  @override
  State<LoginVentana> createState() => _Login();
}

class _Login extends State<LoginVentana> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final DocentesAPI _docentesAPI = DocentesAPI();
  final EstudiantesAPI _estudiantesAPI = EstudiantesAPI();
  TextEditingController correoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isDocente = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 38, 41, 103),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 22, left: 32, right: 32, bottom: 35),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'LECTOYA',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
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
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese su correo electrónico';
                        } else if (!value.contains('@')) {
                          return 'Ingrese un correo válido';
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
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: isDocente,
                          onChanged: (value) {
                            setState(() {
                              isDocente = value!;
                            });
                          },
                        ),
                        const Text(
                          "Soy Docente",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () async {
                        if (formkey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });

                          final String correo = correoController.text;
                          final String password = passwordController.text;

                          final response = await (isDocente
                              ? _docentesAPI.LoginDocente(correo, password)
                              : _estudiantesAPI.LoginEstudiantes(
                                  correo, password));

                          setState(() {
                            isLoading = false;
                          });

                          if (response == "Datos incorrectos") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Datos incorrectos'),
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
                            await (isDocente
                                ? Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeDocente()),
                                  )
                                : Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeEstudiante()),
                                  ));
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
                                  'Acceder',
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
                            builder: (context) => const RegistroVentana(),
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
                            "Registrate aquí",
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
          )
        ],
      ),
    );
  }
}
