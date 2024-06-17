import 'package:flutter/material.dart';
import 'package:lectoya/api/apiDocentes.dart'; // Asegúrate de importar tu API aquí

class DetalleTemaDocente extends StatefulWidget {
  const DetalleTemaDocente({super.key});

  @override
  State<DetalleTemaDocente> createState() => _DetalleTemaDocentes();
}

class _DetalleTemaDocentes extends State<DetalleTemaDocente> {
  DocentesAPI docentesAPI = DocentesAPI();
  Map<String, dynamic> temaData = {};

  @override
  void initState() {
    super.initState();
    _getTemaDetails();
  }

  Future<void> _getTemaDetails() async {
    try {
      final Map<String, dynamic> data = await docentesAPI.DetallesTema();
      setState(() {
        temaData = data;
      });
    } catch (e) {
      print(e);
    }
  }

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
      body: temaData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : CardDetalle(temaData: temaData),
    );
  }
}

class CardDetalle extends StatelessWidget {
  final Map<String, dynamic> temaData;

  const CardDetalle({Key? key, required this.temaData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 3 + 100,
        child: Card(
          elevation: 7,
          shadowColor: Colors.grey,
          margin: const EdgeInsets.only(top: 25, left: 20, right: 20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    temaData['nombre'],
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(color: Color.fromARGB(255, 155, 155, 155)),
                  SizedBox(
                    height: 60,
                    child: Text(
                      temaData['lectura'],
                      style: const TextStyle(fontSize: 23),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
