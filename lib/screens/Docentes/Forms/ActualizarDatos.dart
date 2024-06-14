import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lectoya/api/apiDocentes.dart';
import 'package:lectoya/screens/Docentes/indexDocente.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActualizarDocente extends StatefulWidget {
  const ActualizarDocente({super.key});

  @override
  State<ActualizarDocente> createState() => _Actualizar();
}

class _Actualizar extends State<ActualizarDocente> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final DocentesAPI docentesAPI = DocentesAPI();
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
    final token = prefs.getString('jwt');

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
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: const Color.fromARGB(255, 9, 36, 82),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeDocente()));
              },
              color: Colors.white,
            ),
            title: const Text(
              'Actualizar información',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
            automaticallyImplyLeading: false,
          ),
        ),
        body: SafeArea(
            child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
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
                            const SizedBox(height: 20),
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

                                    final response =
                                        await docentesAPI.ActualizarDocente(
                                            nombre,
                                            apaterno,
                                            amaterno,
                                            correo,
                                            numero);

                                    if (response == "Error en el servidor") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Error en el servidor, intentelo de nuevo más tarde'),
                                        ),
                                      );
                                    } else {
                                      await docentesAPI.LoginDocente(
                                          correo, password);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Row(
                                            children: [
                                              Icon(Icons.check),
                                              Text(
                                                  'Docente actualizado con éxito'),
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
                                                const HomeDocente()),
                                      );
                                    }
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 20, 22, 100),
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
              ],
            ),
          ),
        )));
  }
}
