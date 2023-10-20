import 'package:api_app/model/via_cep_back4app_model.dart';
import 'package:api_app/model/via_cep_model.dart';
import 'package:api_app/repository/via_cep_back4app_repository.dart';
import 'package:api_app/repository/via_cep_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final TextEditingController _cepController = TextEditingController(text: '');

  bool isLoading = false;

  ViaCEPModel viaCEPModel = ViaCEPModel();
  ViaCEPRepository viaCEPRepository = ViaCEPRepository();
  ViaCEPBack4AppRepository viaCEPBack4AppRepository =
      ViaCEPBack4AppRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Endereço'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Consulta CEP',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: TextField(
                controller: _cepController,
                decoration: const InputDecoration(
                  labelText: 'CEP',
                  hintText: 'Digite o CEP',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
                onChanged: (value) async {
                  if (value.trim().length == 8) {
                    setState(() {
                      isLoading = true;
                    });
                    await viaCEPRepository.getAddress(value).then((value) {
                      setState(() {
                        viaCEPModel = value;
                        isLoading = false;
                        if (viaCEPModel.logradouro == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('CEP não encontrado')));
                        }
                      });
                    });
                  }
                },
              ),
            ),
            isLoading
                ? const Column(
                    children: [
                      SizedBox(height: 36),
                      Center(child: CircularProgressIndicator()),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 36),
                      Text(viaCEPModel.logradouro ?? '',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                      const SizedBox(height: 8),
                      Text(viaCEPModel.bairro ?? '',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                      const SizedBox(height: 8),
                      Text(
                          '${viaCEPModel.localidade ?? ''} - ${viaCEPModel.uf ?? ''}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                      const SizedBox(height: 8),
                      Center(
                          child: ElevatedButton(
                              onPressed: () async {
                                ViaCEPBack4AppModel addresses =
                                    await viaCEPBack4AppRepository
                                        .getAddressesFromViaCEP();

                                bool addressExists = addresses.results.any((address) => address.cep == viaCEPModel.cep);

                                if (addressExists) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Endereço já cadastrado!')),
                                  );
                                } else {
                                  ViaCEPBack4App cepToSave = ViaCEPBack4App(
                                    objectId: '',
                                    cep: viaCEPModel.cep!,
                                    logradouro: viaCEPModel.logradouro!,
                                    complemento: viaCEPModel.complemento!,
                                    bairro: viaCEPModel.bairro,
                                    localidade: viaCEPModel.localidade!,
                                    uf: viaCEPModel.uf!,
                                    ibge: viaCEPModel.ibge!,
                                    gia: viaCEPModel.gia!,
                                    ddd: viaCEPModel.ddd!,
                                    siafi: viaCEPModel.siafi!,
                                  );
                                  await viaCEPBack4AppRepository
                                      .addAddress(cepToSave);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Endereço salvo com sucesso!')),
                                  );
                                }
                              },
                              child: const Text('Salvar'))),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
