import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:workhub_mobile/controllers/booking/booking_dao.dart';
import 'package:workhub_mobile/views/booking/components/cancel_booking.dart';
import 'package:workhub_mobile/views/booking/components/item_booking.dart';

import '../../controllers/user/user_controller.dart';

class Booking extends StatelessWidget {
  const Booking({Key? key});

  String _convertMonth(String monthNumber) {
    Map<String, String> months = {
      '01': 'Janeiro',
      '02': 'Fevereiro',
      '03': 'Março',
      '04': 'Abril',
      '05': 'Maio',
      '06': 'Junho',
      '07': 'Julho',
      '08': 'Agosto',
      '09': 'Setembro',
      '10': 'Outubro',
      '11': 'Novembro',
      '12': 'Dezembro',
    };
    return months[monthNumber] ?? 'Mês Inválido';
  }

  String _formatDay(String day) {
    if (day.startsWith('0')) {
      return day.substring(1);
    }
    return day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Agendamentos',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream:
                  BookingDao().listarConfirmados(UserController().idUsuario()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none) {
                  return const Center(
                    child: Text('Não foi possível conectar.'),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final dados = snapshot.requireData;
                  if (dados.size > 0) {
                    List<QueryDocumentSnapshot> sortedData = dados.docs;
                    sortedData.sort((a, b) => a['data'].compareTo(b['data']));
                    return ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      physics: const BouncingScrollPhysics(),
                      itemCount: sortedData.length,
                      itemBuilder: (context, index) {
                        dynamic item = sortedData[index].data();
                        String id = sortedData[index].id;
                        List<String> dateParts = item['data'].split('/');
                        String formattedMonth = _convertMonth(dateParts[1]);
                        String formattedDay = _formatDay(dateParts[0]);
                        return ItemBooking(
                          address: item['endereco'],
                          title: item['local'],
                          month: formattedMonth,
                          date: formattedDay,
                          time: item['inicio'] + ' - ' + item['fim'],
                          status: item['status'],
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (c) {
                                  return CancelBooking(
                                    id: id,
                                    address: item['endereco'],
                                    title: item['local'],
                                    date: item['data'],
                                    time: item['inicio'] + ' - ' + item['fim'],
                                    valor: item['valor'],
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('Você não tem nenhum agendamento.'),
                    );
                  }
                }
              },
            ),

            // Divisor
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey.withAlpha(90),
                      thickness: 2,
                    ),
                  ),
                ],
              ),
            ),
            // Seção de agendamentos não confirmados
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'Reservas finalizadas',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: BookingDao()
                  .listarFinalizados(
                    UserController().idUsuario(),
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none) {
                  return const Center(
                    child: Text('Não foi possível conectar.'),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final dados = snapshot.requireData;
                  if (dados.size > 0) {
                    List<QueryDocumentSnapshot> sortedData = dados.docs;
                    sortedData.sort((b, a) => a['data'].compareTo(b['data']));
                    return ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      physics: const BouncingScrollPhysics(),
                      itemCount: sortedData.length,
                      itemBuilder: (context, index) {
                        dynamic item = sortedData[index].data();
                        List<String> dateParts = item['data'].split('/');
                        String formattedMonth = _convertMonth(dateParts[1]);
                        String formattedDay = _formatDay(dateParts[0]);
                        return ItemBooking(
                          address: item['endereco'],
                          title: item['local'],
                          month: formattedMonth,
                          date: formattedDay,
                          time: item['inicio'] + ' - ' + item['fim'],
                          status: item['status'],
                          onPressed: () {},
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('Sem reservas finalizadas.'),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
