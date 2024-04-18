import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../controllers/booking/booking_dao.dart';

class Calendar extends StatelessWidget {
  const Calendar({
    Key? key,
    required this.id,
    required this.date,
  }) : super(key: key);

  final String id, date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Reserva do dia ' + date,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: BookingDao().listarAgendamentos(id, date).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Center(
              child: Text('Não foi possível conectar.'),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final dados = snapshot.requireData;
            if (dados.size > 0) {
              List<QueryDocumentSnapshot> sortedData = dados.docs;
              sortedData.sort((a, b) => a['inicio'].compareTo(b['inicio']));
              return ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                physics: const BouncingScrollPhysics(),
                itemCount: sortedData.length,
                itemBuilder: (context, index) {
                  dynamic item = sortedData[index].data();
                  String inicio = item['inicio'];
                  String fim = item['fim'];
                  return ListTile(
                    title: Text(
                      'Agendamento - $inicio até $fim',
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('Sem reservas nesse dia.'),
              );
            }
          }
        },
      ),
    );
  }
}
