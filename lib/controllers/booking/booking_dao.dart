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

  void atualizar(context, String id, BookingModel bm) {
    FirebaseFirestore.instance
        .collection('reservas')
        .doc(id)
        .update(bm.toJson())
        .then((value) => sucesso(context, 'Mesa atualizada com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  listar(id) {
    return FirebaseFirestore.instance
        .collection('reservas')
        .where('uid_cliente', isEqualTo: id);
  }
}
