import 'package:flutter/material.dart';
import 'package:workhub_mobile/views/booking/components/item_booking.dart';

class Booking extends StatelessWidget {
  const Booking({Key? key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> confirmedBookings = [
      {
        'address': "Rua São José, 123, Centro - Ribeirão Preto / SP",
        'title': "CenterPoly Brasil",
        'locale': 'Mesa 10',
        'month': 'Fevereiro',
        'date': '15',
        'time': '09:00 - 12:00',
        'status': 'Confirmado',
      },
      {
        'address': "Rua São José, 123, Centro - Ribeirão Preto / SP",
        'title': "Sala Preciosa",
        'locale': 'Sala Preciosa',
        'month': 'Fevereiro',
        'date': '20',
        'time': '09:00 - 10:00',
        'status': 'Confirmado',
      },
      // Adicione mais agendamentos confirmados, se necessário
    ];

    List<Map<String, String>> nonConfirmedBookings = [
      {
        'address': "Rua São José, 123, Centro - Ribeirão Preto / SP",
        'title': "Sala Preciosa",
        'locale': 'Sala Preciosa',
        'month': 'Fevereiro',
        'date': '19',
        'time': '09:00 - 10:00',
        'status': 'Cancelado',
      },
      {
        'address': "Rua São José, 123, Centro - Ribeirão Preto / SP",
        'title': "Sala Preciosa",
        'locale': 'Sala Preciosa',
        'month': 'Janeiro',
        'date': '31',
        'time': '09:00 - 10:00',
        'status': 'Finalizado',
      },
      {
        'address': "Rua São José, 123, Centro - Ribeirão Preto / SP",
        'title': "CenterPoly Brasil",
        'locale': 'Mesa 10',
        'month': 'Janeiro',
        'date': '28',
        'time': '09:00 - 18:00',
        'status': 'Finalizado',
      },
      // Adicione mais agendamentos não confirmados, se necessário
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
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
            // Seção de agendamentos confirmados
            ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              physics: const BouncingScrollPhysics(),
              itemCount: confirmedBookings.length,
              itemBuilder: (context, index) {
                return ItemBooking(
                  address: confirmedBookings[index]['address']!,
                  title: confirmedBookings[index]['title']!,
                  locale: confirmedBookings[index]['locale']!,
                  month: confirmedBookings[index]['month']!,
                  date: confirmedBookings[index]['date']!,
                  time: confirmedBookings[index]['time']!,
                  status: confirmedBookings[index]['status']!,
                  onPressed: () {
                    print('toc');
                  },
                );
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
            ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              physics: const BouncingScrollPhysics(),
              itemCount: nonConfirmedBookings.length,
              itemBuilder: (context, index) {
                return ItemBooking(
                  address: nonConfirmedBookings[index]['address']!,
                  title: nonConfirmedBookings[index]['title']!,
                  locale: nonConfirmedBookings[index]['locale']!,
                  month: nonConfirmedBookings[index]['month']!,
                  date: nonConfirmedBookings[index]['date']!,
                  time: nonConfirmedBookings[index]['time']!,
                  status: nonConfirmedBookings[index]['status']!,
                  onPressed: () {
                    print('toc');
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
