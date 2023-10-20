import 'package:api_app/model/via_cep_back4app_model.dart';
import 'package:api_app/pages/address_page.dart';
import 'package:api_app/repository/via_cep_back4app_repository.dart';
import 'package:flutter/material.dart';

class AddressListPage extends StatefulWidget {
  const AddressListPage({Key? key}) : super(key: key);

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  ViaCEPBack4AppRepository viaCEPBack4AppRepository =
      ViaCEPBack4AppRepository();
  ViaCEPBack4AppModel _addressList = ViaCEPBack4AppModel([]);
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getAddressList();
  }

  void _getAddressList() async {
    setState(() {
      isLoading = true;
    });
    ViaCEPBack4AppModel addressList =
        await viaCEPBack4AppRepository.getAddressesFromViaCEP();
    setState(() {
      _addressList = addressList;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de endereços'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddressPage()));
          setState(() {
          });
          _getAddressList();
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
              itemCount: _addressList.results.length,
              itemBuilder: (context, index) {
                _addressList.results.sort((a, b) => a.cep.compareTo(b.cep));
                final address = _addressList.results[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 16.0),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16.0),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    viaCEPBack4AppRepository.deleteAddress(address.objectId);
                    setState(() {
                      _addressList.results.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Endereço removido'),
                      ),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(address.cep),
                        subtitle: Text(
                            '${address.logradouro}\n${address.localidade} - ${address.uf}'),
                      ),
                    ),
                  ),
                );
              },
            ),
      ),
    );
  }
}
