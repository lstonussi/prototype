import 'package:salesforce/model/user_model.dart';
import 'package:salesforce/providers/db_provider.dart';
import 'package:salesforce/providers/user_provider.dart';

//Retira a responsabilidade da model, ou seja, a classe deve se ter apenas uma responsabilidade
class LoginRepository {
  Future<bool> doLogin(Usuario model) async {
    var apiUsuario = UsuarioApiProvider();
    await apiUsuario.getAllUsuarios();
    List<Usuario> list = await DBProvider.db.getAllUsuario();
    print(list.contains('lucas'));
    return model.nome == 'a' && model.senha == 'a';
  }
}
