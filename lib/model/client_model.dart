import 'dart:convert';

List<Cliente> clienteFromJson(String str) =>
    List<Cliente>.from(json.decode(str).map((x) => Cliente.fromJson(x)));

String clienteToJson(List<Cliente> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cliente {
  int codigo;
  String nome;
  String senha;
  String avatar;

  Cliente({this.codigo, this.nome, this.senha, this.avatar});

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
      codigo: json["codigo"],
      nome: json["nome"],
      senha: json["senha"],
      avatar: json["avatar"]);

  Map<String, dynamic> toJson() =>
      {"codigo": codigo, "nome": nome, "senha": senha, "avatar": avatar};
}
