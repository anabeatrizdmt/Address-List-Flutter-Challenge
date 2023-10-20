import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:api_app/model/via_cep_model.dart';

class ViaCEPRepository {
  Future<ViaCEPModel> getAddress(String cep) async {
    var url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return ViaCEPModel.fromJson(json);
    }
    return ViaCEPModel();
  }
}
