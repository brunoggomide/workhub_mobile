import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../controllers/booking/booking_dao.dart';
import '../../controllers/user/user_controller.dart';
import '../../models/booking_model.dart';

class Reservation extends StatefulWidget {
  const Reservation({
    Key? key,
    required this.item,
    required this.id,
  }) : super(key: key);

  final dynamic item;
  final String id;

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  final pageController = PageController(initialPage: 0);
  var txtDate = TextEditingController(text: 'Selecione o dia');
  var txtDate2 = TextEditingController();
  var txtStart = TextEditingController(text: 'Selecione o início');
  var txtEnd = TextEditingController(text: 'Selecione o fim');
  var reservationValueText;
  String selectedPaymentMethod = '';

  // Função para verificar se a data é sábado ou domingo
  bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

// Função para verificar se a hora está dentro do intervalo de abertura e fechamento
  bool isWithinOpeningHours(
      String openingTime, String closingTime, DateTime time) {
    DateTime opening =
        DateFormat('HH:mm').parse(openingTime).subtract(Duration(minutes: 1));
    DateTime closing =
        DateFormat('HH:mm').parse(closingTime).add(Duration(minutes: 1));
    return time.isAfter(opening) && time.isBefore(closing);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Reserva de Mesa ' + widget.item['title'],
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
      body: PageView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: pageController,
        children: [Step1(), Step2()],
      ),
    );
  }

  Widget Step1() {
    return Column(
      children: [
        OnRoomTimeLine(Icons.access_time, 'Selecionar Data (1/2)'),
        Expanded(child: Container()),
        Container(
            margin: EdgeInsets.all(20),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Column(
                children: [DateText(), StartText(), EndText()],
              ),
            )),
        Expanded(child: Container()),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          child: NextButton(1),
        )
      ],
    );
  }

  Widget Step2() {
    return Column(
      children: [
        OnRoomTimeLine(Icons.access_time, 'Confirmar reserva (2/2)'),
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
                    txtDate.text,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const Divider(),
                  const Row(children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.grey,
                      size: 22,
                    ),
                    Text(
                      ' Início',
                      style: TextStyle(color: Colors.grey, fontSize: 22),
                    ),
                  ]),
                  Text(
                    txtStart.text,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const Divider(),
                  const Row(children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.grey,
                      size: 22,
                    ),
                    Text(
                      ' Final',
                      style: TextStyle(color: Colors.grey, fontSize: 22),
                    ),
                  ]),
                  Text(
                    txtEnd.text,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const Divider(),
                  const Row(children: [
                    Icon(
                      Icons.monetization_on_outlined,
                      color: Colors.grey,
                      size: 22,
                    ),
                    Text(
                      ' Valor',
                      style: TextStyle(color: Colors.grey, fontSize: 22),
                    ),
                  ]),
                  Text(
                    reservationValueText.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const Divider(),
                  const Text(
                    'Forma de Pagamento',
                    style: TextStyle(color: Colors.grey, fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      _buildPaymentMethodOption('Cartão', Icons.credit_card),
                      SizedBox(width: 10),
                      _buildPaymentMethodOption('Pix', Icons.qr_code),
                      SizedBox(width: 10),
                      _buildPaymentMethodOption('Dinheiro', Icons.money),
                    ],
                  ),
                ],
              ),
            )),
        Expanded(child: Container()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  child: PreviousButton(),
                  margin: EdgeInsets.only(left: 10),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  child: ConfirmButton(),
                  margin: EdgeInsets.only(right: 10),
                ))
          ],
        )
      ],
    );
  }

  // Função para calcular a duração da reserva e ajustar o valor
  void calculateAndSetReservationValue() {
    DateTime startTime = DateFormat('HH:mm').parse(txtStart.text);
    DateTime endTime = DateFormat('HH:mm').parse(txtEnd.text);
    int durationHours = endTime.difference(startTime).inMinutes ~/ 60;
    int extraMinutes = endTime.difference(startTime).inMinutes % 60;

    if (extraMinutes > 0) {
      durationHours +=
          1; // Arredonda para a próxima hora se houver minutos extras
    }

    // Considera pelo menos 1 hora se a duração for menor
    durationHours = durationHours < 1 ? 1 : durationHours;

    // Converte o valor por hora de String para double e ajusta de acordo com a duração
    double valuePerHour =
        double.parse(widget.item['value_hour'].replaceAll(',', '.'));
    double totalValue = valuePerHour * durationHours;

    // Atualiza o campo de valor no Step2
    setState(() {
      // Atualize o valor exibido no seu widget de valor, por exemplo:
      reservationValueText =
          'R\$ ${totalValue.toStringAsFixed(2).replaceAll('.', ',')}';
    });

    print(reservationValueText);
  }

  Widget _buildPaymentMethodOption(String method, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = method;
        });
      },
      child: Container(
        width: 80, // Definindo a largura fixa do contêiner
        height: 80, // Definindo a altura fixa do contêiner
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selectedPaymentMethod == method
              ? const Color.fromRGBO(177, 47, 47, 1).withOpacity(0.3)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: const Color.fromRGBO(177, 47, 47, 1),
                size: 20), // Ajuste o tamanho do ícone conforme necessário
            const SizedBox(height: 5),
            Text(
              method,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color.fromRGBO(177, 47, 47, 1),
                fontWeight: FontWeight.bold,
                fontSize: 16, // Ajuste o tamanho da fonte conforme necessário
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget DateText() {
    return Padding(
        padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 2),
        child: TextFormField(
          readOnly: true,
          controller: txtDate,
          cursorColor: Colors.red,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.event),
            labelText: 'Data',
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          ),
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 30)),
              helpText: 'Selecione o dia',
              builder: (context, child) {
                return dateTimePickerTheme(child);
              },
            ).then((date) => {
                  if (date != null)
                    {
                      setState(() {
                        txtDate.text = DateFormat('dd/MM/yyyy').format(date);
                        txtDate2.text =
                            DateFormat('EEEE, dd/MM/yyyy').format(date);
                      })
                    }
                });
          },
        ));
  }

  Widget StartText() {
    return Padding(
        padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 2),
        child: TextFormField(
          readOnly: true,
          controller: txtStart,
          cursorColor: Colors.red,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.access_time),
            labelText: 'Início',
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          ),
          onTap: () {
            showTimePicker(
              context: context,
              helpText: 'Selecione o início',
              initialTime: TimeOfDay.now(),
              builder: (context, child) {
                return dateTimePickerTheme(child);
              },
            ).then((time) {
              if (time != null) {
                setState(() {
                  txtStart.text = DateFormat('HH:mm').format(DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      time.hour,
                      time.minute));
                });
              }
            });
          },
        ));
  }

  Widget EndText() {
    return Padding(
        padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 2),
        child: TextFormField(
          readOnly: true,
          controller: txtEnd,
          cursorColor: Colors.red,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.access_time),
            labelText: 'Final',
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          ),
          onTap: () {
            showTimePicker(
              context: context,
              initialTime: TimeOfDay(
                  hour: DateFormat('HH:mm')
                      .parse(txtStart.text)
                      .add(Duration(hours: 1))
                      .hour,
                  minute: DateFormat('HH:mm').parse(txtStart.text).minute),
              builder: (context, child) {
                return dateTimePickerTheme(child);
              },
            ).then((time) {
              if (time != null) {
                setState(() {
                  txtEnd.text = DateFormat('HH:mm').format(DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      time.hour,
                      time.minute));
                });
              }
            });
          },
        ));
  }

  dateTimePickerTheme(child) {
    return Theme(
      data: ThemeData.light().copyWith(
        primaryColor: Colors.red,
        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        colorScheme: ColorScheme.light(primary: Colors.red)
            .copyWith(secondary: Colors.red),
      ),
      child: child,
    );
  }

  Widget OnRoomTimeLine(icon, text) {
    return Row(children: <Widget>[
      Expanded(
          child: Divider(
        color: Colors.red,
        thickness: 5,
      )),
      Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Icon(
                  icon,
                  color: Colors.red,
                ),
              ),
              Text(text,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          )),
      Expanded(
          child: Divider(
        color: Colors.red,
        thickness: 5,
      )),
    ]);
  }

  Widget NextButton(step) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      height: 75, // Ajuste a altura conforme necessário
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color.fromRGBO(177, 47, 47, 1),
          ),
        ),
        onPressed: () {
          if (step == 1) {
            if (txtDate.text == 'Selecione o dia' ||
                txtStart.text == 'Selecione o início' ||
                txtEnd.text == 'Selecione o fim') {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red[300],
                  content: const Text('Preencha todos os campos.'),
                ),
              );
            } else {
              DateTime selectedDate =
                  DateFormat('EEEE, dd/MM/yyyy').parse(txtDate2.text);
              DateTime startTime = DateFormat('HH:mm').parse(txtStart.text);
              DateTime endTime = DateFormat('HH:mm').parse(txtEnd.text);

              if (endTime.isBefore(startTime)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red[300],
                    content: const Text('O fim deve ser depois do início'),
                  ),
                );
              } else if (isWeekend(selectedDate)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red[300],
                    content: const Text('Fora do dia de funcionamento'),
                  ),
                );
              } else if (!isWithinOpeningHours(widget.item['abertura'],
                      widget.item['fechamento'], startTime) ||
                  !isWithinOpeningHours(widget.item['abertura'],
                      widget.item['fechamento'], endTime)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red[300],
                    content: Text(
                        'Agendamento permitido das ${widget.item['abertura']} hrs até às ${widget.item['fechamento']} hrs'),
                  ),
                );
              } else {
                calculateAndSetReservationValue();
                pageController.nextPage(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeIn,
                );
              }
            }
          }
        },
        child: const Text(
          'Próximo',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget PreviousButton() {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      height: 75, // Ajuste a altura conforme necessário
      margin: EdgeInsets.only(right: 5),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black38),
        ),
        onPressed: () {
          pageController.previousPage(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeIn,
          );
        },
        child: const Text(
          'Voltar',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget ConfirmButton() {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      height: 75, // Ajuste a altura conforme necessário
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color.fromRGBO(177, 47, 47, 1),
          ),
        ),
        onPressed: () {
          if (selectedPaymentMethod.isNotEmpty) {
            var book = BookingModel(
              UserController().idUsuario(),
              widget.item['uid'],
              widget.id,
              reservationValueText.toString(),
              selectedPaymentMethod,
              'Confirmado',
              txtDate.text,
              txtStart.text,
              txtEnd.text,
              '',
              '',
            );
            BookingDao().adicionar(context, book);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red[300],
                content: const Text('Preencher pagamento'),
              ),
            );
          }
        },
        child: const Text(
          'Confirmar',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}