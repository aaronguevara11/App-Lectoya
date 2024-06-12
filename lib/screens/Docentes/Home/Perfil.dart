import 'package:flutter/material.dart';
import 'package:lectoya/screens/Inicio/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilDocente extends StatefulWidget {
  const PerfilDocente({super.key});

  @override
  State<PerfilDocente> createState() => _Perfil();
}

class _Perfil extends State<PerfilDocente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Card(
          margin:
              const EdgeInsets.only(top: 30, bottom: 30, right: 25, left: 25),
          elevation: 4,
          shadowColor: Colors.grey,
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Perfil',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.remove('jwt');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginVentana()),
                    );
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.redAccent),
                    child: const Center(
                      child: Text(
                        'Cerrar sesion',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
