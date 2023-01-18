import 'package:flutter/material.dart';

import '../screens/ember_quest.dart';

class MainMenu extends StatelessWidget {
  final EmberQuestGame game;

  const MainMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    const blackTextColor = Color.fromRGBO(0, 0, 0, 1.0);
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 250,
          width: 300,
          decoration: const BoxDecoration(
              color: blackTextColor,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Ember Quest',
                style: TextStyle(
                  color: whiteTextColor,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 200,
                height: 75,
                child: ElevatedButton(
                    onPressed: () {
                      game.overlays.remove('MainMenu');
                    },
                    child: const Text(
                      'Play',
                      style: TextStyle(color: blackTextColor, fontSize: 40.0),
                    )),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'Use WASD or Arrow Keys for movement. Space bar to jump. Collect as many Stars as you can and avoid enemies!',
                textAlign: TextAlign.center,
                style: TextStyle(color: whiteTextColor, fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}
