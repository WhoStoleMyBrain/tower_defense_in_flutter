class GameStateManager {
  int health;
  int score;
  int level;

  GameStateManager(
      {required this.health, required this.score, required this.level});

  void increaseScore(int value) {
    score += value;
  }

  void decreaseHealth(int value) {
    health -= value;
    if (health <= 0) {
      // Trigger game over event
    }
  }

  void advanceLevel() {
    level++;
    // Load the next level or segment
  }
}
