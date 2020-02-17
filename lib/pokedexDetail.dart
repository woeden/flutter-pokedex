import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:basic_utils/basic_utils.dart';
import 'dart:convert';

import 'config.dart';

class pokedexDetail extends StatelessWidget {
  final dynamic pokemon;
  final String mainType;

  pokedexDetail(this.pokemon, this.mainType);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Container(
          child: Column(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Config.getColor(this.mainType),
                        TinyColor(Config.getColor(this.mainType))
                            .lighten(20)
                            .color
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      AppBar(
                        iconTheme: IconThemeData(
                          color: Colors.white, //change your color here
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        title: Text(
                          "#" + this.pokemon["id"].toString().padLeft(3, "0"),
                          style: TextStyle(color: Colors.white, fontSize: 36),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Hero(
                          tag: "img" + this.pokemon["id"].toString(),
                          child: Image.network(
                            "https://assets.pokemon.com/assets/cms2/img/pokedex/full/" +
                                pokemon["id"].toString().padLeft(3, "0") +
                                ".png",
                          ),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        StringUtils.capitalize(
                            pokemon["name"].toString().replaceAll("-", " ")),
                        style: TextStyle(
                            color: Config.getColor(
                              this.mainType,
                            ),
                            fontSize: 40),
                      ),
                      Text("Types"),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: getTypes())
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  List<Widget> getTypes() {
    List<Widget> widgets = [];

    for (dynamic type in this.pokemon["types"]) {
      widgets.add(Chip(
        label: Text(
          StringUtils.capitalize(type["type"]["name"]),
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Config.getColor(type["type"]["name"]),
      ));
    }

    return widgets;
  }
}
