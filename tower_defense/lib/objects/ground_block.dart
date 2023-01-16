import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../managers/segment_manager.dart';
import '../screens/ember_quest.dart';

class GroundBlock extends SpriteComponent with HasGameRef<EmberQuestGame> {
  final Vector2 gridPosition;
  final double xOffset;
  GroundBlock({required this.gridPosition, required this.xOffset})
      : super(size: Vector2.all(64), anchor: Anchor.bottomLeft);

  final Vector2 velocity = Vector2.zero();
  final UniqueKey _blockKey = UniqueKey();

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    final groundImage = game.images.fromCache('ground.png');
    sprite = Sprite(groundImage);
    position = Vector2((gridPosition.x * size.x) + xOffset,
        game.size.y - (gridPosition.y * size.y));
    add(RectangleHitbox()..collisionType = CollisionType.passive);
    if (gridPosition.x == 9 && position.x > game.lastBlockXPosition) {
      game.lastBlockKey = _blockKey;
      game.lastBlockXPosition = position.x + size.x;
    }
  }

  @override
  void update(double dt) {
    // TODO: implement update
    if (game.health <= 0) {
      removeFromParent();
    }
    velocity.x = game.objectSpeed;
    position += velocity * dt;
    if (position.x < -size.x) {
      removeFromParent();
      if (gridPosition.x == 0) {
        game.loadGameSegments(
            Random().nextInt(segments.length), game.lastBlockXPosition);
      }
    }
    if (gridPosition.x == 9) {
      if (game.lastBlockKey == _blockKey) {
        game.lastBlockXPosition = position.x + size.x - 10;
      }
    }
    super.update(dt);
  }
}
