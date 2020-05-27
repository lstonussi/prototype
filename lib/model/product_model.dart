import 'dart:convert';

List<Produto> produtoFromJson(String str) =>
    List<Produto>.from(json.decode(str).map((x) => Produto.fromJson(x)));

String produtoToJson(List<Produto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Produto {
  int codigo;
  String nome;
  String codigoProduto;
  String descricao;
  double preco;
  String imagem;

  Produto(
      {this.codigo,
      this.nome,
      this.codigoProduto,
      this.descricao,
      this.preco,
      this.imagem});

  factory Produto.fromJson(Map<String, dynamic> json) => Produto(
      codigo: json["codigo"],
      nome: json["nome"],
      codigoProduto: json["codigoProduto"],
      descricao: json["descricao"],
      preco: json["preco"],
      imagem: json["imagem"]);

  Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "nome": nome,
        "codigoProduto": codigoProduto,
        "descricao": descricao,
        "preco": preco,
        "imagem": imagem
      };
}
