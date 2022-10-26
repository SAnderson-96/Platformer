import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:platformer/game/Level.dart';

import 'entities/Player.dart';

class PlatformerGame extends FlameGame
    with KeyboardEvents, HasCollisionDetection, HasKeyboardHandlerComponents {
  Level? _currentLevel;
  late Player _player;
  @override
  Future<void>? onLoad() async {
    super.onLoad();

    camera.viewport = FixedResolutionViewport(Vector2(600, 250));
    await loadLevel('level2.tmx');

    _player = Player('player/player_spritesheet.png', Vector2(69, 44));

    add(_player);

    camera.followComponent(_player);
  }

  Future<void> loadLevel(String levelName) async {
    _currentLevel?.removeFromParent();
    _currentLevel = Level(levelName);
    add(_currentLevel!);
    return;
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }

  @override
  void render(canvas) {
    super.render(canvas);
  }
}
