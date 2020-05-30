class ItemPedido {
  int codigo;
  int codigoPedido;
  int codigoProduto;
  int quantidade;

  ItemPedido(
      {this.codigo, this.codigoPedido, this.codigoProduto, this.quantidade});

  ItemPedido.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'];
    codigoPedido = json['codigoPedido'];
    codigoProduto = json['codigoProduto'];
    quantidade = json['quantidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigo'] = this.codigo;
    data['codigoPedido'] = this.codigoPedido;
    data['codigoProduto'] = this.codigoProduto;
    data['quantidade'] = this.quantidade;
    return data;
  }
}
