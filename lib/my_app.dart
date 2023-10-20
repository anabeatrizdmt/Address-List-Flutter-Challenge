import 'package:api_app/pages/address_list_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const AddressListPage(),
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ));
  }

}
