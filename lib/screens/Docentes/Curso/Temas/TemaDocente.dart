import 'package:flutter/material.dart';
import 'package:lectoya/screens/Docentes/Curso/Temas/DetalleTema.dart';

class TemaDocente extends StatefulWidget {
  final List<Map<String, dynamic>> temas; // Lista de temas recibida

  const TemaDocente({required this.temas, super.key});

  @override
  State<TemaDocente> createState() => _Temas();
}

class _Temas extends State<TemaDocente> {
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

class CardTema extends StatelessWidget {
  final int id;
  final String nombre;
  final String descripcion;

  const CardTema({
    Key? key,
    required this.id,
    required this.nombre,
    required this.descripcion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: () {
          Navigator.push(
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
                      nombre.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(color: Colors.blueAccent),
                    Text(
                      descripcion,
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
