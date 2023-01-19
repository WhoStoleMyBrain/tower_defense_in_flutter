import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tower_defense/screens/ember_quest.dart';

class BackgroundTexture extends SpriteComponent
    with HasGameRef<EmberQuestGame> {
  final Vector2 gridPosition;
  double xOffset;
  String imageName;
  BackgroundTexture(
      {required this.gridPosition,
      required this.xOffset,
      required this.imageName})
      : super(size: Vector2.all(64), anchor: Anchor.bottomLeft);

  final Vector2 velocity = Vector2.zero();

  @override
  Future<void>? onLoad() async {
    final textureImage = game.images.fromCache(imageName);
    sprite = Sprite(textureImage);
    position = Vector2(
      (gridPosition.x * size.x) + xOffset,
      game.size.y - (gridPosition.y * size.y),
    );
    // add(RectangleHitbox()..collisionType = CollisionType.passive);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (game.health <= 0) {
      removeFromParent();
    }
    // velocity.x = game.objectSpeed;
    // position += velocity * dt;
    // if (position.x < -size.x) removeFromParent();
    super.update(dt);
  }
}
