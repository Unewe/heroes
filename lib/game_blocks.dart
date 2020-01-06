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

  Rect firstRect, secondRect, thirdRect, fourthRect;

  Rect selectedRect;
  var selectedX, selectedY, toChangeX, toChangeY, selected;

  BottomBlock(this.gameScreen, this.x, this.y, this.w, this.h) {
    cards = Cards.getDefaultCollection();
    firstY = secondY = thirdY = fourthY = y;
    firstX = h * 0.2;
    secondX = h + h * 0.2 + firstX;
    thirdX = h + h * 0.2 + secondX;
    fourthX = h + h * 0.2 + thirdX;

    firstRect = Rect.fromLTWH(firstX, firstY, h, h);
    secondRect = Rect.fromLTWH(secondX, secondY, h, h);
    thirdRect = Rect.fromLTWH(thirdX, thirdY, h, h);
    fourthRect = Rect.fromLTWH(fourthX, fourthY, h, h);
  }

  @override
  void render(Canvas c) {
    Paint paint = Paint()..color = Colors.deepPurpleAccent;
    c.drawRect(firstRect, paint);
    c.drawRect(secondRect, paint);
    c.drawRect(thirdRect, paint);
    c.drawRect(fourthRect, paint);
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
      firstRect = Rect.fromLTWH(dx, dy, h, h);
    } else if(selected == 2) {
      secondRect = Rect.fromLTWH(dx, dy, h, h);
    } else if(selected == 3) {
      thirdRect = Rect.fromLTWH(dx, dy, h, h);
    } else if(selected == 4) {
      fourthRect = Rect.fromLTWH(dx, dy, h, h);
    }
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
    selectedRect = null;
    selected = 0;
  }

}