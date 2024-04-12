import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  cancelar(context, String id) {
    FirebaseFirestore.instance
        .collection('reservas')
        .doc(id)
        .update({'status': 'Cancelado'})
        .then((value) => sucesso(context, 'Reserva cancelada com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  finalizar(context, String id) {
    FirebaseFirestore.instance
        .collection('reservas')
        .doc(id)
        .update({'status': 'Finalizado'})
        .then((value) => sucesso(context, 'Reserva cancelada com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  // listarConfirmados(String id) {
  //   return FirebaseFirestore.instance
  //       .collection('reservas')
  //       .where('uid_cliente', isEqualTo: id)
  //       .where('status', isEqualTo: 'Confirmado');
  // }

  listarFinalizados(String id) {
    return FirebaseFirestore.instance
        .collection('reservas')
        .where('uid_cliente', isEqualTo: id)
        .where('status', whereIn: ['Cancelado', 'Finalizado']);
  }

  Stream<QuerySnapshot> listarConfirmados(String userId) {
    var now = DateTime.now();
    var ref = FirebaseFirestore.instance.collection('reservas');
    return ref
        .where('uid_cliente', isEqualTo: userId)
        .where('status', isEqualTo: 'Confirmado')
        .snapshots()
        .asyncMap((snapshot) async {
      for (var doc in snapshot.docs) {
        DateTime bookingDate = DateFormat('dd/MM/yyyy').parse(doc['data']);
        if (bookingDate.isBefore(now)) {
          await doc.reference.update({'status': 'Finalizado'});
        }
      }
      return snapshot;
    });
  }
}
