import 'dart:convert';

List<Usuario> usuarioFromJson(String str) =>
    List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

String usuarioToJson(List<Usuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuario {
  int co_usuario;
  String no_usuario;
  String no_senha;
  String no_avatar;

  Usuario({this.co_usuario, this.no_usuario, this.no_senha, this.no_avatar});

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
      co_usuario: json["co_usuario"],
      no_usuario: json["no_usuario"],
      no_senha: json["no_senha"],
      no_avatar: json["no_avatar"]);

  Map<String, dynamic> toJson() => {
        "co_usuario": co_usuario,
        "no_usuario": no_usuario,
        "no_senha": no_senha,
        "no_avatar": no_avatar
      };
}
