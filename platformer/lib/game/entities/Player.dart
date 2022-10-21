import 'package:flame/components.dart';
import 'package:platformer/game/entities/GameEntity.dart';

class Player extends GameEntity {
  late final SpriteAnimation walkingAnimation,
      idleAnimation,
      jumpingAnimation,
      fallingAnimation;
  //69,44
  final double speed = 150;
  int health = 6;

  Player(super.spriteSheetName, super.dimensions);

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    await loadAnimations();

    animation = idleAnimation;
    position.x = 0;
    position.y = 0;
  }

  @override
  Future<void> loadAnimations() async {
    await super.loadAnimations();
    walkingAnimation =
        spriteSheet.createAnimation(row: 1, stepTime: 0.15, from: 0, to: 7);
    idleAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.15, from: 0, to: 5);
    jumpingAnimation =
        spriteSheet.createAnimation(row: 6, stepTime: 0.15, from: 5, to: 7);
    fallingAnimation =
        spriteSheet.createAnimation(row: 7, stepTime: 0.15, from: 3, to: 5);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }
}
