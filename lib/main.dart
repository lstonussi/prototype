import 'package:flutter/material.dart';
import 'package:salesforce/screens/usuario_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sales Force',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          //Cor botão, cor da barra e diversas partes
          primaryColor: Color.fromARGB(255, 0, 51, 102),
        ),
        debugShowCheckedModeBanner: false,
        home: UsuarioScreen());
  }
}
