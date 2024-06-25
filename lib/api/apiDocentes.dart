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

      print(response.data);

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

  Future<Object> BorrarCurso(id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
    try {
      final response = await dio.delete(
        'https://lectoya-back.onrender.com/app/eliminarCurso',
        data: {
          'id': id,
        },
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      String message = response.data['message'];

      print(message);

      if (response.statusCode == 404) {
        return "El nivel no ha sido encontrado";
      } else {
        return "Nivel borrado exitosamente";
      }
    } catch (e) {
      print('GA');
    }
    return "";
  }

  Future<Map<String, dynamic>> TemasCurso() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
    final idCurso = prefs.getString('idCurso');

    try {
      final response = await dio.get(
        'https://lectoya-back.onrender.com/app/mostrarTemas/$idCurso',
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      print(response.data);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        List<dynamic> temasList = data['Tema']['temas'];
        List<Map<String, dynamic>> temas = temasList.map((tema) {
          return {
            'id': tema['id'],
            'nombre': tema['nombre'],
            'descripcion': tema['descripcion']
          };
        }).toList();

        return {'temas': temas};
      } else {
        throw Exception('Error al obtener los temas del curso.');
      }
    } catch (e) {
      print(e);
      throw Exception('Error al obtener los temas del curso.');
    }
  }

  Future<Map<String, dynamic>> EstudiantesCurso() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
    final idCurso = prefs.getString('idCurso');

    try {
      final response = await dio.get(
        'https://lectoya-back.onrender.com/app/mostrarTemas/$idCurso',
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        print(data); // Depuración: Imprimir la respuesta completa de la API

        List<dynamic> matriculasList = data['Tema']['matriculas'];
        List<Map<String, dynamic>> estudiantes = [];

        for (var matricula in matriculasList) {
          var alumno = matricula['alumnos'];
          estudiantes.add(
              {'nombre': alumno['nombre'], 'apaterno': alumno['apaterno']});
        }

        return {'estudiantes': estudiantes};
      } else {
        throw Exception('Error al obtener los estudiantes del curso.');
      }
    } catch (e) {
      print(e);
      throw Exception('Error al obtener los estudiantes del curso.');
    }
  }

  Future<Object> AgregaTema(nombre, descripcion, lectura) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
    final idCurso = prefs.getString('idCurso');
    try {
      final response = await dio.post(
        'https://lectoya-back.onrender.com/app/agregarTemas',
        data: {
          'idCurso': idCurso,
          'nombre': nombre,
          'descripcion': descripcion,
          'lectura': lectura
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
      } else if (response.statusCode == 404) {
        return "Hubo un error vuelva a intentarlo más tarde";
      } else {
        return "Registrado exitosamente";
      }
    } catch (e) {
      print('GA');
    }
    return "";
  }

  Future<Map<String, dynamic>> DetallesTema() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
    final idTema = prefs.getString('idTema');

    try {
      final response = await dio.get(
        'https://lectoya-back.onrender.com/app/verTema/$idTema',
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      print(response.data);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final Map<String, dynamic> temaData = data['Temas'];

        final result = {
          'id': temaData['id'],
          'nombre': temaData['nombre'],
          'lectura': temaData['lectura'],
          'juegos': temaData['juegos']
        };

        print(result);
        return result;
      } else {
        throw Exception('Error al obtener los temas del curso.');
      }
    } catch (e) {
      print(e);
      throw Exception('Error al obtener los temas del curso.');
    }
  }

  Future<String> AgregarInteractivas(
    String parrafo,
    String pregunta,
    String claveA,
    String claveB,
    String claveC,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
    final idTema = prefs.getString('idTema');

    try {
      final response = await Dio().post(
        'https://lectoya-back.onrender.com/app/interactivas/agregarHistoria',
        data: {
          'parrafo': parrafo,
          'pregunta': pregunta,
          'claveA': claveA,
          'claveB': claveB,
          'claveC': claveC,
          'idTema': idTema,
        },
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      print(response.data);

      if (response.statusCode == 404) {
        return "El juego no existe";
      } else if (response.data == "{message: Historia creada}") {
        return "Juego agregado";
      } else {
        return "Error desconocido";
      }
    } catch (e) {
      return "Error en la petición";
    }
  }
}
