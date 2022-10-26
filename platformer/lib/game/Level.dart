import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:platformer/game/entities/Platform.dart';
import 'package:tiled/tiled.dart';

import 'game.dart';

class Level extends Component {
  late final map;
  final String levelName;

  Level(this.levelName) : super();

  @override
  Future<void> onLoad() async {
    final map = await TiledComponent.load(levelName, Vector2.all(16));

    add(map);

    await _spawnPlatforms(map.tileMap);
  }

  Future<void> _spawnPlatforms(RenderableTiledMap tileMap) async {
    final platformLayer = tileMap.getLayer<ObjectGroup>("Platforms");

    for (final platformObject in platformLayer!.objects) {
      final platform = Platform(
        position: Vector2(platformObject.x, platformObject.y),
        size: Vector2(platformObject.width, platformObject.height),
      );
      await add(platform);
    }
  }
}
