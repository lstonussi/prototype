import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PedidoScreen extends StatefulWidget {
  @override
  _PedidoScreenState createState() => _PedidoScreenState();
}

class _PedidoScreenState extends State<PedidoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedidos'),
      ),
      body: FutureBuilder(
        future: getAllPedidos(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: CircularProgressIndicator(),
                ),
                SizedBox(
                  height: 16,
                ),
                Text('Carregando dados...'),
              ],
            );
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.black26,
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Container(
                    height: 60,
                    width: 60,
                    child: Image.asset(
                      'lib/assets/userdefault.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  title: Text("Name: ${snapshot.data[index].codigo} "),
                  onLongPress: () {
                    //TODO: Exibir popmenu
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

Future<List> getAllPedidos() async {
  var url = "https://my-json-server.typicode.com/lstonussi/fakeapi/pedidos";
  Response response = await Dio().get(url);

  return (response.data as List).map((pedido) {
    print(pedido.data.codigo);
  }).toList();
}
