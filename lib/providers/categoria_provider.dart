import 'package:dio/dio.dart';
import 'package:salesforce/model/categoria_model.dart';
import 'package:salesforce/model/user_model.dart';

import 'db_provider.dart';

class CategoriaApiProvider {
  Future<List<Usuario>> getAllCategorias() async {
    var url = "https://my-json-server.typicode.com/lstonussi/fakeapi/categoria";
    Response response = await Dio().get(url);

    return (response.data as List).map((categoria) {
      print('Inserting $categoria');
      DBProvider.db.createCategoria(Categoria.fromJson(categoria));
    }).toList();
  }
}
