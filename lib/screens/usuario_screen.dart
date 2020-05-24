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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              color: Colors.black12,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Image.network(
                    "https://img.icons8.com/ios-glyphs/30/000000/user-male.png"),
                title: Text("Name: ${snapshot.data[index].no_usuario} "),
                subtitle: Row(
                  children: <Widget>[
                    Text('CÓDIGO: ${snapshot.data[index].co_usuario}'),
                    Text('Obs: ${snapshot.data[index].co_usuario}')
                  ],
                ),
//                onTap: () {
//                  Navigator.of(context).push(
//                    MaterialPageRoute(
//                      builder: (context) => AvatarScreen(snapshot, index),
//                    ),
//                  );
//                },
              );
            },
          );
        }
      },
    );
  }
}
