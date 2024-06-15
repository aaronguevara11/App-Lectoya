import 'package:flutter/material.dart';
import 'package:lectoya/api/apiDocentes.dart';

class EstudiantesCursoDocente extends StatefulWidget {
  const EstudiantesCursoDocente({super.key});

  @override
  State<EstudiantesCursoDocente> createState() => _EstudiantesCurso();
}

class _EstudiantesCurso extends State<EstudiantesCursoDocente> {
  DocentesAPI docentesAPI = DocentesAPI();
  List<Map<String, dynamic>> estudiantes = [];

  @override
  void initState() {
    super.initState();
    _loadEstudiantes();
  }

  Future<void> _loadEstudiantes() async {
    try {
      final response = await docentesAPI.EstudiantesCurso();
      setState(() {
        estudiantes = List<Map<String, dynamic>>.from(response['estudiantes']);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: estudiantes.isEmpty
          ? const Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Cargando...',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                )
              ],
            ))
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: estudiantes.length,
                  itemBuilder: (context, index) {
                    final estudiante = estudiantes[index];
                    return CardAlumno(
                      nombre:
                          '${estudiante['nombre']} ${estudiante['apaterno']}',
                    );
                  },
                ),
              ),
            ),
    );
  }
}

class CardAlumno extends StatelessWidget {
  final String nombre;

  const CardAlumno({required this.nombre, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 120,
        width: double.infinity,
        child: Card(
          margin: EdgeInsets.all(10),
          elevation: 4,
          shadowColor: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Icon(
                  Icons.person_2_outlined,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Text(
                  nombre,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
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
