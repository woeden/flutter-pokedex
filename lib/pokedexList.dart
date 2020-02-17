import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'dart:convert';
import 'package:loadmore/loadmore.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:tinycolor/tinycolor.dart';
import 'pokedexDetail.dart';

class PokedexList extends StatefulWidget {
  @override
  _PokedexListState createState() => _PokedexListState();
}

class _PokedexListState extends State<PokedexList> {
  List<dynamic> pokemons = [];
  int page = 0;
  int pageSize = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: pokemons.length > 0
              ? LoadMore(
                  onLoadMore: getPokemon,
                  textBuilder: loadMoreTxt,
                  child: ListView.builder(
                    itemCount: pokemons.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {

                      String mainType = pokemons[index]["types"].where((type)=>type["slot"].toString()=="1" ? true : false).toList()[0]["type"]["name"];

                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            gradient: LinearGradient(
                              colors: [
                                Config.getColor(mainType),
                                TinyColor(Config.getColor(mainType))
                                    .lighten(20)
                                    .color
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Material(
                            type: MaterialType.transparency,
                            child: RaisedButton(
                              elevation: 0,
                              hoverElevation: 0,
                              highlightElevation: 0,
                              focusElevation: 0,
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => pokedexDetail(pokemons[index], mainType)),
                                );
                              },
                              child: Container(
                                child: Center(
                                    child: Row(
                                  children: <Widget>[
                                    Card(),
                                    SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Hero(
                                        tag: "img"+pokemons[index]["id"].toString(),
                                        child: Image.network(
                                            "https://assets.pokemon.com/assets/cms2/img/pokedex/full/" +
                                                pokemons[index]["id"]
                                                    .toString()
                                                    .padLeft(3, "0") +
                                                ".png"),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          StringUtils.capitalize(pokemons[index]
                                                  ["name"]
                                              .toString()
                                              .replaceAll("-", " ")),
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Container(),
        ),
      ),
    );
  }

  @override
  void initState() {
    getPokemon();
  }

  String loadMoreTxt(LoadMoreStatus status) {
    return "Loading...";
  }

  Future<bool> getPokemon() async {
    http.Response response = await http.get(Config.baseUrl +
        "pokemon?limit=" +
        pageSize.toString() +
        "&offset=" +
        (pageSize * page).toString());

    List pokemonsList = json.decode(response.body)["results"];
    List<Future> pokemonDetailRequests = [];
    for (dynamic pokemon in pokemonsList) {
      pokemonDetailRequests.add(http.get(pokemon["url"]));
    }

    await Future.wait(pokemonDetailRequests).then((List pokemon) => {
          for (http.Response response in pokemon)
            {this.pokemons.add(json.decode(response.body))}
        });
    page++;
    this.setState(() {
      this.pokemons = pokemons;
    });
    return true;
  }
}
