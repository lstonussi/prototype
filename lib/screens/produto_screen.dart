import 'package:flutter/material.dart';
import 'package:salesforce/providers/db_provider.dart';

class ProdutoScreen extends StatefulWidget {
  @override
  _ProdutoScreenState createState() => _ProdutoScreenState();
}

class _ProdutoScreenState extends State<ProdutoScreen> {
  var isLoading = false;

//  _loadFromApi() async {
//    setState(() {
//      isLoading = true;
//    });
//
//    var apiProvider = ProdutoApiProvider();
//    await apiProvider.getAllProdutos();
//
//    // wait for 2 seconds to simulate loading of data
//    //await Future.delayed(const Duration(milliseconds: 1));
//
//    setState(() async {
//      isLoading = false;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10.0),
          ),
        ],
      ),
      body: isLoading ? Container() : _buildListView(),
    );
  }
}

_buildListView() {
  return FutureBuilder(
    future: DBProvider.db.getAllProdutos(),
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
                child: snapshot.data[index].imagem == ''
                    ? Image.asset(
                        'lib/assets/userdefault.png',
                        fit: BoxFit.fill,
                      )
                    : Image.network(
                        snapshot.data[index].image,
                        fit: BoxFit.fill,
                      ),
              ),
              title: Text("${snapshot.data[index].nome}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Códificação: ${snapshot.data[index].codigo}'),
                  Text('Descrição: ${snapshot.data[index].descricao}'),
                  Text('Preço: ${snapshot.data[index].preco}'),
                ],
              ),
              onLongPress: () {
                //TODO: Exibir popmenu
              },
            );
          },
        );
      }
    },
  );
}
