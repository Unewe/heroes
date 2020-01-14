
import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/position.dart';
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

  // Блок с картами
  BottomBlock bottomBlock;

  // Переменные для отрисовки персонажей
  Rect leftPlayer;
  Rect rightPlayer;
  Sprite leftPlayerSprite;
  Sprite rightPlayerSprite;
  SpriteComponent spriteComponent;
  SpriteComponent rightSpriteComponent;

  // Загрузка спрайтов
  bool download = true;
  // Для вижения персонажей
  bool leftMove = true;
  bool rightMove = true;

  GameScreen(MyGame game) : super(game) {
    init();
    bgPaint.color = Colors.teal;

    bottomBlock = BottomBlock(this, 0, h * 0.7, w, h * 0.3);
    leftPlayer = Rect.fromLTWH(h * 0.1, h * 0.1, h * 0.45, h * 0.6);
    rightPlayer = Rect.fromLTWH(w - (h * 0.1 + h * 0.4), h * 0.1, h * 0.45, h * 0.615);
  }

  // Загрузка
  init() async {
    var imageLeft = await Flame.images.load("knight.png");
    var imageRight = await Flame.images.load("archer.png");
    leftPlayerSprite = Sprite.fromImage(imageLeft);
    rightPlayerSprite = Sprite.fromImage(imageRight);
    spriteComponent = SpriteComponent.fromSprite(rightPlayer.width, rightPlayer.height, rightPlayerSprite);
    download = false;
  }

  @override
  void render(Canvas c) {
    if(!download) {
      // Задний фон
      c.drawRect(bgRect, bgPaint);
      // Левый игрок
      leftPlayerSprite.renderRect(c, leftPlayer);
      // Правый игрок
      spriteComponent.setByRect(rightPlayer);
      spriteComponent.renderFlipX = true;
      spriteComponent.render(c);
      // Блок с картами
      bottomBlock.render(c);
    } else {
      // Нужно будет сделать экран закгрузки здесь
    }
  }

  @override
  void update(double t) {
    if(leftPlayer.height > h * 0.62) {
      leftMove = false;
    } else if (leftPlayer.height < h * 0.6){
      leftMove = true;
    }

    if(rightPlayer.height > h * 0.62) {
      rightMove = false;
    } else if (rightPlayer.height < h * 0.6){
      rightMove = true;
    }

    leftPlayer = leftMove ? Rect.fromLTWH(leftPlayer.left, leftPlayer.top - 0.10, leftPlayer.width, leftPlayer.height + 0.10)
        : Rect.fromLTWH(leftPlayer.left, leftPlayer.top + 0.05, leftPlayer.width, leftPlayer.height - 0.05);
    rightPlayer = rightMove ? Rect.fromLTWH(rightPlayer.left, rightPlayer.top - 0.10, rightPlayer.width, rightPlayer.height + 0.10)
        : Rect.fromLTWH(rightPlayer.left, rightPlayer.top + 0.05, rightPlayer.width, rightPlayer.height - 0.05);

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