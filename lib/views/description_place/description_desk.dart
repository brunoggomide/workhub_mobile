import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../controllers/user/user_controller.dart';
import '../reservation/reservation.dart';

class DescriptionDesk extends StatefulWidget {
  const DescriptionDesk({
    Key? key,
    required this.item,
    required this.id,
  }) : super(key: key);

  final dynamic item;
  final String id;

  @override
  State<DescriptionDesk> createState() => _DescriptionDeskState();
}

class _DescriptionDeskState extends State<DescriptionDesk> {
  String nomeEmpresa = '';
  String contatoEmpresa = '';
  String emailEmpresa = '';

  @override
  void initState() {
    super.initState();
    carregarDadosEmpresa();
  }

  void carregarDadosEmpresa() async {
    var dadosEmpresa =
        await UserController().getEmpresaData(widget.item['UID_coworking']);
    if (dadosEmpresa != null) {
      setState(() {
        nomeEmpresa = dadosEmpresa['nome'] ?? 'Nome não disponível';
        contatoEmpresa = dadosEmpresa['contato'] ?? 'Contato não disponível';
        emailEmpresa = dadosEmpresa['email'] ?? 'Email não disponível';
      });
    }
  }

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
    String mesasText = int.parse(widget.item['num_mesas']) == 1
        ? 'mesa disponível'
        : 'mesas disponíveis';
    var photoList = widget.item['fotos'] as List<dynamic>;
    List<Widget> imageSliders = photoList.isNotEmpty
        ? photoList
            .map((item) => Image.network(item,
                fit: BoxFit.cover, width: MediaQuery.of(context).size.width))
            .toList()
        : [
            Image.asset('assets/images/noImage.jpg',
                fit: BoxFit.cover, width: MediaQuery.of(context).size.width)
          ];

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
                        items: imageSliders,
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
                        '${widget.item['endereco']}, ${widget.item['num_endereco']}${widget.item['complemento'].isNotEmpty ? ', ' + widget.item['complemento'] : ''}, ${widget.item['bairro']} - ${widget.item['cidade']} / ${widget.item['uf']}',
                        14,
                      ),
                      const SizedBox(height: 10),
                      buildText('R\$ ' + widget.item['valor'] + '/ Hora', 18),
                      const SizedBox(height: 10),
                      buildText(
                          'Seg - Sex ' +
                              widget.item['hr_abertura'] +
                              ' - ' +
                              widget.item['hr_fechamento'],
                          16),
                      const SizedBox(height: 10),
                      buildText(
                          widget.item['num_mesas'] +
                              ' ' +
                              mesasText +
                              ' por horário (verificar disponibilidade no agendamento)',
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
                      buildText('Recursos do espaço', 20),
                      if (widget.item['cafe'] == true) ...[
                        const SizedBox(height: 10),
                        buildRowWithIcon(Icons.local_cafe, 'Café'),
                      ],
                      if (widget.item['estacionamento'] == true) ...[
                        const SizedBox(height: 10),
                        buildRowWithIcon(Icons.local_parking, 'Estacionamento'),
                      ],
                      if (widget.item['ar_condicionado'] == true) ...[
                        const SizedBox(height: 10),
                        buildRowWithIcon(Icons.ac_unit, 'Ar-condicionado'),
                      ],
                      if (widget.item['acessibilidade'] == true) ...[
                        const SizedBox(height: 10),
                        buildRowWithIcon(
                            Icons.wheelchair_pickup, 'Acessibilidade'),
                      ],
                      if (widget.item['bicicletario'] == true) ...[
                        const SizedBox(height: 10),
                        buildRowWithIcon(Icons.pedal_bike, 'Bicicletário'),
                      ],
                      if (widget.item['espeço_interativo'] == true) ...[
                        const SizedBox(height: 10),
                        buildRowWithIcon(
                            Icons.interests_sharp, 'Espaço Interativo'),
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
                      buildText('Descrição', 20),
                      const SizedBox(height: 10),
                      buildText(
                        widget.item['descricao'],
                        18,
                      ),
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
                      buildText('Informações adicionais', 20),
                      const SizedBox(height: 10),
                      buildText('Nome: $nomeEmpresa', 18),
                      const SizedBox(height: 10),
                      buildText('Contato: $contatoEmpresa', 18),
                      const SizedBox(height: 10),
                      buildText('E-mail: $emailEmpresa', 18),
                      const SizedBox(height: 10),
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
                          return Reservation(
                            item: widget.item,
                            id: widget.id,
                            type: 'desk',
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
