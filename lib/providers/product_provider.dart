import 'package:dio/dio.dart';
import 'package:salesforce/model/product_model.dart';

import 'db_provider.dart';

class ProdutoApiProvider {
  Future<List<Produto>> getAllProdutos() async {
    var url = "https://my-json-server.typicode.com/lstonussi/fakeapi/produtos";
    Response response = await Dio().get(url);

    return (response.data as List).map((produto) {
      print('Inserting $produto');
      DBProvider.db.createProduto(Produto.fromJson(produto));
    }).toList();
  }
}
