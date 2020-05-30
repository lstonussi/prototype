import 'itemOrder_model.dart';

class Pedido {
  int codigo;
  String codigoExterno;
  int cliente;
  double valorBruto;
  double valorLiquido;
  List<ItemPedido> itemPedido;

  Pedido(
      {this.codigo,
      this.codigoExterno,
      this.cliente,
      this.valorBruto,
      this.valorLiquido,
      this.itemPedido});

  Pedido.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'];
    codigoExterno = json['codigoExterno'];
    cliente = json['cliente'];
    valorBruto = json['valorBruto'];
    valorLiquido = json['valorLiquido'];
    if (json['itemPedido'] != null) {
      itemPedido = new List<ItemPedido>();
      json['itemPedido'].forEach((v) {
        itemPedido.add(new ItemPedido.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigo'] = this.codigo;
    data['codigoExterno'] = this.codigoExterno;
    data['cliente'] = this.cliente;
    data['valorBruto'] = this.valorBruto;
    data['valorLiquido'] = this.valorLiquido;
    if (this.itemPedido != null) {
      data['itemPedido'] = this.itemPedido.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
