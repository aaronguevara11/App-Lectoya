import 'package:flutter/material.dart';
import 'package:lectoya/api/apiDocentes.dart';
import 'package:lectoya/screens/Docentes/Curso/Temas/DetalleTema.dart';

class FormInteractivas extends StatefulWidget {
  const FormInteractivas({super.key});

  @override
  State<FormInteractivas> createState() => _Interactivas();
}

class _Interactivas extends State<FormInteractivas> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  DocentesAPI docentesAPI = DocentesAPI();
  TextEditingController parrafoController = TextEditingController();
  TextEditingController preguntaController = TextEditingController();
  TextEditingController claveAController = TextEditingController();
  TextEditingController claveBController = TextEditingController();
  TextEditingController claveCController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            backgroundColor: const Color.fromARGB(255, 9, 36, 82),
            title: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Preguntas interactivas',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 26),
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
                              controller: parrafoController,
                              maxLines: null,
                              minLines: 1,
                              decoration: InputDecoration(
                                  fillColor: Colors.black,
                                  labelText: 'Parrafo de la lectura',
                                  floatingLabelStyle: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  prefixIcon: const Icon(Icons.read_more)),
                              validator: (value) {
                                if (value == null) {
                                  return 'Ingrese un parrafo';
                                } else if (value.length <= 25) {
                                  return 'Ingrese un parrafo más larga';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: preguntaController,
                              maxLines: null,
                              minLines: 1,
                              decoration: InputDecoration(
                                  fillColor: Colors.black,
                                  labelText: 'Pregunta de la lectura',
                                  floatingLabelStyle: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  prefixIcon: const Icon(Icons.read_more)),
                              validator: (value) {
                                if (value == null) {
                                  return 'Ingrese una pregunta';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: claveAController,
                              maxLines: null,
                              minLines: 1,
                              decoration: InputDecoration(
                                  fillColor: Colors.black,
                                  labelText: 'Clave A:',
                                  floatingLabelStyle: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  prefixIcon:
                                      const Icon(Icons.task_alt_rounded)),
                              validator: (value) {
                                if (value == null) {
                                  return 'Ingrese una clave';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: claveBController,
                              maxLines: null,
                              minLines: 1,
                              decoration: InputDecoration(
                                  fillColor: Colors.black,
                                  labelText: 'Clave B:',
                                  floatingLabelStyle: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  prefixIcon:
                                      const Icon(Icons.task_alt_rounded)),
                              validator: (value) {
                                if (value == null) {
                                  return 'Ingrese una clave';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: claveCController,
                              maxLines: null,
                              minLines: 1,
                              decoration: InputDecoration(
                                  fillColor: Colors.black,
                                  labelText: 'Clave C:',
                                  floatingLabelStyle: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  prefixIcon:
                                      const Icon(Icons.task_alt_rounded)),
                              validator: (value) {
                                if (value == null) {
                                  return 'Ingrese una clave';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                                onTap: () async {
                                  if (formkey.currentState!.validate()) {
                                    final String parrafo =
                                        parrafoController.text;
                                    final String pregunta =
                                        preguntaController.text;
                                    final String claveA = claveAController.text;
                                    final String claveB = claveBController.text;
                                    final String claveC = claveCController.text;

                                    final response =
                                        docentesAPI.AgregarInteractivas(parrafo,
                                            pregunta, claveA, claveB, claveC);

                                    if (response == "El juego no existe") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                    } else if (response == "Juego agregado") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Row(
                                            children: [
                                              Icon(Icons.check),
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
                                                const DetalleTemaDocente()),
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
                                      'Agregar juego',
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
