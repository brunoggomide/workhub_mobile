import 'package:flutter/material.dart';
import 'package:workhub_mobile/controllers/booking/booking_dao.dart';

class CancelBooking extends StatelessWidget {
  const CancelBooking({
    super.key,
    this.id = '',
    this.title = '',
    this.address = '',
    this.date = '',
    this.time = '',
  });

  final String id;
  final String title;
  final String address;
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    print(id);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Reserva ' + title,
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
      body: Column(
        children: [
          Expanded(child: Container()),
          Container(
              margin: EdgeInsets.all(20),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(children: [
                      Icon(
                        Icons.calendar_month,
                        color: Colors.grey,
                        size: 22,
                      ),
                      Text(
                        ' Data',
                        style: TextStyle(color: Colors.grey, fontSize: 22),
                      ),
                    ]),
                    Text(
                      date,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    const Divider(),
                    const Row(children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.grey,
                        size: 22,
                      ),
                      Text(
                        ' Horário',
                        style: TextStyle(color: Colors.grey, fontSize: 22),
                      ),
                    ]),
                    Text(
                      time,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    const Divider(),
                    const Row(children: [
                      Icon(
                        Icons.map,
                        color: Colors.grey,
                        size: 22,
                      ),
                      Text(
                        ' Endereço',
                        style: TextStyle(color: Colors.grey, fontSize: 22),
                      ),
                    ]),
                    Text(
                      address,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ],
                ),
              )),
          Expanded(child: Container()),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: NextButton(context),
          )
        ],
      ),
    );
  }

  Widget NextButton(ctx) {
    BookingDao bookingDao = BookingDao();

    return Container(
      padding: EdgeInsets.only(bottom: 20),
      height: 75, // Ajuste a altura conforme necessário
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side:
              const BorderSide(width: 2, color: Color.fromRGBO(177, 47, 47, 1)),
        ),
        onPressed: () {
          bookingDao.cancelar(ctx, id);
        },
        child: const Text(
          'CANCELAR',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(177, 47, 47, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
