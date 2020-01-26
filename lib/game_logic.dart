import 'dart:math';

import 'package:heroes/collections.dart';
import 'package:heroes/screens.dart';

class GameLogic {
  GameScreen gameScreen;
  Random random = Random();

  Player leftPlayer;
  Player rightPlayer;

  Player current;
  Player opponent;

  GameLogic(this.leftPlayer, this.rightPlayer, this.gameScreen) {

    leftPlayer.setGameLogic(this);
    rightPlayer.setGameLogic(this);

    int r = random.nextInt(1);
    if (r == 0) {
      current = leftPlayer;
      opponent = rightPlayer;
    } else {
      current = rightPlayer;
      opponent = leftPlayer;
    }
  }

  dropCard(Cards card) {

    // Универсальное определение урона
    int dmg = 0;
    if(random.nextInt(100) < card.chance * 100){
      dmg = random.nextInt(card.dmgHigh - card.dmgLow + 1) + card.dmgLow;
    }

    switch (card.feature) {

      case Features.meleeDefault:
        opponent.hit(dmg);
        break;
      case Features.rangedDefault:
        opponent.hit(dmg);
        break;
      case Features.shieldDefault:
        current.shieldUp(dmg);
        break;
      case Features.prepareDefault:
        if(current.initiative < 10) current.initiative++;
        break;
      case Features.curseDefault:
        opponent.addDegradation(card);
        break;
      case Features.improvementDefault:
        current.addImprovement(card);
        break;
    }
  }

  endTurn() {
    
  }
  
  lastWord(Player player) {
    
  }

  endGame(Player player) {
    print("Игрок ${player.name} проиграл!");
  }

  draw() {
    print("Ничья");
  }

  getCurrentCards() {
    return current.cards;
  }
}

class Player {
  GameLogic _gameLogic;
  final String name;
  int _health;
  int _shield;
  PlayerClass playerClass;
  List<Cards> _improvements = List();
  List<Cards> _degradations = List();
  int firstTurnInitiative;
  int initiative;

  List<Cards> cards;

  Player(this.name, this.playerClass) {
    switch (playerClass) {
      case PlayerClass.DEFAULT :
        this._health = 50;
        this.firstTurnInitiative = 1;
        this.initiative = 2;
        this._shield = 0;
        this.cards = Cards.getDefaultCollection();
        break;
      case PlayerClass.KNIGHT:
        this._health = 70;
        this.firstTurnInitiative = 1;
        this.initiative = 2;
        this._shield = 0;
        this.cards = Cards.getDefaultCollection();
        break;
      case PlayerClass.ARCHER:
        this._health = 60;
        this.firstTurnInitiative = 1;
        this.initiative = 2;
        this._shield = 0;
        this.cards = Cards.getDefaultCollection();
        break;
    }
  }

  setGameLogic(GameLogic gameLogic) {
    this._gameLogic = gameLogic;
  }

  hit(int dmg) {

    if(dmg <= _shield) {
      _shield -= dmg;
      dmg = 0;
    } else {
      dmg -= _shield;
      _shield = 0;
    }

    _health = _health - dmg;
    if(_health < 8) {
      _gameLogic.lastWord(this);
    }
    else if(_health < 0) {
      _gameLogic.endGame(this);
    }
  }

  shieldUp(int count) {
    this._shield += count;
  }

  getHealth() {
    return _health;
  }

  getShield() {
    return _shield;
  }

  addImprovement(Cards improvement) {
    this._improvements.add(improvement);
  }

  getImprovements() {
    return this._improvements;
  }

  addDegradation(Cards degradation) {
    this._degradations.add(degradation);
  }

  getDegradations() {
    return this._degradations;
  }

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is Player &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              playerClass == other.playerClass;

  @override
  int get hashCode =>
      name.hashCode ^
      playerClass.hashCode;

}

enum PlayerClass {
  DEFAULT,
  KNIGHT,
  ARCHER
}

enum Turn {
  LEFT, RIGHT
}