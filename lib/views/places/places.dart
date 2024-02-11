import 'package:flutter/material.dart';

import 'components/item_place.dart';

class Places extends StatefulWidget {
  const Places({Key? key}) : super(key: key);

  @override
  State<Places> createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  String _searchText = '';
  bool _showTables = true;
  bool _showRooms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                hintText: 'Buscar cidade...',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: 30,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(
                          width: 2,
                          color: _showTables ? Colors.green : Colors.grey,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _showTables = true;
                          _showRooms = false;
                        });
                      },
                      child: Text(
                        'Mesas',
                        style: TextStyle(
                          fontSize: 18,
                          color: _showTables ? Colors.green : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: 30,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(
                          width: 2,
                          color: _showRooms ? Colors.green : Colors.grey,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _showTables = false;
                          _showRooms = true;
                        });
                      },
                      child: Text(
                        'Salas de Reunião',
                        style: TextStyle(
                          fontSize: 16,
                          color: _showRooms ? Colors.green : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              physics: const BouncingScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                // Use as variáveis _showTables e _showRooms para decidir quais itens mostrar
                if (_showTables) {
                  return ItemPlaces(
                    address:
                        "Rua Rui Barbosa, 850, Centro - Ribeirão Preto / SP",
                    title: "Center Poly Br",
                    path: 'assets/images/place1.jpg',
                    onPressed: () {
                      print('toc');
                    },
                  );
                } else if (_showRooms) {
                  return ItemPlaces(
                    address:
                        "Av Pres. Vargas, 1200, Jd São Luiz - Ribeirão Preto / SP",
                    title: "Sala Preciosa",
                    path: 'assets/images/place2.jpg',
                    onPressed: () {
                      print('toc');
                    },
                  );
                }
                return Container();
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(177, 47, 47, 1),
        onPressed: () {
          // Implemente a lógica desejada para o botão de filtro
        },
        child: const Icon(
          Icons.filter_alt,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
