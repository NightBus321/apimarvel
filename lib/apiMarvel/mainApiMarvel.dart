// ignore_for_file: file_names, camel_case_types, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:apimarvel/apiMarvel/pages/characthersList.dart';

class mainApiMarvel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _mainApiMarvel();
  }
}

class _mainApiMarvel extends State<mainApiMarvel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Personajes de Marvel"),
        ),
        body: listaPersonajes());
        
  }
}
