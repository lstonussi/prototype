import 'dart:convert';

List<Categoria> categoriaFromJson(String str) =>
    List<Categoria>.from(json.decode(str).map((x) => Categoria.fromJson(x)));

String categoriaToJson(List<Categoria> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categoria {
  int codigo;
  String nome;
  String imagem;

  Categoria({this.codigo, this.nome, this.imagem});

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
      codigo: json["codigo"], nome: json["nome"], imagem: json["imagem"]);

  Map<String, dynamic> toJson() =>
      {"codigo": codigo, "nome": nome, "imagem": imagem};
}
