import 'dart:math';
import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/text_box_component.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';
import 'package:heroes/collections.dart';
import 'package:heroes/screens.dart';

class BottomBlock extends Component {

  Random random = Random();

  GameScreen gameScreen;

  var x, y, w, h;
  List<Cards> cards;
  List<Cards> currentCards;

  var firstX, firstY;
  var secondX, secondY;
  var thirdX, thirdY;
  var fourthX, fourthY;
  var width;
  Rect firstRect, secondRect, thirdRect, fourthRect;
  Rect firstRectBg, secondRectBg, thirdRectBg, fourthRectBg;

  Rect selectedRect;
  var selectedX, selectedY, toChangeX, toChangeY, selected;

  var dragYPosition;

  CardTextBox firstTextBox, secondTextBox, thirdTextBox, fourthTextBox;

  BottomBlock(this.gameScreen, this.x, this.y, this.w, this.h) {
    cards = Cards.getDefaultCollection();
    currentCards = drawCards();

    firstY = secondY = thirdY = fourthY = y;

    width = h * 0.7;

    firstX = w/2 - width - width - h * 0.025 - h * 0.05;
    secondX = w/2 - width - h * 0.025;
    thirdX = w/2 + h * 0.025;
    fourthX = w/2 + width + h * 0.05 + h * 0.025;

    firstRect = firstRectBg =  Rect.fromLTWH(firstX, firstY, width, h * 0.9);
    secondRect = secondRectBg = Rect.fromLTWH(secondX, secondY, width, h * 0.9);
    thirdRect = thirdRectBg = Rect.fromLTWH(thirdX, thirdY, width, h * 0.9);
    fourthRect = fourthRectBg = Rect.fromLTWH(fourthX, fourthY, width, h * 0.9);


    firstTextBox = CardTextBox(currentCards.elementAt(0).getDescription(), firstRect);
    secondTextBox = CardTextBox(currentCards.elementAt(1).getDescription(), secondRect);
    thirdTextBox = CardTextBox(currentCards.elementAt(2).getDescription(), thirdRect);
    fourthTextBox = CardTextBox(currentCards.elementAt(3).getDescription(), fourthRect);
  }

  @override
  void render(Canvas c) {
    Paint paint = Paint()..color = Colors.deepPurpleAccent;
    Paint paintBg = Paint()..color = Colors.black26;

    c.drawRRect(RRect.fromRectAndRadius(firstRectBg, Radius.circular(10)), paintBg);

    c.drawRRect(RRect.fromRectAndRadius(secondRectBg, Radius.circular(10)), paintBg);
    c.drawRRect(RRect.fromRectAndRadius(thirdRectBg, Radius.circular(10)), paintBg);
    c.drawRRect(RRect.fromRectAndRadius(fourthRectBg, Radius.circular(10)), paintBg);

    if(firstRect != null) c.drawRRect(RRect.fromRectAndRadius(firstRect, Radius.circular(10)), paint);
    if(secondRect != null) c.drawRRect(RRect.fromRectAndRadius(secondRect, Radius.circular(10)), paint);
    if(thirdRect != null) c.drawRRect(RRect.fromRectAndRadius(thirdRect, Radius.circular(10)), paint);
    if(fourthRect != null) c.drawRRect(RRect.fromRectAndRadius(fourthRect, Radius.circular(10)), paint);

    if(firstRect != null) {
      firstTextBox
        ..anchor = Anchor.topLeft
        ..x = firstRect.topLeft.dx
        ..y = firstRect.topLeft.dy
        ..update(0)
        ..render(c);
      c.translate(-firstRect.topLeft.dx,
          -firstRect.topLeft.dy);
    }

    if(secondRect != null) {
      secondTextBox
        ..anchor = Anchor.topLeft
        ..x = secondRect.topLeft.dx
        ..y = secondRect.topLeft.dy
        ..update(0)
        ..render(c);
      c.translate(-secondRect.topLeft.dx,
          -secondRect.topLeft.dy);
    }

    if(thirdRect != null) {
      thirdTextBox
        ..anchor = Anchor.topLeft
        ..x = thirdRect.topLeft.dx
        ..y = thirdRect.topLeft.dy
        ..update(0)
        ..render(c);
      c.translate(-thirdRect.topLeft.dx,
          -thirdRect.topLeft.dy);
    }

    if(fourthRect != null) {
      fourthTextBox
        ..anchor = Anchor.topLeft
        ..x = fourthRect.topLeft.dx
        ..y = fourthRect.topLeft.dy
        ..update(0)
        ..render(c);
      c.translate(-fourthRect.topLeft.dx,
          -fourthRect.topLeft.dy);
    }
  }

  @override
  void update(double t) {

  }

  onVerticalUpdate(DragUpdateDetails details) {
    var dx;
    var dy;
    if(selected != null) {
      dx = selectedRect.topLeft.dx + (details.globalPosition.dx - toChangeX);
      dy = selectedRect.topLeft.dy + (details.globalPosition.dy - toChangeY);
    }
    if(selected == 0) {
      firstRect = Rect.fromLTWH(dx, dy, width, h);
    } else if(selected == 1) {
      secondRect = Rect.fromLTWH(dx, dy, width, h);
    } else if(selected == 2) {
      thirdRect = Rect.fromLTWH(dx, dy, width, h);
    } else if(selected == 3) {
      fourthRect = Rect.fromLTWH(dx, dy, width, h);
    }
    dragYPosition = details.globalPosition.dy;
  }

  onTapDown(TapDownDetails details) {
    if(firstRect != null && firstRect.contains(details.globalPosition)) {
      selectedRect = firstRect;
      selected = 0;
    } else if(secondRect != null && secondRect.contains(details.globalPosition)) {
      selectedRect = secondRect;
      selected = 1;
    } else if(thirdRect != null && thirdRect.contains(details.globalPosition)) {
      selectedRect = thirdRect;
      selected = 2;
    } else if(fourthRect != null && fourthRect.contains(details.globalPosition)) {
      selectedRect = fourthRect;
      selected = 3;
    }

    toChangeX = details.globalPosition.dx;
    toChangeY = details.globalPosition.dy;
  }

  onTapUp(TapUpDetails details) {
    selectedRect = null;
    selected = null;
  }

  onStart(DragStartDetails details) {
    if(firstRect != null && firstRect.contains(details.globalPosition)) {
      selectedRect = firstRect;
      selected = 0;
    } else if(secondRect != null && secondRect.contains(details.globalPosition)) {
      selectedRect = secondRect;
      selected = 1;
    } else if(thirdRect != null && thirdRect.contains(details.globalPosition)) {
      selectedRect = thirdRect;
      selected = 2;
    } else if(fourthRect != null && fourthRect.contains(details.globalPosition)) {
      selectedRect = fourthRect;
      selected = 3;
    }

    toChangeX = details.globalPosition.dx;
    toChangeY = details.globalPosition.dy;
  }
  onEnd(DragEndDetails details) {
    if(selected != null) {
      if(dragYPosition < y) {
        /*
         *Выполняем ход!
         */
        if(selected == 0) {
          gameScreen.cardAction(currentCards.elementAt(0));
          firstRect = null;
        } else if(selected == 1) {
          gameScreen.cardAction(currentCards.elementAt(1));
          secondRect = null;
        } else if(selected == 2) {
          gameScreen.cardAction(currentCards.elementAt(2));
          thirdRect = null;
        } else if(selected == 3) {
          gameScreen.cardAction(currentCards.elementAt(3));
          fourthRect = null;
        }
      } else {
        if(selected == 0) {
          firstRect = firstRectBg;
        } else if(selected == 1) {
          secondRect = secondRectBg;
        } else if(selected == 2) {
          thirdRect = thirdRectBg;
        } else if(selected == 3) {
          fourthRect = fourthRectBg;
        }
      }
    }
    selectedRect = null;
    selected = null;
  }

  List<Cards> drawCards() {
    List<Cards> temp = List.of(cards);
    List<Cards> list = List();
    for(int i = 0; i < 5; i++) {
      int value = random.nextInt(temp.length);
      list.add(temp.elementAt(value));
      temp.removeAt(value);
    }
    return list;
  }
}

class PlayerView extends PositionComponent {
  @override
  void render(Canvas c) {
    // TODO: implement render
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}

class CardItem {

  Paint paint = Paint()..color = Colors.deepPurpleAccent;
  Paint paintBg = Paint()..color = Colors.black26;
  Rect bgRect;
  Rect cardRect;
  CardItem(Rect rect) {
    bgRect = cardRect = rect;
  }

  render(Canvas canvas) {
    canvas.drawRRect(RRect.fromRectAndRadius(bgRect, Radius.circular(10)), paintBg);
    canvas.drawRRect(RRect.fromRectAndRadius(cardRect, Radius.circular(10)), paint);
  }
}

class CardTextBox extends TextBoxComponent {

  Rect rect;

  CardTextBox(String text, this.rect)
      : super(text,
      config: TextConfig(fontSize: 10.0, fontFamily: 'Awesome Font', color: Colors.white), boxConfig: TextBoxConfig(maxWidth: rect.width, margin: 15));

  @override
  void drawBackground(Canvas c) {
    c.drawRect(rect, Paint()..color = Colors.transparent);
  }
}