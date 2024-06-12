import 'package:flutter/material.dart';

class DetalleTemaDocente extends StatefulWidget {
  const DetalleTemaDocente({super.key});

  @override
  State<DetalleTemaDocente> createState() => _DetalleTemaDocentes();
}

class _DetalleTemaDocentes extends State<DetalleTemaDocente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 9, 36, 82),
        title: Text(
          'Tema'.toUpperCase(),
          textAlign: TextAlign.start,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: const CardDetalle(),
    );
  }
}

class CardDetalle extends StatelessWidget {
  const CardDetalle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2,
          child: const Card(
            elevation: 7,
            shadowColor: Colors.grey,
            margin: EdgeInsets.only(top: 25, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Titulo lectura',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(color: Color.fromARGB(255, 155, 155, 155)),
                      SizedBox(
                        height: 60,
                        child: Text(
                          'Lectura',
                          style: TextStyle(fontSize: 23),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
