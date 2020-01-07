import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
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
  Sprite leftPlayerSprite;
  Rect rightPlayer;

  GameScreen(MyGame game) : super(game) {
    init();
    bgPaint.color = Colors.teal;

    bottomBlock = BottomBlock(this, 0, h * 0.7, w, h * 0.3);
    leftPlayer = Rect.fromLTWH(h * 0.1, h * 0.1, h * 0.45, h * 0.6);
    rightPlayer = Rect.fromLTWH(w - (h * 0.1 + h * 0.4), h * 0.1, h * 0.4, h * 0.6);
  }
  var image;
  init() async {

    image = await Flame.images.load("knight.png");
    leftPlayerSprite = Sprite.fromImage(image);
  }

  @override
  void render(Canvas c) {
    c.drawRect(bgRect, bgPaint);
    leftPlayerSprite.renderRect(c, leftPlayer);
//    c.drawRect(leftPlayer, Paint()..color = Colors.orange);
//    c.drawRect(rightPlayer, Paint()..color = Colors.black12);
    bottomBlock.render(c);
    
    c.drawRRect(RRect.fromRectAndRadius(rightPlayer, Radius.circular(15.0)), Paint()..color = Colors.orange);
//    c.drawImageRect(image, rightPlayer, rightPlayer, Paint()..color = Colors.orange);
  }

  var leftMove = true;
  @override
  void update(double t) {
    if(leftPlayer.height > h * 0.63) {
      leftMove = false;
    } else if (leftPlayer.height < h * 0.6){
      leftMove = true;
    }
    leftPlayer = leftMove ? Rect.fromLTWH(leftPlayer.left, leftPlayer.top - 0.15, leftPlayer.width, leftPlayer.height + 0.15)
        : Rect.fromLTWH(leftPlayer.left, leftPlayer.top + 0.08, leftPlayer.width, leftPlayer.height - 0.08);

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