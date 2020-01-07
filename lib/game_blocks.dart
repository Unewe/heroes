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

  Rect selectedRect;
  var selectedX, selectedY, toChangeX, toChangeY, selected;

  BottomBlock(this.gameScreen, this.x, this.y, this.w, this.h) {
    cards = Cards.getDefaultCollection();
    firstY = secondY = thirdY = fourthY = y;

    width = h * 0.8;

    firstX = w/2 - width - width - h * 0.025 - h * 0.05;
    secondX = w/2 - width - h * 0.025;
    thirdX = w/2 + h * 0.025;
    fourthX = w/2 + width + h * 0.05 + h * 0.025;

    firstRect = Rect.fromLTWH(firstX, firstY, width, h);
    secondRect = Rect.fromLTWH(secondX, secondY, width, h);
    thirdRect = Rect.fromLTWH(thirdX, thirdY, width, h);
    fourthRect = Rect.fromLTWH(fourthX, fourthY, width, h);
  }

  @override
  void render(Canvas c) {
    Paint paint = Paint()..color = Colors.deepPurpleAccent;
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