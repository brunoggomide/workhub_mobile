import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DescriptionPlace extends StatelessWidget {
  const DescriptionPlace({Key? key}) : super(key: key);

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
                      buildText('Center Poly Br', 20),
                      const SizedBox(height: 5),
                      buildText(
                          'Rua Rui Barbosa, 850, Centro - Ribeirão Preto / SP',
                          14),
                      const SizedBox(height: 10),
                      buildText('R\$ 15,00 / Hora', 18),
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
                      buildRowWithIcon(Icons.local_cafe, 'Café'),
                      const SizedBox(height: 10),
                      buildRowWithIcon(Icons.local_parking, 'Estacionamento'),
                      const SizedBox(height: 10),
                      buildRowWithIcon(Icons.severe_cold, 'Ar-condicionado'),
                      const SizedBox(height: 10),
                      buildRowWithIcon(
                          Icons.wheelchair_pickup, 'Acessibilidade'),
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
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
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
                  onPressed: () {},
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
