import 'dart:convert';

import 'package:salesforce/model/client_model.dart';

List<Pedido> orderFromJson(String str) =>
    List<Pedido>.from(json.decode(str).map((x) => Pedido.fromJson(x)));

String orderToJson(List<Pedido> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pedido {
  int codigo;
  String codigoExterno;
  Cliente cliente;
  double valorBruto;
  double valorLiquido;

  Pedido(
      {this.codigo,
      this.codigoExterno,
      this.cliente,
      this.valorBruto,
      this.valorLiquido});

  factory Pedido.fromJson(Map<dynamic, dynamic> json) => Pedido(
      codigo: json["codigo"],
      codigoExterno: json["codigoExterno"],
      cliente: json["cliente"],
      valorBruto: json["valorLiquido"],
      valorLiquido: json["valorLiquido"]);

  Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "codigoExterno": codigoExterno,
        "cliente": cliente,
        "valorBruto": valorBruto,
        "valorLiquido": valorLiquido
      };
}
