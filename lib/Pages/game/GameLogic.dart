//import 'dart:collection';

import 'package:flutter/material.dart';

class GameLogic {
  final String hiddenCard = 'assets/images/box.png';
  List<String>? cardsImg;
  String level = '';
  String idTem = '';
  String Tem = '';

  late List<String> card_list = [];

  var axiCount = 0;
  var cardCount = 0;
  List<Map<int, String>> matchCheck = [];

  void initGame(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    String difficult = arguments['level'] as String;
    idTem = arguments['id'] as String;
    Tem = arguments['level'] as String;
    if (difficult == 'medium') {
      cardCount = 24;
      axiCount = 6;
      card_list = [
        'assets/images/red3.png',
        'assets/images/Blue.png',
        'assets/images/red3.png',
        'assets/images/green.png',
        'assets/images/orange.png',
        'assets/images/red3.png',
        'assets/images/red3.png',
        'assets/images/brown.png',
        'assets/images/green.png',
        'assets/images/orange.png',
        'assets/images/p.png',
        'assets/images/p.png',
        'assets/images/green.png',
        'assets/images/green.png',
        'assets/images/brown.png',
        'assets/images/yellow.png',
        'assets/images/yellow.png',
        'assets/images/pink.png',
        'assets/images/pink.png',
        'assets/images/Blue.png',
        'assets/images/pink.png',
        'assets/images/pink.png',
        'assets/images/orange.png',
        'assets/images/orange.png',
      ];
    } else if (difficult == 'hard') {
      cardCount = 30;
      axiCount = 6;
      card_list = [
        'assets/images/red3.png',
        'assets/images/Blue.png',
        'assets/images/red3.png',
        'assets/images/green.png',
        'assets/images/orange.png',
        'assets/images/brown.png',
        'assets/images/green.png',
        'assets/images/orange.png',
        'assets/images/red3.png',
        'assets/images/red3.png',
        'assets/images/p.png',
        'assets/images/p.png',
        'assets/images/green.png',
        'assets/images/green.png',
        'assets/images/brown.png',
        'assets/images/yellow.png',
        'assets/images/yellow.png',
        'assets/images/pink.png',
        'assets/images/pink.png',
        'assets/images/Blue.png',
        'assets/images/pink.png',
        'assets/images/pink.png',
        'assets/images/orange.png',
        'assets/images/orange.png',
        'assets/images/orange.png',
        'assets/images/orange.png',
        'assets/images/Blue.png',
        'assets/images/Blue.png',
        'assets/images/yellow.png',
        'assets/images/yellow.png',
      ];
    } else if (difficult == 'Colores') {
      cardCount = 16;
      axiCount = 4;
      card_list = [
        'assets/images/red3.png',
        'assets/images/Blue.png',
        'assets/images/red3.png',
        'assets/images/green.png',
        'assets/images/orange.png',
        'assets/images/brown.png',
        'assets/images/green.png',
        'assets/images/orange.png',
        'assets/images/p.png',
        'assets/images/p.png',
        'assets/images/brown.png',
        'assets/images/yellow.png',
        'assets/images/yellow.png',
        'assets/images/pink.png',
        'assets/images/pink.png',
        'assets/images/Blue.png',
      ];
    } else if (difficult == 'Números') {
      cardCount = 16;
      axiCount = 4;
      card_list = [
        'assets/images/num/1.png',
        'assets/images/num/1.png',
        'assets/images/num/2.png',
        'assets/images/num/2.png',
        'assets/images/num/3.png',
        'assets/images/num/3.png',
        'assets/images/num/4.png',
        'assets/images/num/4.png',
        'assets/images/num/5.png',
        'assets/images/num/5.png',
        'assets/images/num/6.png',
        'assets/images/num/6.png',
        'assets/images/num/7.png',
        'assets/images/num/7.png',
        'assets/images/num/8.png',
        'assets/images/num/8.png',
      ];
    } else if (difficult == 'Abecedario') {
      cardCount = 16;
      axiCount = 4;
      card_list = [
        'assets/images/letras/A.png',
        'assets/images/letras/A.png',
        'assets/images/letras/E.png',
        'assets/images/letras/E.png',
        'assets/images/letras/I.png',
        'assets/images/letras/I.png',
        'assets/images/letras/O.png',
        'assets/images/letras/O.png',
        'assets/images/letras/U.png',
        'assets/images/letras/U.png',
        'assets/images/letras/A.png',
        'assets/images/letras/A.png',
        'assets/images/letras/E.png',
        'assets/images/letras/E.png',
        'assets/images/letras/O.png',
        'assets/images/letras/O.png',
      ];
    } else {
      cardCount = 16;
      axiCount = 4;
      card_list = [
        'assets/images/box.png',
        'assets/images/box.png',
        'assets/images/box.png',
        'assets/images/box.png',
        'assets/images/box.png',
        'assets/images/box.png',
        'assets/images/box.png',
        'assets/images/box.png',
        'assets/images/box.png',
        'assets/images/box.png',
        'assets/images/box.png',
        'assets/images/box.png',
        'assets/images/box.png',
        'assets/images/box.png',
        'assets/images/box.png',
        'assets/images/box.png',
      ];
    }
    card_list.shuffle();
    cardsImg = List<String>.generate(cardCount, (index) {
      return hiddenCard;
    });
  }
}
