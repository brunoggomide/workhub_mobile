import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> getCitys(String query) async {
  if (query.isNotEmpty) {
    return http
        .get(Uri.parse(
            'https://servicodados.ibge.gov.br/api/v1/localidades/estados/SP/municipios'))
        .then((response) {
      List<dynamic> data = json.decode(response.body);
      List<Map<String, dynamic>> cities = data
          .map((city) => {
                'id': city['id'],
                'nome': city['nome'],
                'estado': city['microrregiao']['mesorregiao']['UF']['sigla'],
              })
          .toList();

      // Filtra as cidades com base no que foi digitado
      return cities
          .where((city) =>
              city['nome'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  } else {
    // Retorna uma lista vazia se o comprimento da string de entrada for menor que 3
    return Future.value([]);
  }
}
