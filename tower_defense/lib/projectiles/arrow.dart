import 'package:flame/components.dart';
import 'dart:math';
import '../screens/ember_quest.dart';

class Arrow extends SpriteComponent with HasGameRef<EmberQuestGame> {
  final Vector2 gridPosition;
  final double xOffset;
  Arrow({required this.gridPosition, required this.xOffset})
      : super(size: Vector2.all(64), anchor: Anchor.center);

  final Vector2 velocity = Vector2(-20, -20);
  double rotation = 80;

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
    position += velocity * dt;
    angle = velocity.x < 0
        ? atan(velocity.y / velocity.x) + pi / 2
        : atan(velocity.y / velocity.x) - pi / 2;
    velocity.rotate(pi * dt * rotation / 50);
    if (rotation > 10) rotation--;
    if (position.x < -size.x || game.health <= 0) {
      removeFromParent();
    }
    super.update(dt);
  }
}
