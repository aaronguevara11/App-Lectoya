import 'package:flutter/material.dart';
import 'package:lectoya/api/apiDocentes.dart';
import 'package:lectoya/screens/Docentes/Curso/Temas/DetalleTema.dart';

class FormSignificado extends StatefulWidget {
  const FormSignificado({super.key});

  @override
  State<FormSignificado> createState() => _Significado();
}

class _Significado extends State<FormSignificado> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  DocentesAPI docentesAPI = DocentesAPI();
  TextEditingController preguntaController = TextEditingController();

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
                'Dale un significado',
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
                              style: TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: preguntaController,
                              maxLines: null,
                              minLines: 1,
                              decoration: InputDecoration(
                                fillColor: Colors.black,
                                labelText: 'Parrafo de la lectura',
                                floatingLabelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                prefixIcon: const Icon(Icons.read_more),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Ingrese un parrafo';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () async {
                                if (formkey.currentState!.validate()) {
                                  final String lectura =
                                      preguntaController.text;

                                  final response =
                                      await docentesAPI.AgregarSignificado(
                                          lectura);

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
