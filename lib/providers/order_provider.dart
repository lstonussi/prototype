import 'package:dio/dio.dart';
import 'package:salesforce/model/order_model.dart';

import 'db_provider.dart';

class PedidoApiProvider {
  Future<List<Pedido>> getAllPedidos() async {
    var url = "https://my-json-server.typicode.com/lstonussi/fakeapi/pedidos";
    Response response = await Dio().get(url);

    return (response.data as List).map((pedido) {
      print('Inserting $pedido');
      DBProvider.db.createPedido(Pedido.fromJson(pedido));
    }).toList();
  }
}
