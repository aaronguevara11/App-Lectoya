import 'package:flutter/material.dart';
import 'package:lectoya/api/apiEstudiantes.dart';
import 'package:lectoya/screens/Estudiantes/Curso/Temas/DetalleTema.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemaEstudiante extends StatefulWidget {
  final List<Map<String, dynamic>> temas;
  const TemaEstudiante({required this.temas, super.key});

  @override
  State<TemaEstudiante> createState() => _Temas();
}

class _Temas extends State<TemaEstudiante> {
  EstudiantesAPI estudiantesAPI = EstudiantesAPI();
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
  EstudiantesAPI estudiantesAPI = EstudiantesAPI();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: () async {
          final idTema = widget.id.toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('idTema', idTema);
          final response = await estudiantesAPI.DetallesTema();
          print(response);
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetalleTemaEstudiantes()),
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
