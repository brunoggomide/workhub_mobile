import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/booking_model.dart';
import '../../views/utils/env.dart';

class BookingDao {
  adicionar(context, BookingModel bm) {
    FirebaseFirestore.instance
        .collection('reservas')
        .add(bm.toJson())
        .then((value) => sucesso(context, 'Reserva criada com sucesso.'))
        .catchError((e) => erro(context, 'Não foi possível criar a reserva'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  atualizar(context, String id) {
    FirebaseFirestore.instance
        .collection('reservas')
        .doc(id)
        .update({'status': 'Cancelado'})
        .then((value) => sucesso(context, 'Reserva cancelada com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  listarConfirmados(String id) {
    return FirebaseFirestore.instance
        .collection('reservas')
        .where('uid_cliente', isEqualTo: id)
        .where('status', isEqualTo: 'Confirmado');
  }

  listarFinalizados(String id) {
    return FirebaseFirestore.instance
        .collection('reservas')
        .where('uid_cliente', isEqualTo: id)
        .where('status', whereIn: ['Cancelado', 'Finalizado']);
  }
}
