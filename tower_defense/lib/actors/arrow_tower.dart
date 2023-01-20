import 'dart:async' as async;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import '../projectiles/arrow.dart';

import '../screens/ember_quest.dart';

class ArrowTower extends SpriteComponent with HasGameRef<EmberQuestGame> {
  final Vector2 gridPosition;
  final double xOffset;
  ArrowTower({required this.gridPosition, required this.xOffset})
      : super(size: Vector2.all(64), anchor: Anchor.center);

  final Vector2 velocity = Vector2.zero();

  final List<SpriteComponent> projectiles = [];

  Future<void> tendToProjectilesList() async {
    // print(projectiles.length);
    for (var element in projectiles) {
      // print(element);
      if (element.isLoaded == false) {
        game.add(element);
      }
    }
    if (projectiles.length > 5) {
      final projectile = projectiles.first;
      projectile.removeFromParent();
      projectiles.removeAt(0);
    }
  }

  @override
  Future<void>? onLoad() async {
    final timer = async.Timer.periodic(Duration(seconds: 2), (timer) {
      projectiles.add(Arrow(gridPosition: gridPosition, xOffset: xOffset));
      tendToProjectilesList();
      // print(projectiles.length);
    });
    final starImage = game.images.fromCache('towerDefense_tilesheet.png');
    sprite = Sprite(starImage,
        srcPosition: Vector2(128 * 19, 128 * 8), srcSize: Vector2.all(128));
    position = Vector2(
      (gridPosition.x * size.x) + xOffset + (size.x / 2),
      game.size.y - (gridPosition.y * size.y) - (size.y / 2),
    );
  }

  @override
  void update(double dt) {
    velocity.x = game.objectSpeed;
    position += velocity * dt;
    if (position.x < -size.x || game.health <= 0) {
      removeFromParent();
    }
    super.update(dt);
  }
}
