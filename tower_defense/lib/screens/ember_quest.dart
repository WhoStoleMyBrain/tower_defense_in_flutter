import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/widgets.dart';
import 'package:tower_defense/objects/background_texture.dart';
// import '../actors/ember.dart';
import '../actors/arrow_tower.dart';
import '../actors/water_enemy.dart';
import '../objects/ground_block.dart';
import '../objects/platform_block.dart';
import '../objects/star.dart';
import '../managers/segment_manager.dart';
import '../overlays/hud.dart';
import '../projectiles/arrow.dart';

class EmberQuestGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  EmberQuestGame();

  // late EmberPlayer _ember;
  double objectSpeed = 0.0;

  late double lastBlockXPosition = 0.0;
  late UniqueKey lastBlockKey;

  int starsCollected = 0;
  int health = 3;

  @override
  Future<void>? onLoad() async {
    await images.loadAll([
      // 'block.png',
      // 'ember.png',
      // 'ground.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      // 'water_enemy.png',
      '203.jpg',
      '209.jpg',
      // '243.jpg',
      // '235.jpg',
      // '245.jpg',
      'towerDefense_tilesheet.png'
      // 0,0 at top left
      // 2944 x 1664
      // 23 x 13
      // -> 128 x 128
    ]);
    initializeGame(true);
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 173, 233, 247);
  }

  void addGameSegment(Component component) {
    add(component);
  }

  void loadGameSegments(int segmentIndex, double xPositionOffset) {
    for (final block in segments[segmentIndex]) {
      if (block.gridPositions.length == 1) {
        switch (block.blockType) {
          case ArrowTower:
            add(ArrowTower(
                gridPosition: block.gridPositions.first,
                xOffset: xPositionOffset));
            break;
          case Arrow:
            add(Arrow(
                gridPosition: block.gridPositions.first,
                xOffset: xPositionOffset));
            break;
          case Star:
            add(Star(
                gridPosition: block.gridPositions.first,
                xOffset: xPositionOffset));
            break;

          case BackgroundTexture:
            add(BackgroundTexture(
                gridPosition: block.gridPositions.first,
                xOffset: xPositionOffset,
                imageName: block.textureName));
            break;
        }
      } else if (block.gridPositions.length == 2) {
        switch (block.blockType) {
          case BackgroundTexture:
            final startX = block.gridPositions.first.x;
            final endX = block.gridPositions.last.x;

            final startY = block.gridPositions.first.y;
            final endY = block.gridPositions.last.y;
            for (double x = startX; x < endX; x++) {
              for (double y = startY; y < endY; y++) {
                add(BackgroundTexture(
                    gridPosition: Vector2(x, y),
                    xOffset: xPositionOffset,
                    imageName: block.textureName));
              }
            }
            break;
        }
      } else {}
    }
  }

  void initializeGame(bool loadHud) {
    const segmentsToLoad = 0;
    // final segmentsToLoad = (size.x / 640).ceil();
    segmentsToLoad.clamp(0, segments.length);
    // print(
    //     'segmentsToLoad $segmentsToLoad, segments.length: ${segments.length}');
    for (var i = 0; i <= segmentsToLoad; i++) {
      // print(i);
      loadGameSegments(i, (640 * i).toDouble());
    }
    // _ember = EmberPlayer(position: Vector2(128, canvasSize.y - 128));
    // add(_ember);
    add(Hud());
    if (loadHud) {
      add(Hud());
    }
  }

  void reset() {
    starsCollected = 0;
    health = 3;
    initializeGame(false);
  }

  @override
  void update(double dt) {
    if (health <= 0) {
      overlays.add('GameOver');
    }
    super.update(dt);
  }
}
