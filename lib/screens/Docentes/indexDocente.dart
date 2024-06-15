import 'package:flutter/material.dart';
import 'package:lectoya/api/apiDocentes.dart';
import 'package:lectoya/screens/Docentes/Home/CursosDocente.dart';
import 'package:lectoya/screens/Docentes/Home/Perfil.dart';

class HomeDocente extends StatefulWidget {
  const HomeDocente({super.key});

  @override
  State<HomeDocente> createState() => _HomeDocente();
}

class _HomeDocente extends State<HomeDocente> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  int currentPage = 0;
  final pageController = PageController(initialPage: 0);
  DocentesAPI docentesAPI = DocentesAPI();
  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 216, 216, 216),
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [CursosDocente(), PerfilDocente()],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return AnimatedPadding(
                      padding: MediaQuery.of(context).viewInsets,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.decelerate,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 3 + 80,
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(35),
                          child: Form(
                            key: formkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Agregar nivel',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: nombreController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    labelText: 'Nombre',
                                    labelStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    floatingLabelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    prefixIcon: Icon(Icons.add_chart),
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Ingrese un nombre';
                                    } else if (value.length <= 5) {
                                      return 'Ingrese un nombre más largo';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: descripcionController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    labelText: 'Descripcion',
                                    labelStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    floatingLabelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    prefixIcon:
                                        Icon(Icons.description_outlined),
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Ingrese una descripción';
                                    } else if (value.length <= 5) {
                                      return 'Ingrese una descripción más larga';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                GestureDetector(
                                  onTap: () async {
                                    if (formkey.currentState!.validate()) {
                                      String nombre = nombreController.text;
                                      String descripcion =
                                          descripcionController.text;
                                      final response =
                                          await docentesAPI.AgregarCurso(
                                              nombre, descripcion);
                                      if (response == "Error en el servidor") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Row(
                                              children: [
                                                Icon(
                                                  Icons.error_outline,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  'Hubo un error, intentalo de nuevo más tarde',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            backgroundColor:
                                                Color.fromARGB(255, 87, 14, 14),
                                          ),
                                        );
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeDocente()),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Row(
                                              children: [
                                                Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  'Nivel agregado con éxito',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
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
                                                  const HomeDocente()),
                                        );
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 20, 22, 100),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Agregar',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
          backgroundColor: Colors.white,
          shape: const CircleBorder(
            side: BorderSide(
              width: 5,
            ),
          ),
          child: const Icon(
            Icons.add,
            size: 24.0,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 75,
        shape: const CircularNotchedRectangle(),
        color: Colors.black87,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      currentPage = 0;
                      pageController.animateToPage(0,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOut);
                      setState(() {});
                    },
                    child: const SizedBox(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.book_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            'Modulos',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            SizedBox(
              height: 75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      currentPage = 1;
                      pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOut);
                      setState(() {});
                    },
                    child: const SizedBox(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          Text(
                            'Perfil',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
