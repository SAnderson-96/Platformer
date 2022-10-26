import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:platformer/game/entities/GameEntity.dart';
import 'package:platformer/game/entities/Platform.dart';
import 'package:platformer/game/enums/Direction.dart';

class Player extends GameEntity with KeyboardHandler {
  late final SpriteAnimation walkingAnimation,
      idleAnimation,
      jumpingAnimation,
      fallingAnimation;
  //69,44
  final double speed = 150;
  int health = 6;
  Vector2 gravity = Vector2(0, 600);
  late RectangleHitbox hitbox;
  Vector2 velocity = Vector2(0, 0);
  bool isJumping = false;
  bool isOnGround = false;
  Direction facing = Direction.right;

  Player(super.spriteSheetName, super.dimensions);

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    await loadAnimations();

    debugMode = false;
    hitbox = RectangleHitbox.relative(Vector2(0.3, 0.8),
        parentSize: size, position: Vector2(size.x / 4.5, size.y / 5));
    add(hitbox);
    hitbox.debugMode = true;

    animation = idleAnimation;
    position.x = 0;
    position.y = 200;
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

    if (!isOnGround) {
      position.y += gravity.y * dt;
    }
    position.y += velocity.y * dt;
    position.x += velocity.x * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (isOnGround && !isJumping) return;
    if (other is Platform) {
      velocity.y = 0;
      position.y = other.position.y - hitbox.size.y;
      isOnGround = true;
    }
    super.onCollision(intersectionPoints, other);
  }

  jump() {
    isJumping = true;
    isOnGround = false;
    velocity.y = -600;
  }

  @override
  bool onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;

    final isSpace = keysPressed.contains(LogicalKeyboardKey.space);

    if (isSpace && isKeyDown && isOnGround) {
      jump();
    }

    if (keysPressed.contains(LogicalKeyboardKey.keyA)) {
      velocity.x = -100;
      animation = walkingAnimation;
      if (facing != Direction.left) {
        flipHorizontallyAroundCenter();
        facing = Direction.left;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.keyD)) {
      velocity.x = 100;
      animation = walkingAnimation;
      if (facing != Direction.right) {
        flipHorizontallyAroundCenter();
        facing = Direction.right;
      }
    } else {
      velocity.x = 0;
      animation = idleAnimation;
    }

    return true;
  }
}
