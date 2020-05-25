import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salesforce/providers/categoria_provider.dart';
import 'package:salesforce/providers/db_provider.dart';
import 'package:salesforce/widgets/list_screen.dart';

class MenuScreen extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
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
          title: new Text("Menu"),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: DBProvider.db.getAllCategorias(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else {
                return Padding(
                  padding: EdgeInsets.all(50),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.black26,
                    ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Container(
                          height: 60,
                          width: 60,
                          child: snapshot.data[index].imagem == ''
                              ? Image.asset(
                                  'lib/assets/userdefault.png',
                                  fit: BoxFit.fill,
                                )
                              : Image.network(
                                  snapshot.data[index].imagem,
                                  fit: BoxFit.fill,
                                ),
                        ),
                        title: Text(snapshot.data[index].nome),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ListScreen(snapshot, index),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              }
            }),
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
