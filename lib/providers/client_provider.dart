import 'package:dio/dio.dart';
import 'package:salesforce/model/client_model.dart';
import 'package:salesforce/model/user_model.dart';

import 'db_provider.dart';

class ClienteApiProvider {
  Future<List<Cliente>> getAllClientes() async {
    var url = "https://my-json-server.typicode.com/lstonussi/fakeapi/usuarios";
    Response response = await Dio().get(url);

    return (response.data as List).map((cliente) {
      print('Inserting $cliente');
      DBProvider.db.createCliente(Usuario.fromJson(cliente));
    }).toList();
  }
}
