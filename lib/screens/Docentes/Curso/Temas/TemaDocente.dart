import 'package:flutter/material.dart';
import 'package:lectoya/api/apiDocentes.dart';
import 'package:lectoya/screens/Docentes/Curso/Temas/DetalleTema.dart';
import 'package:lectoya/screens/Docentes/Curso/indexCurso.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemaDocente extends StatefulWidget {
  final List<Map<String, dynamic>> temas;
  const TemaDocente({required this.temas, super.key});

  @override
  State<TemaDocente> createState() => _Temas();
}

class _Temas extends State<TemaDocente> {
  DocentesAPI docentesAPI = DocentesAPI();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController lecturaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: widget.temas.length,
          itemBuilder: (context, index) {
            final tema = widget.temas[index];
            return CardTema(
              id: tema['id'],
              nombre: tema['nombre'],
              descripcion: tema['descripcion'],
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(35),
                          child: SingleChildScrollView(
                            child: Form(
                              key: formkey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Agregar tema'.toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Divider(
                                    height: 2,
                                    color: Color.fromARGB(137, 0, 0, 0),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  TextFormField(
                                    controller: nombreController,
                                    decoration: InputDecoration(
                                        fillColor: Colors.black,
                                        labelText: 'Nombre del tema',
                                        floatingLabelStyle: const TextStyle(
                                            color: Colors.black, fontSize: 15),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        prefixIcon: Icon(Icons.addchart)),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Ingrese un nombre';
                                      } else if (value.length <= 5) {
                                        return 'Ingrese un nombre más largo';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: descripcionController,
                                    maxLines: null,
                                    minLines: 1,
                                    decoration: InputDecoration(
                                        fillColor: Colors.black,
                                        labelText: 'Descripción del tema',
                                        floatingLabelStyle: const TextStyle(
                                            color: Colors.black, fontSize: 15),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        prefixIcon:
                                            Icon(Icons.description_outlined)),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Ingrese una descripción';
                                      } else if (value.length >= 30) {
                                        return 'Ingrese una descripción más breve';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: lecturaController,
                                    maxLines: null,
                                    minLines: 1,
                                    decoration: InputDecoration(
                                        fillColor: Colors.black,
                                        labelText: 'Lectura del tema',
                                        floatingLabelStyle: const TextStyle(
                                            color: Colors.black, fontSize: 15),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        prefixIcon:
                                            const Icon(Icons.read_more)),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Ingrese una lectura';
                                      } else if (value.length <= 25) {
                                        return 'Ingrese una lectura más larga';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 18),
                                  GestureDetector(
                                    onTap: () async {
                                      if (formkey.currentState!.validate()) {
                                        String nombre = nombreController.text;
                                        String descripcion =
                                            descripcionController.text;
                                        String lectura = lecturaController.text;
                                        final response =
                                            await docentesAPI.AgregaTema(
                                                nombre, descripcion, lectura);
                                        if (response ==
                                            "Error en el servidor") {
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
                                              backgroundColor: Color.fromARGB(
                                                  255, 87, 14, 14),
                                            ),
                                          );
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const DetalleCursoDocente()),
                                          );
                                        } else if (response ==
                                            "Hubo un error vuelva a intentarlo más tarde") {
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
                                              backgroundColor: Color.fromARGB(
                                                  255, 87, 14, 14),
                                            ),
                                          );
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const DetalleCursoDocente()),
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
                                                    'Tema agregado con éxito',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              backgroundColor: Color.fromARGB(
                                                  255, 19, 87, 14),
                                            ),
                                          );
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const DetalleCursoDocente()),
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
                                      child: const Center(
                                        child: Text(
                                          'Agregar',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
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
            side: BorderSide(width: 5, color: Color.fromARGB(255, 22, 27, 124)),
          ),
          child: const Icon(
            Icons.add,
            size: 24.0,
          ),
        ),
      ),
    );
  }
}

class CardTema extends StatefulWidget {
  final int id;
  final String nombre;
  final String descripcion;

  CardTema({
    Key? key,
    required this.id,
    required this.nombre,
    required this.descripcion,
  }) : super(key: key);

  @override
  State<CardTema> createState() => _CardTemaState();
}

class _CardTemaState extends State<CardTema> {
  DocentesAPI docentesAPI = DocentesAPI();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: () async {
          final idTema = widget.id.toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('idTema', idTema);
          final response = await docentesAPI.DetallesTema();
          print(response);
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetalleTemaDocente()),
          );
        },
        child: Card(
          elevation: 7,
          shadowColor: Colors.grey,
          margin: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.nombre.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(color: Colors.blueAccent),
                    Text(
                      widget.descripcion,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
