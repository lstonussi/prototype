import 'package:dio/dio.dart';
import 'package:salesforce/model/user_model.dart';

import 'db_provider.dart';

class UsuarioApiProvider {
  Future<List<Usuario>> getAllUsuarios() async {
    var url = "http://demo8161595.mockable.io/employee";

    Response response = await Dio().get(url);
    print(url);
    return (response.data as List).map((usuario) {
      print('Inserting $usuario');
      DBProvider.db.createUsuario(Usuario.fromJson(usuario));
    }).toList();
  }
}
