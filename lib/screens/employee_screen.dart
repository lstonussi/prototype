import 'dart:async';

import 'package:flutter/material.dart';
import 'package:salesforce/providers/db_provider.dart';
import 'package:salesforce/providers/employee_provider.dart';
import 'package:salesforce/screens/avatar_screen.dart';

class EmployeeScreen extends StatefulWidget {
  EmployeeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => new _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee'),
        centerTitle: true,
        actions: <Widget>[
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

    var apiProvider = EmployeeApiProvider();
    await apiProvider.getAllEmployees();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  _deleteData() async {
    setState(() {
      isLoading = true;
    });
    await DBProvider.db.deleteAllEmployees();

    // wait for 1 second to simulate loading of data
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });

    print('All employees deleted');
  }

  _buildEmployeeListView() {
    return FutureBuilder(
      future: DBProvider.db.getAllEmployees(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.black12,
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
                title: Text(
                    "Name: ${snapshot.data[index].firstName} ${snapshot.data[index].lastName} "),
                subtitle: Text('EMAIL: ${snapshot.data[index].email}'),
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
