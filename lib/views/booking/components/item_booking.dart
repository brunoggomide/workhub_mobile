import 'package:flutter/material.dart';

class ItemBooking extends StatelessWidget {
  const ItemBooking({
    Key? key,
    this.title = '',
    this.address = '',
    this.month = '',
    this.date = '',
    this.time = '',
    this.status = '',
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final String address;
  final String month;
  final String date;
  final String time;
  final String status;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    Color statusTextColor;

    // Define as cores com base no status
    if (status == 'Confirmado') {
      statusColor = Colors.green.withAlpha(100);
      statusTextColor = Colors.green;
    } else if (status == 'Cancelado') {
      statusColor = Colors.red.withAlpha(100);
      statusTextColor = Colors.red;
    } else if (status == 'Finalizado') {
      statusColor = Colors.grey.withAlpha(100);
      statusTextColor = Colors.grey;
    } else {
      // Se o status não for nenhum dos anteriores, use cores padrão
      statusColor = Colors.transparent;
      statusTextColor = Colors.black;
    }

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(5),
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container com o status formatado
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: statusTextColor,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: statusTextColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          address,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            const SizedBox(
              height: 150,
              child: VerticalDivider(
                color: Colors.black,
                thickness: 2,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(5),
                child: ListTile(
                  // Informações do lado direito
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          month,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text(
                            date,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text(
                            time,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
