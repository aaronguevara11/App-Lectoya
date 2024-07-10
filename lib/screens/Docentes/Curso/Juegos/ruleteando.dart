import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lectoya/api/apiDocentes.dart';
import 'package:roulette/roulette.dart';

class RuleteandoDocentes extends StatefulWidget {
  const RuleteandoDocentes({Key? key}) : super(key: key);

  @override
  _RuleteandoDocentesState createState() => _RuleteandoDocentesState();
}

class _RuleteandoDocentesState extends State<RuleteandoDocentes>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DocentesAPI docentesAPI = DocentesAPI();
  Map<String, dynamic>? juego;

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
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final data = await docentesAPI.VerRuleteando();
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
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 270,
                    margin: EdgeInsets.symmetric(vertical: 18),
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
                        )),
                  ),
                  if (selectedNumber != null && selectedQuestion != null) ...[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                      child: Card(
                        elevation: 3,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Pregunta:',
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                selectedQuestion!,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
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
