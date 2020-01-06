import 'package:flame/components/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heroes/game_blocks.dart';
import 'package:heroes/main.dart';

abstract class Screen extends Component {
  var w,h;
  Rect bgRect;
  Paint bgPaint;
  MyGame game;
  Screen(this.game) {
    w = game.size.width;
    h = game.size.height;
    bgRect = Rect.fromLTWH(0, 0, w, h);
    bgPaint = Paint()..color = Colors.green;
  }
  onVerticalUpdate(DragUpdateDetails details) {}
  onTapDown(TapDownDetails details) {}
  onTapUp(TapUpDetails details) {}
  onStart(DragStartDetails details) {}
  onEnd(DragEndDetails details) {}
}

/*
 * Main paige screen
 */
class HomeScreen extends Screen{
  Rect start;

  HomeScreen(MyGame game) : super(game) {
    bgPaint.color = Colors.greenAccent;
    start = Rect.fromLTWH(
        w - h * 0.05 - w * 0.2,
        h - h * 0.05 - h * 0.2,
        w * 0.2, h * 0.2);
  }

  @override
  void render(Canvas c) {
    c.drawRect(bgRect, bgPaint);
    c.drawRect(start, Paint()..color = Colors.deepOrange);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }

  @override
  onTapDown(TapDownDetails details) {
    if(start.contains(details.globalPosition)) {
      game.toScreen(GameScreen(game));
    }
  }
}

/*
 * Screen for Game
 * with 2 characters
 */
class GameScreen extends Screen{

  BottomBlock bottomBlock;
  Rect leftPlayer;
  Rect rightPlayer;

  GameScreen(MyGame game) : super(game) {
    bgPaint.color = Colors.teal;

    bottomBlock = BottomBlock(this, 0, h * 0.7, w, h * 0.3);
    leftPlayer = Rect.fromLTWH(h * 0.1, h * 0.1, h * 0.4, h * 0.6);
    rightPlayer = Rect.fromLTWH(w - (h * 0.1 + h * 0.4), h * 0.1, h * 0.4, h * 0.6);
  }


  @override
  void render(Canvas c) {
    c.drawRect(bgRect, bgPaint);
    c.drawRect(leftPlayer, Paint()..color = Colors.orange);
    c.drawRect(rightPlayer, Paint()..color = Colors.orange);

    bottomBlock.render(c);
  }

  @override
  void update(double t) {
    bottomBlock.update(t);
  }

  @override
  onTapUp(TapUpDetails details) {
    bottomBlock.onTapUp(details);
  }

  @override
  onTapDown(TapDownDetails details) {
    bottomBlock.onTapDown(details);
  }

  @override
  onVerticalUpdate(DragUpdateDetails details) {
    bottomBlock.onVerticalUpdate(details);
  }

  onStart(DragStartDetails details) {
    bottomBlock.onStart(details);
  }
  onEnd(DragEndDetails details) {
    bottomBlock.onEnd(details);
  }

  @override
  bool loaded() {
    return true;
  }
}

/*
 * Screen for shopping
 */
class ShopScreen extends Screen{
  ShopScreen(MyGame game) : super(game);

  @override
  void render(Canvas c) {
    // TODO: implement render
  }

  @override
  void update(double t) {
    // TODO: implement update
  }

}