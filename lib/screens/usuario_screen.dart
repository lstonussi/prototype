import 'dart:async';

import 'package:flutter/material.dart';
import 'package:salesforce/providers/db_provider.dart';
import 'package:salesforce/providers/user_provider.dart';
import 'package:salesforce/screens/avatar_screen.dart';

class UsuarioScreen extends StatefulWidget {
  UsuarioScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => new _UsuarioScreenState();
}

class _UsuarioScreenState extends State<UsuarioScreen> {
  var isLoading = false;

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

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("Menu"),
        ),
        body: new Center(
          child: Scaffold(
            appBar: AppBar(
              title: Text('Api to sqlite'),
              centerTitle: true,
              actions: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    icon: Icon(Icons.settings_input_antenna),
                    onPressed: () async {
                      await _loadFromApi();
                    },
                  ),
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
            body: isLoading
                ? Column(
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
                  )
                : _buildEmployeeListView(),
          ),
        ),
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
    await Future.delayed(const Duration(seconds: 2));

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
              color: Colors.black12,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Text(
                  "${index + 1}",
                  style: TextStyle(fontSize: 20.0),
                ),
                title: Text("Name: ${snapshot.data[index].no_usuario} "),
                subtitle: Text('EMAIL: ${snapshot.data[index].co_usuario}'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AvatarScreen(snapshot, index),
                    ),
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
