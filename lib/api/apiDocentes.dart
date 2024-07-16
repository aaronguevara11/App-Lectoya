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
      print(response);
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

  Future<Object> BorrarTema() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
    final id = prefs.getString('idTema');

    try {
      final response = await dio.delete(
        'https://lectoya-back.onrender.com/app/borrarTemas',
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

  Future<Object> AgregarInteractivas(
    parrafo,
    pregunta,
    claveA,
    claveB,
    claveC,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
    final idTema = prefs.getString('idTema');

    try {
      final response = await dio.post(
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
      } else if (response.statusCode == 200) {
        return "Juego agregado";
      } else {
        return "Error desconocido";
      }
    } catch (e) {
      return "Error en la petición";
    }
  }

  Future<Object> AgregarHaremos(
    pregunta,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
    final idTema = prefs.getString('idTema');

    try {
      final response = await dio.post(
        'https://lectoya-back.onrender.com/app/haremos/agregarTrabajo',
        data: {
          'pregunta': pregunta,
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
      } else if (response.statusCode == 200) {
        return "Juego agregado";
      } else {
        return "Error desconocido";
      }
    } catch (e) {
      return "Error en la petición";
    }
  }

  Future<Object> AgregarCambialo(enunciado, emocion) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
    final idTema = prefs.getString('idTema');

    try {
      final response = await dio.post(
        'https://lectoya-back.onrender.com/app/cambialo/agregarTrabajo',
        data: {
          'enunciado': enunciado,
          'emocion': emocion,
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
      } else if (response.statusCode == 200) {
        return "Juego agregado";
      } else {
        return "Error desconocido";
      }
    } catch (e) {
      return "Error en la petición";
    }
  }

  Future<Object> AgregarSignificado(
    lectura,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
    final idTema = prefs.getString('idTema');

    try {
      final response = await dio.post(
        'https://lectoya-back.onrender.com/app/significado/agregarSignificado',
        data: {
          'lectura': lectura,
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
      } else if (response.statusCode == 200) {
        return "Juego agregado";
      } else {
        return "Error desconocido";
      }
    } catch (e) {
      return "Error en la petición";
    }
  }

  Future<Object> AgregarOrdenalo(
    parrafo1,
    parrafo2,
    parrafo3,
    parrafo4,
    parrafo5,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
    final idTema = prefs.getString('idTema');

    try {
      final response = await dio.post(
        'https://lectoya-back.onrender.com/app/ordenalo/agregarOrdenalo',
        data: {
          'parrafo1': parrafo1,
          'parrafo2': parrafo2,
          'parrafo3': parrafo3,
          'parrafo4': parrafo4,
          'parrafo5': parrafo5,
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
      } else if (response.statusCode == 200) {
        return "Juego agregado";
      } else {
        return "Error desconocido";
      }
    } catch (e) {
      return "Error en la petición";
    }
  }

  Future<Object> AgregarDado(
    primera_pre,
    segunda_pre,
    tercera_pre,
    cuarta_pre,
    quinta_pre,
    sexta_pre,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
    final idTema = prefs.getString('idTema');

    try {
      final response = await dio.post(
        'https://lectoya-back.onrender.com/app/dado/agregarDado',
        data: {
          'primera_pre': primera_pre,
          'segunda_pre': segunda_pre,
          'tercera_pre': tercera_pre,
          'cuarta_pre': cuarta_pre,
          'quinta_pre': quinta_pre,
          'sexta_pre': sexta_pre,
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
      } else if (response.statusCode == 200) {
        return "Juego agregado";
      } else {
        return "Error desconocido";
      }
    } catch (e) {
      return "Error en la petición";
    }
  }

  Future<Object> AgregarRuleta(
      pregunta1, pregunta2, pregunta3, pregunta4, pregunta5) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
    final idTema = prefs.getString('idTema');

    try {
      final response = await dio.post(
        'https://lectoya-back.onrender.com/app/ruleta/agregarRuleta',
        data: {
          'pregunta1': pregunta1,
          'pregunta2': pregunta2,
          'pregunta3': pregunta3,
          'pregunta4': pregunta4,
          'pregunta5': pregunta5,
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
      } else if (response.statusCode == 200) {
        return "Juego agregado";
      } else {
        return "Error desconocido";
      }
    } catch (e) {
      return "Error en la petición";
    }
  }

  Future<Map<String, dynamic>> VerInteractiva() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
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

  Future<Map<String, dynamic>> VerRuleteando() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
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

  Future<Map<String, dynamic>> VerHaremos() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
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

  Future<Map<String, dynamic>> VerCambialo() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
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

  Future<Map<String, dynamic>> VerDado() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
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

  Future<Map<String, dynamic>> VerOrdenalo() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
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

  Future<Map<String, dynamic>> VerSignificado() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
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

  Future<Object> BorrarJuego() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
    final idNivel = prefs.getString('idNivel');
    try {
      final response = await dio.delete(
        'https://lectoya-back.onrender.com/app/juegos/borrarJuegos',
        data: {
          'id': idNivel,
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

  Future<Map<String, dynamic>> VerRespuestas() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
    final id = prefs.getString('idNivel');

    try {
      final response = await dio.get(
        'https://lectoya-back.onrender.com/app/juegos/verRespuesta/$id',
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
}
