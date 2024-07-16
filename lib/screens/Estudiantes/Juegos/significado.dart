import 'package:flutter/material.dart';
import 'package:lectoya/api/apiEstudiantes.dart';
import 'package:lectoya/screens/Estudiantes/Curso/Temas/DetalleTema.dart';

class DaleSignificadoEstudiantes extends StatefulWidget {
  const DaleSignificadoEstudiantes({super.key});

  @override
  State<DaleSignificadoEstudiantes> createState() => _Significado();
}

class _Significado extends State<DaleSignificadoEstudiantes> {
  final EstudiantesAPI estudiantesAPI = EstudiantesAPI();
  Map<String, dynamic>? juego;
  String palabra1 = '';
  String palabra2 = '';
  String palabra3 = '';
  int selectedCard = 1;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController significadoController1 = TextEditingController();
  TextEditingController significadoController2 = TextEditingController();
  TextEditingController significadoController3 = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final data = await estudiantesAPI.VerSignificado();
      setState(() {
        juego = data['juego'];
      });
    } catch (e) {
      print('Error al cargar los datos: $e');
    }
  }

  void onWordTap(String word) {
    setState(() {
      switch (selectedCard) {
        case 1:
          palabra1 = palabra1 == word ? '' : word;
          break;
        case 2:
          palabra2 = palabra2 == word ? '' : word;
          break;
        case 3:
          palabra3 = palabra3 == word ? '' : word;
          break;
      }
    });
  }

  void selectCard(int cardNumber) {
    setState(() {
      selectedCard = cardNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 9, 36, 82),
          title: const Text(
            'Dale un significado',
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
              crossAxisAlignment: CrossAxisAlignment.end,
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
                            'Elige tres palabras y dales un significado',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Divider(),
                          juego != null && juego!['lectura'] != null
                              ? Wrap(
                                  children: (juego!['lectura'] as String)
                                      .split(' ')
                                      .map<Widget>((word) {
                                    return GestureDetector(
                                      onTap: () => onWordTap(word),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2.0, vertical: 1.0),
                                        child: Text(
                                          word,
                                          style: const TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                )
                              : const Text(
                                  'Cargando lectura...',
                                  style: TextStyle(fontSize: 17),
                                ),
                          const SizedBox(height: 5),
                          buildWordCard(
                              1, 'Palabra 1', palabra1, significadoController1),
                          const SizedBox(height: 5),
                          buildWordCard(
                              2, 'Palabra 2', palabra2, significadoController2),
                          const SizedBox(height: 5),
                          buildWordCard(
                              3, 'Palabra 3', palabra3, significadoController3),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () async {
                    final significado1 = significadoController1.text;
                    final significado2 = significadoController2.text;
                    final significado3 = significadoController3.text;
                    if (formKey.currentState!.validate()) {
                      final response = await estudiantesAPI.EnviarSignificado(
                        palabra1,
                        palabra2,
                        palabra3,
                        significado1,
                        significado2,
                        significado3,
                      );

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
                            backgroundColor: Color.fromARGB(255, 87, 14, 14),
                          ),
                        );
                      }
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
        ),
      ),
    );
  }

  Widget buildWordCard(int cardNumber, String label, String palabra,
      TextEditingController controller) {
    return GestureDetector(
      onTap: () => selectCard(cardNumber),
      onDoubleTap: () {
        setState(() {
          if (cardNumber == 1) {
            palabra1 = '';
            controller.clear();
          } else if (cardNumber == 2) {
            palabra2 = '';
            controller.clear();
          } else if (cardNumber == 3) {
            palabra3 = '';
            controller.clear();
          }
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 7),
            color: selectedCard == cardNumber
                ? Color.fromARGB(255, 230, 230, 230)
                : const Color.fromARGB(255, 232, 232, 232),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                palabra.isEmpty ? label : palabra,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color:
                      selectedCard == cardNumber ? Colors.black : Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            maxLines: null,
            minLines: 1,
            decoration: InputDecoration(
              fillColor: Colors.black,
              labelText: 'Significado',
              floatingLabelStyle: const TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Ingrese un significado';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
