import 'package:api_app/back4app/back4app_custom_dio.dart';
import 'package:api_app/model/via_cep_back4app_model.dart';

class ViaCEPBack4AppRepository {

  final _customDio = Back4AppCustomDio();

  ViaCEPBack4AppRepository();

  Future<ViaCEPBack4AppModel> getAddressesFromViaCEP() async {
    var response = await _customDio.dio.get('/CEP');
    return ViaCEPBack4AppModel.fromJson(response.data);
  }

  Future<void> addAddress(ViaCEPBack4App cep) async {
    await _customDio.dio.post('/CEP', data: cep.toCreateJson());
  }

  Future<void> deleteAddress(String objectId) async {
    await _customDio.dio.delete('/CEP/$objectId');
  }
}