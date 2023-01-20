import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../screens/ember_quest.dart';

class Arrow extends SpriteComponent with HasGameRef<EmberQuestGame> {
  final Vector2 gridPosition;
  final double xOffset;
  Arrow({required this.gridPosition, required this.xOffset})
      : super(size: Vector2.all(64), anchor: Anchor.center);

  final Vector2 velocity = Vector2(-10, -10);

  @override
  Future<void>? onLoad() async {
    final starImage = game.images.fromCache('towerDefense_tilesheet.png');
    sprite = Sprite(starImage,
        srcPosition: Vector2(128 * 20, 128 * 12), srcSize: Vector2.all(128));
    position = Vector2(
      (gridPosition.x * size.x) + xOffset + (size.x / 2),
      game.size.y - (gridPosition.y * size.y) - (size.y / 2),
    );
  }

  @override
  void update(double dt) {
    // velocity.x = game.objectSpeed;
    position += velocity * dt;
    angle = -atan(velocity.y / velocity.x);
    // if (velocity.y <= 0) {
    //   flipVertically();
    // }
    // if (velocity.x <= 0) {
    //   flipHorizontally();
    // }
    print(angle);
    if (position.x < -size.x || game.health <= 0) {
      removeFromParent();
    }
    super.update(dt);
  }
}
