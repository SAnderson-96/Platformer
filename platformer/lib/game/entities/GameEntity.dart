import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:platformer/game/game.dart';

class GameEntity extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<PlatformerGame> {
  late String spriteSheetName;
  late final SpriteSheet spriteSheet;
  late Vector2 dimensions;
  GameEntity(this.spriteSheetName, this.dimensions) : super(size: dimensions);

  @override
  Future<void>? onLoad() async {
    super.onLoad();
  }

  Future<void> loadAnimations() async {
    spriteSheet = SpriteSheet(
      image: await gameRef.images.load(spriteSheetName),
      srcSize: Vector2(dimensions.x, dimensions.y),
    );
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }
}
