import 'package:flutter/material.dart';
import 'package:lectoya/api/apiEstudiantes.dart';
import 'package:lectoya/screens/Docentes/Curso/Estudiantes/CursoEstudiantes.dart';
import 'package:lectoya/screens/Estudiantes/Curso/Temas/TemaEstudiante.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetalleCurso extends StatefulWidget {
  const DetalleCurso({super.key});

  @override
  State<DetalleCurso> createState() => _Curso();
}

class _Curso extends State<DetalleCurso> {
  List<Map<String, dynamic>> temas = [];
  final EstudiantesAPI estudiantesAPI = EstudiantesAPI();
  int currentPage = 0;
  final pageController = PageController(initialPage: 0);
  String nombreCurso = '';

  @override
  void initState() {
    super.initState();
    loadTemas();
  }

  Future<void> loadTemas() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? nombreCursoPref = prefs.getString('nombreCurso');
      if (nombreCursoPref != null) {
        setState(() {
          nombreCurso = nombreCursoPref;
        });

        final response = await estudiantesAPI.TemasCurso();
        if (response.containsKey('temas')) {
          setState(() {
            temas = List<Map<String, dynamic>>.from(response['temas']);
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 9, 36, 82),
          title: Text(
            nombreCurso,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 30),
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          TemaEstudiante(temas: temas),
          const EstudiantesCursoDocente(),
        ],
      ),
    );
  }
}
