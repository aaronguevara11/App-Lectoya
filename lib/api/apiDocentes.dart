import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DocentesAPI {
  final dio = Dio();
  Future<Object> LoginDocente(correo, password) async {
    try {
      final response = await dio.put(
        'https://lectoya-back.onrender.com/app/loginDocentes',
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
        prefs.setString('jwt', token);
        return token;
      }
    } on DioException catch (e) {
      print(e);
    }
    return "";
  }

  Future<Object> ActualizarDocente(
      nombre, apaterno, amaterno, correo, numero) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
    try {
      final response = await dio.put(
        'https://lectoya-back.onrender.com/app/actualizarDocentes',
        data: {
          'nombre': nombre,
          'apaterno': apaterno,
          'amaterno': amaterno,
          'correo': correo,
          'numero': numero,
        },
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      String message = response.data['message'];

      print(message);

      if (response.statusCode == 500) {
        return "Error en el servidor";
      } else {
        return "Registrado exitosamente";
      }
    } catch (e) {
      print('GA');
    }
    return "";
  }

  Future<Object> AgregarCurso(nombre, descripcion) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
    try {
      final response = await dio.post(
        'https://lectoya-back.onrender.com/app/crearCurso',
        data: {'nombre': nombre, 'descripcion': descripcion},
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      String message = response.data['message'];

      print(message);

      if (response.statusCode == 500) {
        return "Error en el servidor";
      } else {
        return "Registrado exitosamente";
      }
    } catch (e) {
      print('GA');
    }
    return "";
  }

  Future<Map<String, dynamic>> CursosDocente() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');

    try {
      final response = await dio.get(
        'https://lectoya-back.onrender.com/app/cursosDocente',
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        final List<dynamic> cursos = data['cursos'][0]['cursos'];
        print(cursos);
        return {
          'cursos': cursos
              .map((curso) => {
                    'id': curso['id'],
                    'nombreCurso': curso['nombre'],
                    'nombreDocente': curso['docente']['nombre'] +
                        ' ' +
                        curso['docente']['apaterno']
                  })
              .toList(),
        };
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> TemasCurso() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');

    try {
      final response = await dio.get(
        'https://lectoya-back.onrender.com/app/mostrarTemas/17',
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      print(response.data);

      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
