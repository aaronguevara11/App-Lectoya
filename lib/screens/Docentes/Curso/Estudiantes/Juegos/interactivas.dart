import 'package:flutter/material.dart';
import 'package:lectoya/api/apiEstudiantes.dart';
import 'package:lectoya/screens/Docentes/Curso/Temas/DetalleTema.dart';

class HistoriasInteractivas extends StatefulWidget {
  const HistoriasInteractivas({Key? key}) : super(key: key);

  @override
  _HistoriasInteractivasState createState() => _HistoriasInteractivasState();
}

class _HistoriasInteractivasState extends State<HistoriasInteractivas> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  EstudiantesAPI estudiantesAPI = EstudiantesAPI();
  Map<String, dynamic>? juego;
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final data = await estudiantesAPI.VerInteractiva();
      setState(() {
        juego = data['juego'];
      });
    } catch (e) {
      print(e);
    }
  }

  void onSelectOption(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  Future<void> sendResponse() async {
    if (selectedOption != null) {
      try {
        final respuesta = selectedOption;
        final pregunta = juego!['pregunta'];
        final response =
            await estudiantesAPI.EnviarInteractiva(pregunta, respuesta);
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
              backgroundColor: Color.fromARGB(255, 19, 87, 14),
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const DetalleTemaDocente(),
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
              backgroundColor: Color.fromARGB(255, 87, 14, 14),
            ),
          );
        }
      } catch (e) {
        print(e);
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
            backgroundColor: Color.fromARGB(255, 87, 14, 14),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, seleccione una opción'),
        ),
      );
    }
  }

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
                'Historias interactivas',
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (juego != null) ...[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pregunta'.toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const Divider(),
                              const SizedBox(height: 5),
                              Text(
                                juego!['parrafo'],
                                style: const TextStyle(fontSize: 17),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 1),
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  color:
                                      const Color.fromARGB(255, 229, 229, 229),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      juego!['pregunta'],
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => onSelectOption('A'),
                      onDoubleTap: () => onSelectOption(''),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(vertical: 3),
                        child: Card(
                          elevation: selectedOption == 'A' ? 9 : 3,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.red,
                              width: selectedOption == 'A' ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Clave A'.toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(juego!['claveA']),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => onSelectOption('B'),
                      onDoubleTap: () => onSelectOption(''),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(vertical: 3),
                        child: Card(
                          elevation: selectedOption == 'B' ? 9 : 3,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.blue,
                              width: selectedOption == 'B' ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Clave B'.toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(juego!['claveB']),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => onSelectOption('C'),
                      onDoubleTap: () => onSelectOption(''),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(vertical: 3),
                        child: Card(
                          elevation: selectedOption == 'C' ? 9 : 3,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.green,
                              width: selectedOption == 'C' ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Clave C'.toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(juego!['claveC']),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => sendResponse(),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black,
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            Icons.send_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
