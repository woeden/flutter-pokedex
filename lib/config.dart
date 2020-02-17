import 'package:flutter/material.dart';


class Config
{
  static String baseUrl = "https://pokeapi.co/api/v2/";
  static Color getColor(String type)
  {
    switch(type){
      case "grass":
        return Color(0xFF9bcc50);
      case "water":
        return Color(0xFF4592c4);
      case "fire":
        return Color(0xFFfd7d24);
      case "bug":
        return Color(0xFF729f3f);
      case "poison":
        return Color(0xFFb97fc9);
      case "electric":
        return Color(0xFFeed535);
      case "ground":
        return Color(0xFFab9842);
      case "fairy":
        return Color(0xFFfdb9e9);
        case "fighting":
        return Color(0xFFd56723);
        case "psychic":
        return Color(0xFFf366b9);
      case "rock":
        return Color(0xFFa38c21);
      case "ghost":
        return Color(0xFF7b62a3);
      case "dragon":
        return Color(0xFFf16e57);
      case "ice":
        return Color(0xFF51c4e7);
        case "dark":
        return Color(0xFFa4a4a4);
      case "steel":
      return Color(0xFF9eb7b8);
      case "flying":
        return Color(0xFF3dc7ef);
      default:
        return Color(0xFFa4acaf);
    }
  }
}