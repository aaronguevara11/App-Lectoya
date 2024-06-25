import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lectoya/screens/Docentes/indexDocente.dart';
import 'package:lectoya/screens/Estudiantes/indexEstudiante.dart';
import 'package:lectoya/screens/Inicio/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkLoginStatus(),
      builder: (context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'LectoYA',
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          final userType = snapshot.data;

          Widget homeScreen;

          if (userType == 'docente') {
            homeScreen = HomeDocente();
          } else if (userType == 'estudiante') {
            homeScreen = HomeEstudiante();
          } else {
            homeScreen = LoginVentana();
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'LectoYA',
            home: homeScreen,
          );
        }
      },
    );
  }

  Future<String?> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? docenteToken = prefs.getString('jwt');
    String? alumnoToken = prefs.getString('token');

    if (docenteToken != null && !JwtDecoder.isExpired(docenteToken)) {
      return 'docente';
    }

    if (alumnoToken != null && !JwtDecoder.isExpired(alumnoToken)) {
      return 'estudiante';
    }

    return null;
  }
}
