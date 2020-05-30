import 'package:flutter/material.dart';
import 'package:salesforce/providers/db_provider.dart';

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
        future: DBProvider.db.getAllPedidos(),
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
                  title: Text(snapshot.data.codigo),
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
