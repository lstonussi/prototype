import 'package:salesforce/model/user_model.dart';

//Retira a responsabilidade da model, ou seja, a classe deve se ter apenas uma responsabilidade
class LoginRepository {
  Future<bool> doLogin(UserModel model) async {
    //Conexão API,BD
    await Future.delayed(Duration(milliseconds: 1));
    return model.nome == 'lucas' && model.senha == '123';
  }
}
