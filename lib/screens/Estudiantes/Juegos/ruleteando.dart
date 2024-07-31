import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lectoya/api/apiEstudiantes.dart';
import 'package:lectoya/screens/Estudiantes/Curso/Temas/DetalleTema.dart';
import 'package:roulette/roulette.dart';

class RuleteandoEstudiantes extends StatefulWidget {
  const RuleteandoEstudiantes({Key? key}) : super(key: key);

  @override
  _RuleteandoEstudiantesState createState() => _RuleteandoEstudiantesState();
}

class _RuleteandoEstudiantesState extends State<RuleteandoEstudiantes>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  EstudiantesAPI estudiantesAPI = EstudiantesAPI();
  Map<String, dynamic>? juego;
  TextEditingController respuestaController = TextEditingController();

  final values = [1, 2, 3, 4, 5];
  int? selectedNumber;
  String? selectedQuestion;

  final List<Color> numberColors = [
    Color.fromARGB(255, 192, 43, 73),
    Color.fromARGB(255, 217, 217, 217),
    Color.fromARGB(255, 152, 192, 217),
    Color.fromARGB(255, 53, 106, 174),
    Color.fromARGB(255, 61, 91, 129),
  ];

  late final RouletteGroup group = RouletteGroup.uniform(
    values.length,
    colorBuilder: (index) => numberColors[index],
    textBuilder: (index) => values[index].toString(),
    textStyleBuilder: (index) => const TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  );

  late final RouletteController controller = RouletteController(
    group: group,
    vsync: this,
  );

  @override
  void dispose() {
    controller.dispose();
    respuestaController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final data = await estudiantesAPI.VerRuleteando();
      setState(() {
        juego = data['juego'];
      });
    } catch (e) {
      print(e);
    }
  }

  void spinWheel() async {
    final random = Random();
    int newSelected = random.nextInt(values.length);
    await controller.rollTo(newSelected);
    setState(() {
      selectedNumber = values[newSelected];
      switch (selectedNumber) {
        case 1:
          selectedQuestion = juego?['pregunta1'];
          break;
        case 2:
          selectedQuestion = juego?['pregunta2'];
          break;
        case 3:
          selectedQuestion = juego?['pregunta3'];
          break;
        case 4:
          selectedQuestion = juego?['pregunta4'];
          break;
        case 5:
          selectedQuestion = juego?['pregunta5'];
          break;
        default:
          selectedQuestion = null;
      }
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
            'Ruleteando',
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 270,
                      margin: const EdgeInsets.symmetric(vertical: 18),
                      child: Roulette(
                        controller: controller,
                        style: const RouletteStyle(
                          centerStickerColor: Colors.red,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: spinWheel,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cached_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '¡Girar!',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 12,
                      ),
                      child: Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Pregunta:',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                selectedQuestion ??
                                    'Gira la ruleta para ver tu pregunta',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () async {
                              if (selectedQuestion == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Row(
                                      children: [
                                        Icon(
                                          Icons.warning,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 5),
                                        Text('Debe girar la ruleta'),
                                      ],
                                    ),
                                    backgroundColor:
                                        Color.fromARGB(255, 184, 89, 33),
                                  ),
                                );
                                return;
                              }

                              final respuesta = respuestaController.text;
                              final response =
                                  await estudiantesAPI.EnviarRuleta(
                                      selectedQuestion!, respuesta);

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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
