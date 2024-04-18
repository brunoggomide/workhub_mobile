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

  Future<List<dynamic>> checkAvailabilityRoom(String selectedDate,
      DateTime startTime, DateTime endTime, String id) async {
    DateTime parsedSelectedDate = DateFormat('dd/MM/yyyy').parse(selectedDate);

    QuerySnapshot<Map<String, dynamic>> reservations =
        await FirebaseFirestore.instance
            .collection('reservas')
            .where('uid_espaco', isEqualTo: id)
            .where('status', isEqualTo: 'Confirmado')
            .where('data', isEqualTo: selectedDate) // Verifica a data
            .get();

    // Verifica se existe algum agendamento que intersecta com o horário selecionado
    for (QueryDocumentSnapshot<Map<String, dynamic>> reservation
        in reservations.docs) {
      String reservationStartTimeString = reservation['inicio'];
      String reservationEndTimeString = reservation['fim'];

      // Convertendo as strings de hora para objetos DateTime
      List<String> startParts = reservationStartTimeString.split(":");
      List<String> endParts = reservationEndTimeString.split(":");

      int reservationStartHour = int.parse(startParts[0]);
      int reservationStartMinute = int.parse(startParts[1]);

      int reservationEndHour = int.parse(endParts[0]);
      int reservationEndMinute = int.parse(endParts[1]);

      DateTime reservationStart = DateTime(
          parsedSelectedDate.year,
          parsedSelectedDate.month,
          parsedSelectedDate.day,
          reservationStartHour,
          reservationStartMinute);
      DateTime reservationEnd = DateTime(
          parsedSelectedDate.year,
          parsedSelectedDate.month,
          parsedSelectedDate.day,
          reservationEndHour,
          reservationEndMinute);

      print(reservationStart);
      print(reservationEnd);

      if ((startTime.isBefore(reservationEnd) &&
              startTime.isAfter(reservationStart)) ||
          (endTime.isBefore(reservationEnd) &&
              endTime.isAfter(reservationStart))) {
        return [
          false,
          reservationStartTimeString,
          reservationEndTimeString
        ]; // Existe conflito de horários
      }
    }

    return [true, '', '']; // Não há conflito de horários
  }

  Future<bool> checkAvailabilityDesk(String selectedDate, DateTime startTime,
      DateTime endTime, String deskId) async {
    DateTime parsedSelectedDate = DateFormat('dd/MM/yyyy').parse(selectedDate);

    // Consulta para obter o número de mesas disponíveis para o desk
    DocumentSnapshot<Map<String, dynamic>> deskSnapshot =
        await FirebaseFirestore.instance.collection('mesas').doc(deskId).get();

    int numMesasDisponiveis = int.parse(deskSnapshot['num_mesas']);

    // Consulta para verificar as reservas já existentes
    QuerySnapshot<Map<String, dynamic>> reservations =
        await FirebaseFirestore.instance
            .collection('reservas')
            .where('uid_espaco', isEqualTo: deskId)
            .where('status', isEqualTo: 'Confirmado')
            .where('data', isEqualTo: selectedDate) // Verifica a data
            .get();

    int mesasOcupadas = 0;

    // Conta o número de mesas já agendadas para o horário selecionado
    for (QueryDocumentSnapshot<Map<String, dynamic>> reservation
        in reservations.docs) {
      String reservationStartTimeString = reservation['inicio'];
      String reservationEndTimeString = reservation['fim'];

      // Convertendo as strings de hora para objetos DateTime
      List<String> startParts = reservationStartTimeString.split(":");
      List<String> endParts = reservationEndTimeString.split(":");

      int reservationStartHour = int.parse(startParts[0]);
      int reservationStartMinute = int.parse(startParts[1]);

      int reservationEndHour = int.parse(endParts[0]);
      int reservationEndMinute = int.parse(endParts[1]);

      DateTime reservationStart = DateTime(
          parsedSelectedDate.year,
          parsedSelectedDate.month,
          parsedSelectedDate.day,
          reservationStartHour,
          reservationStartMinute);
      DateTime reservationEnd = DateTime(
          parsedSelectedDate.year,
          parsedSelectedDate.month,
          parsedSelectedDate.day,
          reservationEndHour,
          reservationEndMinute);

      // Verifica se há sobreposição de horários
      if ((startTime.isBefore(reservationEnd) &&
              startTime.isAfter(reservationStart)) ||
          (endTime.isBefore(reservationEnd) &&
              endTime.isAfter(reservationStart))) {
        mesasOcupadas++;
      }
      print(mesasOcupadas);
      print(numMesasDisponiveis);
    }

    // Verifica se o número de mesas disponíveis é suficiente para o agendamento
    if (mesasOcupadas >= numMesasDisponiveis) {
      return false; // Não há mesas disponíveis
    } else {
      return true; // Há mesas disponíveis
    }
  }

  listarAgendamentos(String id, String selectedDate) {
    return FirebaseFirestore.instance
        .collection('reservas')
        .where('uid_espaco', isEqualTo: id)
        .where('status', isEqualTo: 'Confirmado')
        .where('data', isEqualTo: selectedDate);
  }

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
