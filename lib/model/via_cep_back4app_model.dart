class ViaCEPBack4AppModel {
  List<ViaCEPBack4App> results = [];

  ViaCEPBack4AppModel(this.results);

  ViaCEPBack4AppModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <ViaCEPBack4App>[];
      json['results'].forEach((v) {
        results.add(ViaCEPBack4App.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results.map((v) => v.toJson()).toList();
    return data;
  }
}

class ViaCEPBack4App {
  String objectId = '';
  String cep = '';
  String logradouro = '';
  String? complemento;
  String? bairro;
  String localidade = '';
  String uf = '';
  String? ibge;
  String? gia;
  String? ddd;
  String? siafi;
  String? createdAt;
  String? updatedAt;

  ViaCEPBack4App(
      {required this.objectId,
        required this.cep,
        required this.logradouro,
        this.complemento,
        this.bairro,
        required this.localidade,
        required this.uf,
        this.ibge,
        this.gia,
        this.ddd,
        this.siafi,
        this.createdAt,
        this.updatedAt});

  ViaCEPBack4App.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    cep = json['cep'];
    logradouro = json['logradouro'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
    ibge = json['ibge'];
    gia = json['gia'];
    ddd = json['ddd'];
    siafi = json['siafi'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    data['ibge'] = ibge;
    data['gia'] = gia;
    data['ddd'] = ddd;
    data['siafi'] = siafi;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  Map<String, dynamic> toCreateJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    data['ibge'] = ibge;
    data['gia'] = gia;
    data['ddd'] = ddd;
    data['siafi'] = siafi;
    return data;
  }
}
