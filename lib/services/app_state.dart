class AppState {
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal();

  int flappyBirdHS = 0;
  int score2048HS = 0;
  int fruitNinjaHS = 0;
  int memoryMatchHS = 0;
  int blockBlastHS = 0;

  void updateFlappyBirdScore(int score) {
    if (score > flappyBirdHS) {
      flappyBirdHS = score;
    }
  }

  void update2048Score(int score) {
    if (score > score2048HS) {
      score2048HS = score;
    }
  }

  void updateFruitNinjaScore(int score) {
    if (score > fruitNinjaHS) {
      fruitNinjaHS = score;
    }
  }

  void updateMemoryMatchScore(int score) {
    if (score > memoryMatchHS) {
      memoryMatchHS = score;
    }
  }

  void updateBlockBlastScore(int score) {
    if (score > blockBlastHS) {
      blockBlastHS = score;
    }
  }
}
