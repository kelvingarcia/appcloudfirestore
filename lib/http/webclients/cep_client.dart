import 'dart:convert';

import 'package:cloudfirestoreapp/http/webclient.dart';
import 'package:cloudfirestoreapp/model/resposta_cep.dart';

class CepClient {
  static Future<RespostaCep> getRespostaCep(String cep) async {
    var response = await client.get(baseUrl + cep + '/json');
    return RespostaCep.fromJson(jsonDecode(response.body));
  }
}