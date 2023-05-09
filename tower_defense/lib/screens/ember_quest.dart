import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/widgets.dart';
import 'package:tower_defense/components/objects/background_texture.dart';
// import '../actors/ember.dart';
import '../components/actors/arrow_tower.dart';
import '../components/actors/water_enemy.dart';
import '../components/objects/ground_block.dart';
import '../components/objects/platform_block.dart';
import '../components/objects/star.dart';
import '../managers/game_state_manager.dart';
import '../managers/segment_manager.dart';
import '../overlays/hud.dart';
import '../components/projectiles/arrow.dart';

class EmberQuestGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  final GameStateManager gameStateManager;
  EmberQuestGame()
      : gameStateManager = GameStateManager(health: 100, score: 0, level: 1) {
    // Pass the gameStateManager instance to other components as needed
  }

  List<ArrowTower> arrowTowers = [];
  List<Arrow> arrows = [];

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
    segmentsToLoad.clamp(0, segments.length);
    for (var i = 0; i <= segmentsToLoad; i++) {
      loadGameSegments(i, (640 * i).toDouble());
    }
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
    updateComponents(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    renderComponents(canvas);
  }

  void updateComponents(double dt) {
    for (ArrowTower arrowTower in arrowTowers) {
      arrowTower.update(dt);
    }

    for (Arrow arrow in arrows) {
      arrow.update(dt);
    }
  }

  void renderComponents(Canvas canvas) {
    for (ArrowTower arrowTower in arrowTowers) {
      arrowTower.render(canvas);
    }

    for (Arrow arrow in arrows) {
      arrow.render(canvas);
    }
  }
}
