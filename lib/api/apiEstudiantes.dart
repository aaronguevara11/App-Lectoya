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

  Future<Object> ActualizarEstudiante(
      nombre, apaterno, amaterno, correo, numero) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final response = await dio.put(
        'https://lectoya-back.onrender.com/app/actualizarAlumnos',
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

  Future<Map<String, dynamic>> TemasCurso() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
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

  Future<Map<String, dynamic>> DetallesTema() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final idTema = prefs.getString('idTema');

    try {
      final response = await dio.get(
        'https://lectoya-back.onrender.com/app/detalleTema/$idTema',
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

  Future<Map<String, dynamic>> VerInteractiva() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final id = prefs.getString('idNivel');

    try {
      final response = await dio.get(
        'https://lectoya-back.onrender.com/app/interactivas/verNivel/$id',
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      print(response.data);
      return (response.data);
    } catch (e) {
      print(e);
      throw Exception('Error al obtener los temas del curso.');
    }
  }

  Future<Object> EnviarInteractiva(pregunta, respuesta) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final id = prefs.getString('idNivel');

    try {
      final response = await dio.post(
        'https://lectoya-back.onrender.com/app/interactivas/enviarRespuesta',
        data: {
          'pregunta': pregunta,
          'respuesta': respuesta,
          'id': id,
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
      } else if (response.statusCode == 200) {
        if (response.data['message'] == "Respuesta enviada") {
          return "Respuesta enviada";
        } else {
          return "Error al enviar la respuesta";
        }
      } else {
        return "Error desconocido";
      }
    } catch (e) {
      print("Error en la petición: $e");
      return "Error en la petición";
    }
  }

  Future<Map<String, dynamic>> VerRuleteando() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final id = prefs.getString('idNivel');

    try {
      final response = await dio.get(
        'https://lectoya-back.onrender.com/app/ruleta/verNivel/$id',
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      print(response.data);
      return (response.data);
    } catch (e) {
      print(e);
      throw Exception('Error al obtener los temas del curso.');
    }
  }

  Future<Object> EnviarRuleta(pregunta, respuesta) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final id = prefs.getString('idNivel');

    try {
      final response = await dio.post(
        'https://lectoya-back.onrender.com/app/ruleta/enviarRespuesta',
        data: {
          'pregunta': pregunta,
          'respuesta': respuesta,
          'id': id,
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
      } else if (response.statusCode == 200) {
        if (response.data['message'] == "Respuesta enviada") {
          return "Respuesta enviada";
        } else {
          return "Error al enviar la respuesta";
        }
      } else {
        return "Error desconocido";
      }
    } catch (e) {
      print("Error en la petición: $e");
      return "Error en la petición";
    }
  }

  Future<Map<String, dynamic>> VerHaremos() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final id = prefs.getString('idNivel');

    try {
      final response = await dio.get(
        'https://lectoya-back.onrender.com/app/haremos/verNivel/$id',
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      print(response.data);
      return (response.data);
    } catch (e) {
      print(e);
      throw Exception('Error al obtener los temas del curso.');
    }
  }

  Future<Object> EnviarHaremos(pregunta, respuesta) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final id = prefs.getString('idNivel');

    try {
      final response = await dio.post(
        'https://lectoya-back.onrender.com/app/haremos/enviarRespuesta',
        data: {
          'pregunta': pregunta,
          'respuesta': respuesta,
          'id': id,
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
      } else if (response.statusCode == 200) {
        if (response.data['message'] == "Respuesta enviada") {
          return "Respuesta enviada";
        } else {
          return "Error al enviar la respuesta";
        }
      } else {
        return "Error desconocido";
      }
    } catch (e) {
      print("Error en la petición: $e");
      return "Error en la petición";
    }
  }

  Future<Map<String, dynamic>> VerCambialo() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final id = prefs.getString('idNivel');

    try {
      final response = await dio.get(
        'https://lectoya-back.onrender.com/app/cambialo/verNivel/$id',
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      print(response.data);
      return (response.data);
    } catch (e) {
      print(e);
      throw Exception('Error al obtener los temas del curso.');
    }
  }

  Future<Object> EnviarCambialo(respuesta) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final id = prefs.getString('idNivel');

    try {
      final response = await dio.post(
        'https://lectoya-back.onrender.com/app/cambialo/enviarRespuesta',
        data: {
          'respuesta': respuesta,
          'id': id,
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
      } else if (response.statusCode == 200) {
        if (response.data['message'] == "Respuesta enviada") {
          return "Respuesta enviada";
        } else {
          return "Error al enviar la respuesta";
        }
      } else {
        return "Error desconocido";
      }
    } catch (e) {
      print("Error en la petición: $e");
      return "Error en la petición";
    }
  }

  Future<Map<String, dynamic>> VerOrdenalo() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final id = prefs.getString('idNivel');

    try {
      final response = await dio.get(
        'https://lectoya-back.onrender.com/app/ordenalo/verNivel/$id',
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      print(response.data);
      return (response.data);
    } catch (e) {
      print(e);
      throw Exception('Error al obtener los temas del curso.');
    }
  }

  Future<String> EnviarOrdenalo(orden1, orden2, orden3, orden4, orden5) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final idNivel = prefs.getString('idOrdenalo');

    try {
      final response = await dio.post(
        'https://lectoya-back.onrender.com/app/ordenalo/agregarRespuesta',
        data: {
          'orden1': orden1,
          'orden2': orden2,
          'orden3': orden3,
          'orden4': orden4,
          'orden5': orden5,
          'id': idNivel,
        },
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      print(response.data);

      if (response.statusCode == 404) {
        return "El juego no existe o ha sido borrado";
      } else if (response.statusCode == 200) {
        return "Respuesta enviada correctamente";
      } else {
        return "Error desconocido";
      }
    } catch (e) {
      print("Error en la petición: $e");
      return "Error en la petición: $e";
    }
  }

  Future<Map<String, dynamic>> VerSignificado() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final id = prefs.getString('idNivel');

    try {
      final response = await dio.get(
        'https://lectoya-back.onrender.com/app/significado/verNivel/$id',
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      print(response.data);
      return (response.data);
    } catch (e) {
      print(e);
      throw Exception('Error al obtener los temas del curso.');
    }
  }

  Future<String> EnviarSignificado(
    palabra1,
    palabra2,
    palabra3,
    significado1,
    significado2,
    significado3,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final idNivel = prefs.getString('idOrdenalo');
    final token = prefs.getString('token');

    try {
      final response = await dio.post(
        'https://lectoya-back.onrender.com/app/significado/respuestaSignificado',
        data: {
          'palabra1': palabra1,
          'palabra2': palabra2,
          'palabra3': palabra3,
          'significado1': significado1,
          'significado2': significado2,
          'significado3': significado3,
          'id': idNivel,
        },
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      print(response.data);

      if (response.statusCode == 404) {
        return "El juego no existe o ha sido borrado";
      } else if (response.statusCode == 200) {
        return "Respuesta enviada";
      } else {
        return "Error desconocido";
      }
    } catch (e) {
      print("Error en la petición: $e");
      return "Error en la petición: $e";
    }
  }

  Future<Map<String, dynamic>> VerDado() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final id = prefs.getString('idNivel');

    try {
      final response = await dio.get(
        'https://lectoya-back.onrender.com/app/dado/verNivel/$id',
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      print(response.data);
      return (response.data);
    } catch (e) {
      print(e);
      throw Exception('Error al obtener los temas del curso.');
    }
  }

  Future<String> EnviarDado(pregunta, respuesta) async {
    final prefs = await SharedPreferences.getInstance();
    final idNivel = prefs.getString('idOrdenalo');
    final token = prefs.getString('token');

    try {
      final response = await dio.post(
        'https://lectoya-back.onrender.com/app/dado/respuestaDado',
        data: {
          'pregunta': pregunta,
          'respuesta': respuesta,
          'id': idNivel,
        },
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      print(response.data);

      if (response.statusCode == 404) {
        return "El juego no existe o ha sido borrado";
      } else if (response.statusCode == 200) {
        return "Respuesta enviada";
      } else {
        return "Error desconocido";
      }
    } catch (e) {
      print("Error en la petición: $e");
      return "Error en la petición: $e";
    }
  }
}
