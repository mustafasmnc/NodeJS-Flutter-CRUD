import 'package:flutter/material.dart';
import 'package:flutter_crud_api/product_add_edit.dart';
import 'package:flutter_crud_api/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      routes: {
        '/': (context) => ProductList(),
        '/add-product': (context) => ProductAddEdit(),
        '/edit-product': (context) => ProductAddEdit(),
      },
    );
  }
}
