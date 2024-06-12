import 'package:flutter/material.dart';
import 'package:lectoya/screens/Estudiantes/Home/CursosEstudiantes.dart';
import 'package:lectoya/screens/Estudiantes/Home/Perfil.dart';

class HomeEstudiante extends StatefulWidget {
  const HomeEstudiante({super.key});

  @override
  State<HomeEstudiante> createState() => _HomeEstudiante();
}

class _HomeEstudiante extends State<HomeEstudiante> {
  int currentPage = 0;
  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 216, 216, 216),

        //Body - especifica a donde va a redirigir luego de hacer click en el icono
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [CursosEstudiante(), PerfilEstudiante()],
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
                    label: 'Modulos',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_2_outlined),
                    label: 'Perfil',
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
