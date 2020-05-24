import 'dart:async';

import 'package:flutter/material.dart';
import 'package:salesforce/providers/db_provider.dart';
import 'package:salesforce/providers/user_provider.dart';

class UsuarioScreen extends StatefulWidget {
  UsuarioScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => new _UsuarioScreenState();
}

class _UsuarioScreenState extends State<UsuarioScreen> {
  var isLoading = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuário'),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10.0),
          ),
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await _deleteData();
              },
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          await _loadFromApi();
        },
        child: isLoading ? Container() : _buildEmployeeListView(),
      ),
    );
  }

  _loadFromApi() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = UsuarioApiProvider();
    await apiProvider.getAllUsuarios();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      isLoading = false;
    });
  }

  _deleteData() async {
    setState(() {
      isLoading = true;
    });
    await DBProvider.db.deleteAllUsuario();

    // wait for 1 second to simulate loading of data
    await Future.delayed(const Duration(milliseconds: 1));

    setState(() {
      isLoading = false;
    });

    print('All usuarios deleted');
  }

  _buildEmployeeListView() {
    return FutureBuilder(
      future: DBProvider.db.getAllUsuario(),
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
                  child: snapshot.data[index].no_avatar == ''
                      ? Image.asset(
                          'lib/assets/userdefault.png',
                          fit: BoxFit.fill,
                        )
                      : Image.network(
                          snapshot.data[index].no_avatar,
                          fit: BoxFit.fill,
                        ),
                ),
                title: Text("Name: ${snapshot.data[index].no_usuario} "),
                subtitle: Row(
                  children: <Widget>[
                    Text('CÓDIGO: ${snapshot.data[index].co_usuario}'),
                    Text('Obs: ${snapshot.data[index].co_usuario}')
                  ],
                ),
                onLongPress: () {
                  AlertDialog(
                    title: Text('aaa'),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
