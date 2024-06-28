import 'package:flutter/material.dart';
import 'package:lectoya/api/apiDocentes.dart';
import 'package:lectoya/screens/Docentes/Curso/Temas/DetalleTema.dart';

class FormRuleteando extends StatefulWidget {
  const FormRuleteando({super.key});

  @override
  State<FormRuleteando> createState() => _Ruleteando();
}

class _Ruleteando extends State<FormRuleteando> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  DocentesAPI docentesAPI = DocentesAPI();
  TextEditingController primera_preController = TextEditingController();
  TextEditingController segunda_preController = TextEditingController();
  TextEditingController tercera_preController = TextEditingController();
  TextEditingController cuarta_preController = TextEditingController();
  TextEditingController quinta_preController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 9, 36, 82),
          title: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ruleteando',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                ),
              ),
            ],
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
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Agregar'.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: primera_preController,
                              maxLines: null,
                              minLines: 1,
                              decoration: InputDecoration(
                                fillColor: Colors.black,
                                labelText: 'Primera pregunta',
                                floatingLabelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                prefixIcon: const Icon(Icons.filter_1),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Ingrese una pregunta';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: segunda_preController,
                              maxLines: null,
                              minLines: 1,
                              decoration: InputDecoration(
                                fillColor: Colors.black,
                                labelText: 'Segunda pregunta',
                                floatingLabelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                prefixIcon: const Icon(Icons.filter_2),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Ingrese una pregunta';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: tercera_preController,
                              maxLines: null,
                              minLines: 1,
                              decoration: InputDecoration(
                                fillColor: Colors.black,
                                labelText: 'Tercera pregunta',
                                floatingLabelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                prefixIcon: const Icon(Icons.filter_3),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Ingrese una pregunta';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: cuarta_preController,
                              maxLines: null,
                              minLines: 1,
                              decoration: InputDecoration(
                                fillColor: Colors.black,
                                labelText: 'Cuarta pregunta',
                                floatingLabelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                prefixIcon: const Icon(Icons.filter_4),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Ingrese una pregunta';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: quinta_preController,
                              maxLines: null,
                              minLines: 1,
                              decoration: InputDecoration(
                                fillColor: Colors.black,
                                labelText: 'Quinta pregunta',
                                floatingLabelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                prefixIcon: const Icon(Icons.filter_5),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Ingrese una pregunta';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () async {
                                if (formkey.currentState!.validate()) {
                                  final String pregunta1 =
                                      primera_preController.text;
                                  final String pregunta2 =
                                      segunda_preController.text;
                                  final String pregunta3 =
                                      tercera_preController.text;
                                  final String pregunta4 =
                                      cuarta_preController.text;
                                  final String pregunta5 =
                                      quinta_preController.text;
                                  final response =
                                      await docentesAPI.AgregarRuleta(
                                          pregunta1,
                                          pregunta2,
                                          pregunta3,
                                          pregunta4,
                                          pregunta5);

                                  if (response == "El juego no existe") {
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
                                            const DetalleTemaDocente(),
                                      ),
                                    );
                                  } else if (response == "Juego agregado") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Row(
                                          children: [
                                            Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text('Juego agregado con éxito'),
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
                                            const DetalleTemaDocente(),
                                      ),
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
                                    'Agregar juego',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
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
      ),
    );
  }
}
