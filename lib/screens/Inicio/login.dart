import 'package:lectoya/api/apiDocentes.dart';
import 'package:lectoya/api/apiEstudiantes.dart';
import 'package:lectoya/screens/Docentes/indexDocente.dart';
import 'package:lectoya/screens/Estudiantes/indexEstudiante.dart';
import 'package:flutter/material.dart';
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
                    padding: const EdgeInsets.all(25),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'LECTOYA',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 55),
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
                                prefixIcon: Icon(Icons.email_outlined)),
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
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: const InputDecoration(
                                labelText: 'Contraseña',
                                labelStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                floatingLabelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                prefixIcon: Icon(Icons.password_outlined)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Escriba su contraseña';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 2,
                          ),
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
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          GestureDetector(
                              onTap: () async {
                                if (formkey.currentState!.validate()) {
                                  final String correo = correoController.text;
                                  final String password =
                                      passwordController.text;

                                  final response = await (isDocente
                                      ? _docentesAPI.LoginDocente(
                                          correo, password)
                                      : _estudiantesAPI.LoginEstudiantes(
                                          correo, password));

                                  if (response == "Datos incorrectos") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Datos incorrectos'),
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
                                child: const Center(
                                  child: Text(
                                    'Acceder',
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
                                          const RegistroVentana()));
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
                                  "Registrate aquí",
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
