import 'package:lectoya/api/apiDocentes.dart';
import 'package:flutter/material.dart';
import 'package:lectoya/screens/Docentes/Curso/indexCurso.dart';

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
        preferredSize: Size.fromHeight(70.0), // Adjust height as needed
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 9, 36, 82),
          title: Text(
            'Cursos'.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                cursos.isEmpty
                    ? const SizedBox(
                        child: Center(
                          child: Text(
                            'Aún no te has matriculado \na ningún curso',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
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

    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: () {
          print(id);
          docentesAPI.TemasCurso();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetalleCursoDocente()),
          );
        },
        child: Card(
          elevation: 8,
          shadowColor: Colors.grey,
          margin: const EdgeInsets.all(10.0),
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
    );
  }
}
