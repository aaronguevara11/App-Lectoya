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

  Future<Object> RegistrarDocente(
      nombre, apaterno, amaterno, correo, numero, dni, password) async {
    try {
      final response = await dio.post(
        'https://lectoya-back.onrender.com/app/registrarDocentes',
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
}
