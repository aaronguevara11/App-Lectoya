import 'package:flutter/material.dart';

class EstudiantesCursoDocente extends StatefulWidget {
  const EstudiantesCursoDocente({super.key});

  @override
  State<EstudiantesCursoDocente> createState() => _EstudiantesCurso();
}

class _EstudiantesCurso extends State<EstudiantesCursoDocente> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        CardAlumno(),
        CardAlumno(),
        CardAlumno(),
        CardAlumno(),
        CardAlumno(),
        CardAlumno(),
      ],
    )));
  }
}

class CardAlumno extends StatelessWidget {
  const CardAlumno({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 120,
        width: double.infinity,
        child: Card(
          margin: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
          elevation: 4,
          shadowColor: Colors.grey,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person_2_outlined,
                      size: 30, // Increased icon size
                    ),
                    SizedBox(width: 10), // Added spacing between icon and text
                    Text(
                      'Nombre Apellido',
                      style: TextStyle(
                        fontSize: 23, // Increased text size
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
