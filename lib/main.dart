import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroes/screens.dart';

void main() async {
  Util flameUtil = Util();
  await flameUtil.setOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  await flameUtil.fullScreen();
  var game = MyGame();
  runApp(game.widget);

  VerticalDragGestureRecognizer verticalDrag =  VerticalDragGestureRecognizer();
  verticalDrag.onUpdate = game.onVerticalUpdate;
  verticalDrag.onStart = game.onStart;
  verticalDrag.onEnd = game.onEnd;
  flameUtil.addGestureRecognizer(verticalDrag);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  tapper.onTapUp = game.onTapUp;
  flameUtil.addGestureRecognizer(tapper);
}

class MyGame extends Game {

  Size size;
  Screen screen;

  MyGame() {
    init();
  }

  init() async {
    resize(await Flame.util.initialDimensions());
    screen = HomeScreen(this);
  }

  @override
  void render(Canvas canvas) {
    screen.render(canvas);
  }

  @override
  void update(double t) {
    screen.update(t);
  }

  @override
  void resize(Size size) {
    this.size = size;
    if(screen != null) screen.resize(size);
  }

  toScreen(Screen screen) {
    this.screen = screen;
  }

  onVerticalUpdate(DragUpdateDetails details) {
    screen.onVerticalUpdate(details);
  }

  onTapDown(TapDownDetails details) {
    screen.onTapDown(details);
  }

  onTapUp(TapUpDetails details) {
    screen.onTapUp(details);
  }

  onStart(DragStartDetails details) {
    screen.onStart(details);
  }

  onEnd(DragEndDetails details) {
    screen.onEnd(details);
  }
}