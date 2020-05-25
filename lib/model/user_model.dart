import 'dart:convert';

List<Usuario> usuarioFromJson(String str) =>
    List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

String usuarioToJson(List<Usuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuario {
  int codigo;
  String nome;
  String senha;
  String avatar;

  Usuario({this.codigo, this.nome, this.senha, this.avatar});

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
      codigo: json["codigo"],
      nome: json["nome"],
      senha: json["senha"],
      avatar: json["avatar"]);

  Map<String, dynamic> toJson() =>
      {"codigo": codigo, "nome": nome, "senha": senha, "avatar": avatar};
}
