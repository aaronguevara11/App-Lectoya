import 'package:flutter/material.dart';
import 'package:lectoya/screens/Estudiantes/Curso/Estudiantes/EstudiantesCurso.dart';
import 'package:lectoya/screens/Estudiantes/Curso/Temas/TemaEstudiante.dart';

class DetalleCurso extends StatefulWidget {
  const DetalleCurso({super.key});

  @override
  State<DetalleCurso> createState() => _Curso();
}

class _Curso extends State<DetalleCurso> {
  int currentPage = 0;
  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 9, 36, 82),
          title: Text(
            'Temas'.toUpperCase(),
            textAlign: TextAlign.start,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [TemaEstudiante(), EstudiantesCurso()],
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0), // Set desired top-left radius
            topRight: Radius.circular(20.0), // Set desired top-right radius
          ),
          child: SafeArea(
            child: SizedBox(
              height: 70,
              child: BottomNavigationBar(
                currentIndex: currentPage,
                onTap: (index) {
                  currentPage = index;
                  pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut);

                  setState(() {});
                },
                backgroundColor: Colors.black,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white54,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.book_outlined),
                    label: 'Temas',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_2_outlined),
                    label: 'Estudiantes',
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
