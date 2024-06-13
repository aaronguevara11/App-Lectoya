import 'package:flutter/material.dart';
import 'package:lectoya/api/apiDocentes.dart';

class ActualizarDocente extends StatefulWidget {
  const ActualizarDocente({super.key});

  @override
  State<ActualizarDocente> createState() => _Actualizar();
}

class _Actualizar extends State<ActualizarDocente> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final DocentesAPI docentesAPI = DocentesAPI();
  TextEditingController nombreController = TextEditingController();
  TextEditingController paternoController = TextEditingController();
  TextEditingController maternoController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nombreController,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                    labelText: 'Nombre',
                    labelStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    floatingLabelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    prefixIcon: Icon(Icons.person)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Escriba su nombre';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
