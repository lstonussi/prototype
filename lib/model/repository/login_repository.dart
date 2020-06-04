import 'package:salesforce/model/user_model.dart';
import 'package:salesforce/providers/user_provider.dart';

//Retira a responsabilidade da model, ou seja, a classe deve se ter apenas uma responsabilidade
class LoginRepository {
  Future<bool> doLogin(Usuario model) async {
    var apiUsuario = UsuarioApiProvider();
    List<Usuario> list = await apiUsuario.getAllUsuarios();
    list.map((user) => print(list[0].nome)).toList();
    return model.nome == 'a' && model.senha == 'a';
  }
}
//4.1.x
