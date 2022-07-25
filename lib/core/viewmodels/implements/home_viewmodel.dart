import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snake/core/utils/enum.dart';
import 'package:snake/core/viewmodels/interfaces/ihome_viewmodel.dart';

class HomeScreenViewModel extends ChangeNotifier
    implements IHomeScreenViewModel {
  int _numberOfSquares = 400;
  int get numberOfSquares => _numberOfSquares;
  int _food = 0;
  int get food => _food;
  List<int> _snakePositions = [];
  List<int> get snakePositions => _snakePositions;
  Direction _direction = Direction.right;
  Direction get direction => _direction;
  set direction(Direction value) {
    _direction = value;
    notifyListeners();
  }

  bool _gameIsStarded = false;
  bool get gameIsStarded => _gameIsStarded;
  set gameIsStarded(bool value) {
    _gameIsStarded = value;
    notifyListeners();
  }

  Timer? _timer;
  int _speed = 1;

  @override
  void getRandomFood() {
    var rd = Random();
    _food = rd.nextInt(_numberOfSquares);
    notifyListeners();
    if (_snakePositions.length > 1 && (_snakePositions.length - 1) % 5 == 0) {
      changeSpeed();
    }
  }

  @override
  void startGame() {
    _gameIsStarded = true;
    notifyListeners();
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: 500 ~/ _speed), (timer) {
      if (_gameOver()) {
        _updateSnakePosition();
      } else {
        _timer?.cancel();
        Get.dialog(AlertDialog(
          contentPadding: EdgeInsets.all(0),
          content: Container(
            height: 200,
            width: 500,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Game Over!",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Your game is over but you played well. Your score is ${_snakePositions.length - 1}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                      onPressed: () {
                        initData();
                        startGame();
                        Get.back();
                      },
                      child: Text(
                        "Restart",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      }
    });
  }

  @override
  void pauseGame() {
    _timer?.cancel();
    notifyListeners();
  }

  void _updateSnakePosition() {
    switch (_direction) {
      case Direction.down:
        if (_snakePositions.last > 380) {
          _snakePositions.add(_snakePositions.last + 20 - 400);
        } else {
          _snakePositions.add(_snakePositions.last + 20);
        }
        break;
      case Direction.up:
        if (_snakePositions.last < 20) {
          _snakePositions.add(_snakePositions.last - 20 + 400);
        } else {
          _snakePositions.add(_snakePositions.last - 20);
        }
        break;
      case Direction.left:
        if (_snakePositions.last % 20 == 0) {
          _snakePositions.add(_snakePositions.last - 1 + 20);
        } else {
          _snakePositions.add(_snakePositions.last - 1);
        }
        break;
      case Direction.right:
        if ((_snakePositions.last + 1) % 20 == 0) {
          _snakePositions.add(_snakePositions.last + 1 - 20);
        } else {
          _snakePositions.add(_snakePositions.last + 1);
        }
        break;
      default:
    }

    if (_snakePositions.last == _food) {
      getRandomFood();
    } else {
      _snakePositions.removeAt(0);
      notifyListeners();
    }
  }

  void changeSpeed() {
    _speed++;
    startGame();
  }

  bool _gameOver() {
    var temp = _snakePositions.toSet().toList();
    return _snakePositions.length == temp.length;
  }

  @override
  void initData() {
    _snakePositions.clear();
    _snakePositions.add(_getRandomFirstSnakePosition());
    _speed = 1;
    _direction = _getRandomDirection();
    _gameIsStarded = false;
    getRandomFood();
  }

  int _getRandomFirstSnakePosition() {
    var rd = Random();
    int result = rd.nextInt(400);
    if (result == _food) {
      result = _getRandomFirstSnakePosition();
    }
    return result;
  }

  Direction _getRandomDirection() {
    var rd = Random();
    Direction direction;
    int result = rd.nextInt(3);
    switch (result) {
      case 0:
        direction = Direction.down;
        break;
      case 1:
        direction = Direction.up;
        break;
      case 2:
        direction = Direction.left;
        break;
      case 3:
        direction = Direction.right;
        break;
      default:
        direction = Direction.down;
    }
    return direction;
  }
}
