import 'package:flutter/material.dart';
import 'package:salesforce/screens/menu_screen.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            Image.network('https://www.planin.com.br/img/logo.png'),
            TextFormField(
              decoration: InputDecoration(hintText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
              //text é o proprio texto do campo
              validator: (text) {
                if (text.isEmpty || !text.contains('@')) {
                  return "E-mail inválido";
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
              validator: (text) {
                if (text.isEmpty || text.length < 6) {
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
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    //TODO: Criar codigo para fazer o login
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => MenuScreen(),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
