import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salesforce/providers/categoria_provider.dart';
import 'package:salesforce/screens/cliente_screen.dart';
import 'package:salesforce/screens/employee_screen.dart';
import 'package:salesforce/screens/pedido_screen.dart';
import 'package:salesforce/screens/produto_screen.dart';

class MenuScreen extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  final String urlPedido =
      'https://2.bp.blogspot.com/-01-TGLQ52Jw/VeUAfiPpndI/AAAAAAAABrU/Q2Mk4waW8NU/s1600/pedidos.png';
  final String urlCliente =
      'https://www.beijaflorerp.com.br/Content/img/controleUser/controle-de-usuarios.png';
  final String urlProduto =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRmL62i1r20txk1QPjTCh6_-k0TvQ0spAhrTVJns1LDelUk6dA5&usqp=CAU';
  final String urlSincronizacao =
      'https://img2.gratispng.com/20180320/ezq/kisspng-blue-area-trademark-symbol-sign-sync-5ab0d70dd6d274.4635034015215388298799.jpg';

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
                    return EmployeeScreen();
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
          title: new Text("Menu"),
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
            _buildButton(urlProduto, 'Employee', 3),
            SizedBox(
              height: 16,
            ),
            _buildButton(urlSincronizacao, 'Sincronizar', 4),
          ],
        ),
      ),
    );
  }
}

_loadFromApi() async {
  var apiProvider = CategoriaApiProvider();
  await apiProvider.getAllCategorias();

  // wait for 2 seconds to simulate loading of data
  await Future.delayed(const Duration(seconds: 2));
}
