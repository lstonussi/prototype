import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salesforce/model/session_model.dart';
import 'package:salesforce/providers/client_provider.dart';
import 'package:salesforce/providers/db_provider.dart';
import 'package:salesforce/providers/order_provider.dart';
import 'package:salesforce/providers/product_provider.dart';
import 'package:salesforce/providers/user_provider.dart';
import 'package:salesforce/screens/cliente_screen.dart';
import 'package:salesforce/screens/pedido_screen.dart';
import 'package:salesforce/screens/produto_screen.dart';

class MenuScreen extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  final String urlPedido =
      'https://img.icons8.com/cotton/64/000000/purchase-order.png';
  final String urlCliente =
      'https://www.beijaflorerp.com.br/Content/img/controleUser/controle-de-usuarios.png';
  final String urlProduto =
      'https://img.icons8.com/color/48/000000/move-by-trolley.png';
  final String urlDashboard =
      'https://img.icons8.com/fluent/48/000000/combo-chart.png';
  final String urlSincronizacao =
      'https://img.icons8.com/fluent/48/000000/cloud-sync--v1.png';

  String getSession() {
    Session s;
    return 's.Usuario';
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildButton(String url, String nameButton, int index) {
      return RaisedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  height: 80,
                  width: 80,
                  child: Image.network(url),
                ),
                Text(
                  nameButton,
                  style: TextStyle(fontSize: 25),
                )
              ],
            )
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) {
              switch (index) {
                case 0:
                  {
                    return UsuarioScreen();
                  }
                  break;
                case 1:
                  {
                    return PedidoScreen();
                  }
                  break;
                case 2:
                  {
                    return ProdutoScreen();
                  }
                case 3:
                  {
                    return Container();
                  }
                  break;
                case 4:
                  {
                    return Container();
                  }
                  break;
                default:
                  {
                    return MenuScreen();
                  }
                  break;
              }
            }),
          );
        },
      );
    }

    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Confirmação'),
              content: new Text('Deseja sair do App?'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('Não'),
                ),
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('Sim'),
                ),
              ],
            ),
          )) ??
          false;
    }

    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        appBar: new AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _loadFromApi();
              },
            )
          ],
          title: new Text('Menu'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildButton(urlCliente, 'Clientes', 0),
            SizedBox(
              height: 16,
            ),
            _buildButton(urlPedido, 'Pedidos', 1),
            SizedBox(
              height: 16,
            ),
            _buildButton(urlProduto, 'Produtos', 2),
            SizedBox(
              height: 16,
            ),
            _buildButton(urlDashboard, 'Dashboard', 4),
          ],
        ),
      ),
    );
  }
}

_loadFromApi() async {
  var apiProduto = ProdutoApiProvider();
  var apiCliente = ClienteApiProvider();
  var apiPedido = PedidoApiProvider();
  var apiUsuario = UsuarioApiProvider();
  await DBProvider.db.deleteAllCliente();
  await DBProvider.db.deleteAllProduto();
  await apiCliente.getAllClientes();
  await apiProduto.getAllProdutos();
  await apiPedido.getAllPedidos();
  await apiUsuario.getAllUsuarios();
}
