import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:workhub_mobile/views/description_place/description_desk.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:workhub_mobile/views/description_place/description_room.dart';
import '../../controllers/desk/desk_dao.dart';
import '../../controllers/room/room_dao.dart';
import '../../services/city_services.dart';
import 'components/item_place.dart';

class Places extends StatefulWidget {
  const Places({Key? key}) : super(key: key);

  @override
  State<Places> createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  var txtCity = TextEditingController();
  bool _showTables = true;
  bool _showRooms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: txtCity,
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
              ),
              suggestionsCallback: (pattern) async {
                return await getCitys(pattern);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title:
                      Text(suggestion['nome'] + ' - ' + suggestion['estado']),
                );
              },
              onSuggestionSelected: (suggestion) {
                setState(() {
                  this.txtCity.text = suggestion['nome'];
                });
              },
              hideOnLoading: true,
              hideOnEmpty: true,
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
          if (txtCity.text.isEmpty)
            const Center(
              child: Text('Preencha a cidade.'),
            )
          else if (_showTables)
            ShowTable()
          else if (_showRooms)
            ShowRoom()
          else
            const Center(
              child: Text('Sem dados.'),
            ),
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

  Widget ShowTable() {
    bool noDataMessageShown = false;

    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: DeskDao().listar().snapshots(),
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
              sortedData.sort((a, b) => a['title'].compareTo(b['title']));
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                physics: const BouncingScrollPhysics(),
                itemCount: sortedData.length,
                itemBuilder: (context, index) {
                  dynamic item = sortedData[index].data();
                  String id = sortedData[index].id;
                  String address = item['address'];
                  String num_address = item['num_address'];
                  String bairro = item['bairro'];
                  String complemento = item['complemento'];
                  String city = item['city'];
                  String uf = item['uf'];
                  String title = item['title'];
                  String image = item['image'][0];
                  if (city.contains(txtCity.text)) {
                    return ItemPlaces(
                      address:
                          '$address, $num_address${complemento.isNotEmpty ? ', $complemento' : ''}, $bairro - $city - $uf',
                      title: title,
                      path: image.isEmpty ? 'assets/images/noImage.jpg' : image,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (c) {
                              return DescriptionDesk(
                                item: item,
                                id: id,
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    if (!noDataMessageShown) {
                      noDataMessageShown = true;
                      return const Center(
                        child: Text('Ainda não temos mesas nessa cidade.'),
                      );
                    } else {
                      return Container();
                    }
                  }
                },
              );
            } else {
              return const Center(
                child: Text('Sem dados.'),
              );
            }
          }
        },
      ),
    );
  }

  Widget ShowRoom() {
    bool noDataMessageShown = false;

    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: RoomDao().listar().snapshots(),
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
              sortedData.sort((a, b) => a['titulo'].compareTo(b['titulo']));
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                physics: const BouncingScrollPhysics(),
                itemCount: sortedData.length,
                itemBuilder: (context, index) {
                  dynamic item = sortedData[index].data();
                  String id = sortedData[index].id;
                  String address = item['logradouro'];
                  String num_address = item['numero'];
                  String bairro = item['bairro'];
                  String complemento = item['complemento'];
                  String city = item['cidade'];
                  String uf = item['uf'];
                  String title = item['titulo'];
                  String image = item['imagens'][0];
                  if (city.contains(txtCity.text)) {
                    return ItemPlaces(
                      address:
                          '$address, $num_address${complemento.isNotEmpty ? ', $complemento' : ''}, $bairro - $city - $uf',
                      title: title,
                      path: image.isEmpty ? 'assets/images/noImage.jpg' : image,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (c) {
                              return DescriptionRoom(
                                item: item,
                                id: id,
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    if (!noDataMessageShown) {
                      noDataMessageShown = true;
                      return const Center(
                        child: Text(
                            'Ainda não temos salas de reunião nessa cidade.'),
                      );
                    } else {
                      return Container();
                    }
                  }
                },
              );
            } else {
              return const Center(
                child: Text('Sem dados.'),
              );
            }
          }
        },
      ),
    );
  }
}
