import 'package:flutter/material.dart';

class HistoriasInteractivas extends StatefulWidget {
  const HistoriasInteractivas({super.key});

  @override
  State<HistoriasInteractivas> createState() => _Interactivas();
}

class _Interactivas extends State<HistoriasInteractivas> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 9, 36, 82),
          title: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Preguntas interactivas',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 26),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formkey,
              child: const Column(
                children: [Text('Hola')],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
