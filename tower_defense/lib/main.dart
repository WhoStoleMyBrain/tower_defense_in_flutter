import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import './screens/ember_quest.dart';
import './overlays/main_menu.dart';
import './overlays/game_over.dart';

void main() {
  runApp(GameWidget<EmberQuestGame>.controlled(
    gameFactory: EmberQuestGame.new,
    overlayBuilderMap: {
      'MainMenu': (_, game) => MainMenu(game: game),
      'GameOver': (_, game) => GameOver(game: game),
    },
    initialActiveOverlays: const ['MainMenu'],
  ));
}
