import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioModel {
  final String nome;
  final String documento;
  final String contato;
  final String email;
  final String criado_em;
  final String atualizado_em;

  UsuarioModel(
    this.nome,
    this.documento,
    this.contato,
    this.email,
    this.criado_em,
    this.atualizado_em,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'nome': nome,
      'documento': documento,
      'contato': contato,
      'email': email,
      'atualizado_em': FieldValue.serverTimestamp(),
    };
    if (criado_em != null && criado_em.isNotEmpty) {
      json['criado_em'] = FieldValue.serverTimestamp();
    }
    return json;
  }

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      json['nome'],
      json['documento'],
      json['contato'],
      json['email'],
      json['criado_em'],
      json['atualizado_em'],
    );
  }
}
