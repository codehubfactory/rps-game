enum GameAsset {
  paper,
  rock,
  scissor,
  lose,
  win,
}

extension AssetExtension on GameAsset {
  String get assetPath {
    switch (this) {
      case GameAsset.paper:
        return 'assets/game_icons/paper.svg';
      case GameAsset.rock:
        return 'assets/game_icons/rock.svg';
      case GameAsset.scissor:
        return 'assets/game_icons/scissor.svg';
      case GameAsset.lose:
        return 'assets/game_icons/sad_face.svg';
      case GameAsset.win:
        return 'assets/game_icons/win.svg';
    }
  }
}
