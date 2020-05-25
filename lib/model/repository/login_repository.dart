import 'package:salesforce/model/user_model.dart';

//Retira a responsabilidade da model, ou seja, a classe deve se ter apenas uma responsabilidade
class LoginRepository {
  Future<bool> doLogin(Usuario model) async {
    //Conexão API,BD
    await Future.delayed(Duration(milliseconds: 1));
    return model.nome == 'a' && model.senha == 'a';
  }
}
