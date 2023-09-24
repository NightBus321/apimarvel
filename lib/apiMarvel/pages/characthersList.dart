// ignore_for_file: camel_case_types, use_key_in_widget_constructors

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apimarvel/apiMarvel/pages/detailChracthers.dart';

import '../controlers/characthers.dart';

class listaPersonajes extends StatefulWidget {
  @override
  estadoListaPersonajes createState() => estadoListaPersonajes();
}

class estadoListaPersonajes extends State<listaPersonajes> {
  List<dynamic> characters = [];

  Future<void> getCharacters() async { 
    int num = Random().nextInt(1541);
    String url =  'https://gateway.marvel.com:443/v1/public/characters?ts=10&apikey=af468b3503603801817dfff31982be6b&hash=70f8e7fd7ba77a7d1ad086d52bc20bc6&offset=$num';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        characters = jsonData['data']['results'];
      });
    } else {
      throw Exception('Error al cargar los personajes');
    }
  }

  @override
  void initState() {
    super.initState();
    getCharacters();
  }

  void _showCharacterDetail(int index) {
    final character = characters[index];
    final name = character['name'];
    final thumbnail = character['thumbnail']['path'] +
        '.' +
        character['thumbnail']['extension'];
    final description = character['description'];
    const defaultDescription = 'No hay descripcion para este personaje actualmente';
    final validDescription = (description == null || description.isEmpty)
        ? defaultDescription
        : description;
    final comics = character['comics']['available'];
    final series = character['series']['available'];
    final stories = character['stories']['available'];
    final events = character['events']['available'];
    final List<dynamic> seriesList = character['series']['items'];
    final seriesCount = min(seriesList.length, 3); // Validación para seriesList
    final List<String> seriesNames = seriesList
        .sublist(0, seriesCount)
        .map((item) => item['name'].toString())
        .toList();
    final Character selectedCharacter = Character(
        name: name,
        image: thumbnail,
        thumbnail: thumbnail,
        description: validDescription,
        comicsCount: comics,
        seriesCount: series,
        storiesCount: stories,
        eventsCount: events,
        firstThreeSeriesNames: seriesNames);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => detallesPersonajes(
                character: selectedCharacter,
              )),
    );
  }

  Future refresh()async{
    getCharacters();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: RefreshIndicator.adaptive( onRefresh: refresh,
        child: Center( 
          child: characters.isEmpty
              ? CircularProgressIndicator()
              : ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: characters.length,
                  itemBuilder: (context, index) {
                    final character = characters[index];
                    final thumbnail = character['thumbnail']['path'] +
                        '.' +
                        character['thumbnail']['extension'];
                    final name = character['name'];
                    return GestureDetector(
                      onTap: () {
                        _showCharacterDetail(index);
                      },
                      child: ListTile(   
                        leading: Icon(Icons.account_circle), 
                        visualDensity: VisualDensity(vertical: 4),
                        trailing: Container(  
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30.0))),
                          child: Image( 
                            image: NetworkImage(thumbnail), 
                            width: 60, 
                            height: 60, 
                          ),
                        ),
                        title: Text(name, style: TextStyle(fontSize: 15.5)),
                        onTap: () {
                          _showCharacterDetail(index);
                        },
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
