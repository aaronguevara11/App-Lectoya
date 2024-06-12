import 'package:flutter/material.dart';
import 'package:lectoya/screens/Docentes/Curso/Temas/DetalleTema.dart';

class TemaDocente extends StatefulWidget {
  const TemaDocente({super.key});

  @override
  State<TemaDocente> createState() => _Temas();
}

class _Temas extends State<TemaDocente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: const Column(children: [CardTema(), CardTema()]),
      ),
    );
  }
}

class CardTema extends StatelessWidget {
  const CardTema({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 160,
      child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetalleTemaDocente()),
            );
          },
          child: const Card(
            elevation: 7,
            shadowColor: Colors.grey,
            margin: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nombre del Tema',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(color: Colors.blueAccent),
                      Text(
                        'Descripcion del tema',
                        style: TextStyle(fontSize: 23),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
