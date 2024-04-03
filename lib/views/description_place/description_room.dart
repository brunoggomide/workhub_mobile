import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../reservation/reservation_desk.dart';

class DescriptionRoom extends StatefulWidget {
  const DescriptionRoom({
    Key? key,
    required this.item,
    required this.id,
  }) : super(key: key);

  final dynamic item;
  final String id;

  @override
  State<DescriptionRoom> createState() => _DescriptionRoomState();
}

class _DescriptionRoomState extends State<DescriptionRoom> {
  Widget buildText(String text, double fontSize) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildRowWithIcon(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider(
                        items: [
                          Image.asset(
                            'assets/images/place1.jpg',
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.height,
                          ),
                          Image.asset(
                            'assets/images/place2.jpg',
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.height,
                          ),
                        ],
                        options: CarouselOptions(
                          height: 250,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          viewportFraction: 1.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      buildText(widget.item['titulo'], 20),
                      const SizedBox(height: 5),
                      buildText(
                        '${widget.item['address']}, ${widget.item['num_address']}${widget.item['complemento'].isNotEmpty ? ', ' + widget.item['complemento'] : ''}, ${widget.item['bairro']} - ${widget.item['city']} / ${widget.item['uf']}',
                        14,
                      ),
                      const SizedBox(height: 10),
                      buildText('R\$ ' + widget.item['valor'] + '/ Hora', 18),
                      const SizedBox(height: 10),
                      buildText(
                          'Seg - Sex ' +
                              widget.item['abertura'] +
                              ' - ' +
                              widget.item['fechamento'],
                          16),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
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
                      buildText('Recursos do espaço', 18),
                      const SizedBox(height: 10),
                      buildRowWithIcon(
                          Icons.people,
                          'Capacidade para ' +
                              widget.item['capacidade'] +
                              ' pessoas'),
                      if (widget.item['tv'] == true) ...[
                        const SizedBox(height: 10),
                        buildRowWithIcon(Icons.tv, 'TV'),
                      ],
                      if (widget.item['projetor'] == true) ...[
                        const SizedBox(height: 10),
                        buildRowWithIcon(Icons.video_call, 'Projetor'),
                      ],
                      if (widget.item['quadroBranco'] == true) ...[
                        const SizedBox(height: 10),
                        buildRowWithIcon(Icons.airplay, 'Quadro Branco'),
                      ],
                      // if (widget.item['videoConferencia'] == true) ...[
                      //   const SizedBox(height: 10),
                      //   buildRowWithIcon(
                      //       Icons.interests_sharp, 'Espaço Interativo'),
                      // ],
                      if (widget.item['arCondicionado'] == true) ...[
                        const SizedBox(height: 10),
                        buildRowWithIcon(Icons.severe_cold, 'Ar-condicionado'),
                      ],
                      if (widget.item['acessibilidade'] == true) ...[
                        const SizedBox(height: 10),
                        buildRowWithIcon(
                            Icons.wheelchair_pickup, 'Acessibilidade'),
                      ],
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
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
                      buildText('Descrição', 18),
                      const SizedBox(height: 10),
                      buildText(
                        widget.item['descricao'],
                        18,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                height: 80,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(177, 47, 47, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c) {
                          return ReservationDesk(
                            item: widget.item,
                            id: widget.id,
                          );
                        },
                      ),
                    );
                  },
                  child: const Text(
                    'RESERVAR',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 10,
            top: 10,
            child: SafeArea(
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
