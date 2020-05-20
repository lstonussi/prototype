import 'package:flutter/material.dart';
import 'package:salesforce/controller/login_controller.dart';
import 'package:salesforce/model/repository/login_repository.dart';
import 'package:salesforce/screens/menu_screen.dart';

import 'menu_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

@override
class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  LoginController controller;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    controller = LoginController(LoginRepository());
  }

  @override
  void dispose() {
    super.dispose();
  }

  _loginSuccess() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => MenuScreen()),
    );
  }

  _loginError() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('Usuário ou senha incorretos'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: Icon(
              Icons.build,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            //Image.network('https://www.planin.com.br/img/logo.png'),
            Image.asset('lib/assets/logo.png'),
            TextFormField(
              decoration: InputDecoration(hintText: 'Usuário'),
              keyboardType: TextInputType.text,
              //text é o proprio texto do campo
              onSaved: controller.userUsuario,
              validator: (text) {
                if (text.isEmpty) {
                  return "Usuário inválido";
                }
                //Sempre tem que retornar alguma coisa, utiliza-se o null
                return null;
              },
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Senha'),
              obscureText: true,
              onSaved: controller.userSenha,
              validator: (text) {
                if (text.isEmpty) {
                  return "Senha inválida";
                }
                //Sempre tem que retornar alguma coisa, utiliza-se o null
                return null;
              },
            ),
            SizedBox(
              height: 16,
            ),
            //Para deixar o botão mais alto (altura) coloca-se um sizedBox
            SizedBox(
              height: 44,
              child: RaisedButton(
                child: Text(
                  'Entrar',
                  style: TextStyle(fontSize: 18),
                ),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                //Se o isLoading for true o onPressed fica null, deixando o botão desabiiltado
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() {
                          isLoading = true;
                        });
                        //TODO: Criar codigo para fazer o login
                        if (await controller.login()) {
                          _loginSuccess();
                        } else
                          _loginError();
                        setState(() {
                          isLoading = false;
                        });
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
