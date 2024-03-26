import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String uid_cliente;
  final String uid_empresa;
  final String uid_espaco;
  final String valor;
  final String pagamento;
  final String status;
  final String data;
  final String inicio;
  final String fim;
  final String criado_em;
  final String atualizado_em;

  BookingModel(
    this.uid_cliente,
    this.uid_empresa,
    this.uid_espaco,
    this.valor,
    this.pagamento,
    this.status,
    this.data,
    this.inicio,
    this.fim,
    this.criado_em,
    this.atualizado_em,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'uid_cliente': uid_cliente,
      'uid_empresa': uid_empresa,
      'uid_espaco': uid_espaco,
      'valor': valor,
      'pagamento': pagamento,
      'status': status,
      'data': data,
      'inicio': inicio,
      'fim': fim,
      'criado_em': FieldValue.serverTimestamp(),
      'atualizado_em': FieldValue.serverTimestamp(),
    };
    return json;
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      json['uid_cliente'],
      json['uid_empresa'],
      json['uid_espaco'],
      json['valor'],
      json['pagamento'],
      json['status'],
      json['data'],
      json['inicio'],
      json['fim'],
      json['criado_em'],
      json['atualizado_em'],
    );
  }
}
