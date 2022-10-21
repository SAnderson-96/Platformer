import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

import 'game.dart';

class Level extends Component {
  late final map;
  final String levelName;

  Level(this.levelName) : super();

  @override
  Future<void> onLoad() async {
    final map = await TiledComponent.load(levelName, Vector2.all(16));

    add(map);
  }
}
