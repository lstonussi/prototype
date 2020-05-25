import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salesforce/providers/db_provider.dart';
import 'package:salesforce/providers/user_provider.dart';

class ListScreen extends StatefulWidget {
  final AsyncSnapshot snapshot;

  var index;
  ListScreen(this.snapshot, this.index);

  @override
  State<StatefulWidget> createState() => new _ListScreenState(snapshot, index);
}

class _ListScreenState extends State<ListScreen> {
  var isLoading = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  final snapshot;

  var index;

  _ListScreenState(this.snapshot, this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(snapshot.data[index].nome),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10.0),
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          await _loadFromApi();
        },
        child: isLoading ? Container() : _buildListView(),
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

  _buildListView() {
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
                  child: snapshot.data[index].avatar == ''
                      ? Image.asset(
                          'lib/assets/userdefault.png',
                          fit: BoxFit.fill,
                        )
                      : Image.network(
                          snapshot.data[index].avatar,
                          fit: BoxFit.fill,
                        ),
                ),
                title: Text("Name: ${snapshot.data[index].nome} "),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('CÓDIGO: ${snapshot.data[index].codigo}'),
                    Text('OBS: ${snapshot.data[index].nome}')
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
}
