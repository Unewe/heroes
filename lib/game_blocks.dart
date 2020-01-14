import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';
import 'package:heroes/collections.dart';
import 'package:heroes/screens.dart';

class BottomBlock extends Component {

  GameScreen gameScreen;

  var x, y, w, h;
  List<Cards> cards;

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

  BottomBlock(this.gameScreen, this.x, this.y, this.w, this.h) {
    cards = Cards.getDefaultCollection();
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
  }

  @override
  void render(Canvas c) {
    Paint paint = Paint()..color = Colors.deepPurpleAccent;
    Paint paintBg = Paint()..color = Colors.black26;

    c.drawRRect(RRect.fromRectAndRadius(firstRectBg, Radius.circular(10)), paintBg);
    c.drawRRect(RRect.fromRectAndRadius(secondRectBg, Radius.circular(10)), paintBg);
    c.drawRRect(RRect.fromRectAndRadius(thirdRectBg, Radius.circular(10)), paintBg);
    c.drawRRect(RRect.fromRectAndRadius(fourthRectBg, Radius.circular(10)), paintBg);

    c.drawRRect(RRect.fromRectAndRadius(firstRect, Radius.circular(10)), paint);
    c.drawRRect(RRect.fromRectAndRadius(secondRect, Radius.circular(10)), paint);
    c.drawRRect(RRect.fromRectAndRadius(thirdRect, Radius.circular(10)), paint);
    c.drawRRect(RRect.fromRectAndRadius(fourthRect, Radius.circular(10)), paint);
  }

  @override
  void update(double t) {
  }

  onVerticalUpdate(DragUpdateDetails details) {
    var dx;
    var dy;
    if(selected != 0) {
      dx = selectedRect.topLeft.dx + (details.globalPosition.dx - toChangeX);
      dy = selectedRect.topLeft.dy + (details.globalPosition.dy - toChangeY);
    }
    if(selected == 1) {
      firstRect = Rect.fromLTWH(dx, dy, width, h);
    } else if(selected == 2) {
      secondRect = Rect.fromLTWH(dx, dy, width, h);
    } else if(selected == 3) {
      thirdRect = Rect.fromLTWH(dx, dy, width, h);
    } else if(selected == 4) {
      fourthRect = Rect.fromLTWH(dx, dy, width, h);
    }
    dragYPosition = details.globalPosition.dy;
  }

  onTapDown(TapDownDetails details) {
    if(firstRect.contains(details.globalPosition)) {
      selectedRect = firstRect;
      selected = 1;
    } else if(secondRect.contains(details.globalPosition)) {
      selectedRect = secondRect;
      selected = 2;
    } else if(thirdRect.contains(details.globalPosition)) {
      selectedRect = thirdRect;
      selected = 3;
    } else if(fourthRect.contains(details.globalPosition)) {
      selectedRect = fourthRect;
      selected = 4;
    }

    toChangeX = details.globalPosition.dx;
    toChangeY = details.globalPosition.dy;
  }

  onTapUp(TapUpDetails details) {
    selectedRect = null;
    selected = 0;
  }

  onStart(DragStartDetails details) {
    if(firstRect.contains(details.globalPosition)) {
      selectedRect = firstRect;
      selected = 1;
    } else if(secondRect.contains(details.globalPosition)) {
      selectedRect = secondRect;
      selected = 2;
    } else if(thirdRect.contains(details.globalPosition)) {
      selectedRect = thirdRect;
      selected = 3;
    } else if(fourthRect.contains(details.globalPosition)) {
      selectedRect = fourthRect;
      selected = 4;
    }

    toChangeX = details.globalPosition.dx;
    toChangeY = details.globalPosition.dy;
  }
  onEnd(DragEndDetails details) {
    if(selected != 0) {
      if(dragYPosition < y) {
        /*
         *Выполняем ход!
         */
        if(selected == 1) {
          firstRect = firstRectBg;
        } else if(selected == 2) {
          secondRect = secondRectBg;
        } else if(selected == 3) {
          thirdRect = thirdRectBg;
        } else if(selected == 4) {
          fourthRect = fourthRectBg;
        }
      } else {
        if(selected == 1) {
          firstRect = firstRectBg;
        } else if(selected == 2) {
          secondRect = secondRectBg;
        } else if(selected == 3) {
          thirdRect = thirdRectBg;
        } else if(selected == 4) {
          fourthRect = fourthRectBg;
        }
      }
    }
    selectedRect = null;
    selected = 0;
  }
}