import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EstudiantesAPI {
  final dio = Dio();
  Future<Object> LoginEstudiantes(correo, password) async {
    try {
      final response = await dio.put(
        'https://lectoya-back.onrender.com/app/loginAlumnos',
        data: {'correo': correo, 'password': password},
      );
      var result = response.data.toString();

      String message = response.data['message'];

      print(message);

      if (result == "{message: Datos incorrectos}") {
        return "Datos incorrectos";
      } else if (response.statusCode == 500) {
        return "Error en el servidor";
      } else {
        final token = response.data['token'];
        print(token);

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);

        return token;
      }
    } on DioException catch (e) {
      print(e);
    }
    return "";
  }

  Future<Object> RegistrarEstudiante(
      nombre, apaterno, amaterno, correo, numero, dni, password) async {
    try {
      final response = await dio.post(
        'https://lectoya-back.onrender.com/app/registrarAlumnos',
        data: {
          'nombre': nombre,
          'apaterno': apaterno,
          'amaterno': amaterno,
          'correo': correo,
          'numero': numero,
          'dni': dni,
          'password': password
        },
      );
      var result = response.data.toString();

      String message = response.data['message'];

      print(message);

      if (result == "{message: El docente ya existe}") {
        return "Datos incorrectos";
      } else if (response.statusCode == 500) {
        return "Error en el servidor";
      } else {
        return "Registrado exitosamente";
      }
    } catch (e) {
      print('GA');
    }
    return "";
  }

  Future<Map<String, dynamic>> CursosEstudiante() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await dio.get(
        'https://lectoya-back.onrender.com/app/cursosAlumno',
        options: Options(headers: {'Authorization': token}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        final List<dynamic> cursos = data['cursos'];

        List<Map<String, dynamic>> dataCursos = [];

        for (var curso in cursos) {
          for (var matricula in curso['matriculas']) {
            dataCursos.add({
              'idCurso': matricula['cursos']['id'],
              'nombreCurso': matricula['cursos']['nombre'],
              'nombreDocente': matricula['cursos']['docente']['nombre'] +
                  ' ' +
                  matricula['cursos']['docente']['apaterno'],
            });
          }
        }

        print(cursos);

        return {
          'cursos': dataCursos,
        };
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
