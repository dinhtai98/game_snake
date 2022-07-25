import 'package:flutter/material.dart';
import 'package:snake/core/utils/enum.dart';

abstract class IHomeScreenViewModel extends ChangeNotifier {
  int get numberOfSquares;
  int get food;
  late bool gameIsStarded;
  List<int> get snakePositions;
  late Direction direction;
  void getRandomFood();
  void startGame();
  void pauseGame();
  void initData();
}
