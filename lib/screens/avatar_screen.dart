import 'package:flutter/material.dart';

class AvatarScreen extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final int index;
  AvatarScreen(this.snapshot, this.index);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[Image.network(snapshot.data[index].avatar)],
    );
  }
}
