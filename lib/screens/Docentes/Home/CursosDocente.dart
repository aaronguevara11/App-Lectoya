import 'package:lectoya/api/apiDocentes.dart';
import 'package:flutter/material.dart';
import 'package:lectoya/screens/Docentes/Curso/indexCurso.dart';
import 'package:lectoya/screens/Docentes/indexDocente.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CursosDocente extends StatefulWidget {
  const CursosDocente({super.key});

  @override
  _CursosDocente createState() => _CursosDocente();
}

class _CursosDocente extends State<CursosDocente> {
  final DocentesAPI docentesAPI = DocentesAPI();
  List<Map<String, dynamic>> cursos = [];

  @override
  void initState() {
    super.initState();
    _getCursos();
  }

  Future<void> _getCursos() async {
    try {
      final courseData = await docentesAPI.CursosDocente();
      setState(() {
        cursos = courseData['cursos'];
      });
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
            'Módulos'.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 35),
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                cursos.isEmpty
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
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )
                        ],
                      ))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cursos.length,
                        itemBuilder: (context, index) {
                          final cursoData = cursos[index];

                          return CardCurso(cursoData: cursoData);
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardCurso extends StatelessWidget {
  final Map<String, dynamic> cursoData;
  final DocentesAPI docentesAPI = DocentesAPI();

  CardCurso({Key? key, required this.cursoData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nombreCurso = cursoData['nombreCurso'];
    final nombreDocente = cursoData['nombreDocente'];
    final id = cursoData['id'];

    return Container(
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Dismissible(
        key: Key(id.toString()),
        background: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 86, 23, 19)),
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: AlignmentDirectional.centerEnd,
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        direction: DismissDirection.endToStart,
        movementDuration: Duration(milliseconds: 500),
        onDismissed: (direction) async {
          final response = await docentesAPI.BorrarCurso(id);
          if (response == "El nivel no ha sido encontrado") {
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
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                backgroundColor: Color.fromARGB(255, 87, 14, 14),
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeDocente()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    Text(
                      'El nivel ha sido borrado con éxito',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                backgroundColor: Color.fromARGB(255, 23, 87, 14),
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeDocente()),
            );
          }
        },
        child: SizedBox(
          width: double.infinity,
          child: InkWell(
            onTap: () async {
              final idCurso = id.toString();
              print(idCurso);
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('idCurso', idCurso);
              await prefs.setString('nombreCurso', nombreCurso);
              try {
                final temas = await docentesAPI.TemasCurso();
                print(temas);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetalleCursoDocente()),
                );
              } catch (e) {
                print('Error al obtener los temas del curso: $e');
              }
            },
            child: Card(
              elevation: 8,
              shadowColor: Colors.grey,
              child: Column(
                children: [
                  Container(
                    height: 140,
                    clipBehavior: Clip.hardEdge,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.4),
                        BlendMode.multiply,
                      ),
                      child: Opacity(
                        opacity: 0.8,
                        child: Image.asset(
                          'assets/logo.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nombreCurso.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Divider(color: Colors.blueAccent),
                              Text(
                                nombreDocente,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
