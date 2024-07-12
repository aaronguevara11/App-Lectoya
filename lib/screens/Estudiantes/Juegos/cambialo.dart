import 'package:flutter/material.dart';
import 'package:lectoya/api/apiEstudiantes.dart';
import 'package:lectoya/screens/Estudiantes/Curso/Temas/DetalleTema.dart';

class CambialoYaEstudiantes extends StatefulWidget {
  const CambialoYaEstudiantes({super.key});

  @override
  State<CambialoYaEstudiantes> createState() => _Cambialo();
}

class _Cambialo extends State<CambialoYaEstudiantes> {
  EstudiantesAPI estudiantesAPI = EstudiantesAPI();
  Map<String, dynamic>? juego;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController respuestaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final data = await estudiantesAPI.VerCambialo();
      setState(() {
        juego = data['juego'];
      });
    } catch (e) {
      print('Error al cargar los datos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 9, 36, 82),
          title: const Text(
            'Cambialo YA',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 26,
            ),
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Agregale un final con la emoción planteada',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const Divider(),
                              juego != null && juego!['enunciado'] != null
                                  ? Text(
                                      juego!['enunciado'],
                                      style: const TextStyle(fontSize: 18),
                                    )
                                  : const Text(
                                      'Cargando enunciado...',
                                      style: TextStyle(fontSize: 17),
                                    ),
                              Card(
                                color: const Color.fromARGB(255, 233, 233, 233),
                                elevation: 4,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: juego != null &&
                                              juego!['enunciado'] != null
                                          ? Text(
                                              juego!['emocion'],
                                              style:
                                                  const TextStyle(fontSize: 17),
                                            )
                                          : const Text(
                                              'Cargando enunciado...',
                                              style: TextStyle(fontSize: 17),
                                            ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: respuestaController,
                              maxLines: null,
                              minLines: 1,
                              decoration: InputDecoration(
                                fillColor: Colors.black,
                                labelText: 'Respuesta',
                                floatingLabelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Ingrese una respuesta';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 2),
                          GestureDetector(
                            onTap: () async {
                              final respuesta = respuestaController.text;
                              final response =
                                  await estudiantesAPI.EnviarCambialo(
                                      respuesta);

                              if (response == "Respuesta enviada") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Row(
                                      children: [
                                        Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 5),
                                        Text('Respuesta enviada con éxito'),
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
                                        const DetalleTemaEstudiantes(),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Row(
                                      children: [
                                        Icon(
                                          Icons.error,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 5),
                                        Text('Error al enviar la respuesta'),
                                      ],
                                    ),
                                    backgroundColor:
                                        Color.fromARGB(255, 87, 14, 14),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(27),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(16),
                                child: Icon(
                                  Icons.send_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))),
      ),
    );
  }
}
