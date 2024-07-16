import 'package:flutter/material.dart';
import 'package:lectoya/api/apiEstudiantes.dart';
import 'package:lectoya/screens/Estudiantes/Curso/Temas/DetalleTema.dart';

class OrdenaloYaEstudiantes extends StatefulWidget {
  const OrdenaloYaEstudiantes({Key? key}) : super(key: key);

  @override
  State<OrdenaloYaEstudiantes> createState() => _Ordenalo();
}

class _Ordenalo extends State<OrdenaloYaEstudiantes> {
  final EstudiantesAPI estudiantesAPI = EstudiantesAPI();
  Map<String, dynamic>? juego;
  List<String> tarjetas = [
    'Primera tarjeta',
    'Segunda tarjeta',
    'Tercera tarjeta',
    'Cuarta tarjeta',
    'Quinta tarjeta'
  ];

  List<String> ordenTarjetas = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final data = await estudiantesAPI.VerOrdenalo();
      setState(() {
        juego = data['juego'];
        if (juego != null) {
          ordenTarjetas = [
            juego!['parrafo1'],
            juego!['parrafo2'],
            juego!['parrafo3'],
            juego!['parrafo4'],
            juego!['parrafo5'],
          ];
        }
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
            'Ordenalo YA',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Ordena las tarjetas en el orden de la historia',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Divider(),
              ReorderableListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                onReorder: (int oldIndex, int newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final String item = tarjetas.removeAt(oldIndex);
                    tarjetas.insert(newIndex, item);

                    final String ordenItem = ordenTarjetas.removeAt(oldIndex);
                    ordenTarjetas.insert(newIndex, ordenItem);
                  });
                },
                children: tarjetas.map((String tarjeta) {
                  return _buildCard(tarjeta);
                }).toList(),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () async {
                  final response = await estudiantesAPI.EnviarOrdenalo(
                    ordenTarjetas[0],
                    ordenTarjetas[1],
                    ordenTarjetas[2],
                    ordenTarjetas[3],
                    ordenTarjetas[4],
                  );

                  if (response == "Respuesta enviada correctamente") {
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
                        builder: (context) => const DetalleTemaEstudiantes(),
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
    );
  }

  Widget _buildCard(String titulo) {
    String contenido = '';
    switch (titulo) {
      case 'Primera tarjeta':
        contenido = juego != null ? juego!['parrafo1'] ?? '' : '';
        break;
      case 'Segunda tarjeta':
        contenido = juego != null ? juego!['parrafo2'] ?? '' : '';
        break;
      case 'Tercera tarjeta':
        contenido = juego != null ? juego!['parrafo3'] ?? '' : '';
        break;
      case 'Cuarta tarjeta':
        contenido = juego != null ? juego!['parrafo4'] ?? '' : '';
        break;
      case 'Quinta tarjeta':
        contenido = juego != null ? juego!['parrafo5'] ?? '' : '';
        break;
      default:
        contenido = '';
    }

    return Card(
      key: ValueKey(titulo),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: _getBorderColor(titulo),
              width: 7,
            ),
          ),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contenido.isNotEmpty ? contenido : 'Cargando contenido...',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getBorderColor(String tarjeta) {
    switch (tarjeta) {
      case 'Primera tarjeta':
        return const Color.fromARGB(255, 130, 24, 14);
      case 'Segunda tarjeta':
        return const Color.fromARGB(255, 20, 18, 98);
      case 'Tercera tarjeta':
        return const Color.fromARGB(255, 15, 91, 29);
      case 'Cuarta tarjeta':
        return const Color.fromARGB(255, 196, 178, 20);
      case 'Quinta tarjeta':
        return const Color.fromARGB(255, 132, 64, 12);
      default:
        return Colors.black;
    }
  }
}
