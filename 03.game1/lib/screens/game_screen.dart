import 'package:flutter/material.dart';
import 'dart:math';
import '../logic/game_logic.dart';
import '../widgets/game_board.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameLogic _game;

  @override
  void initState() {
    super.initState();
    _game = GameLogic();
  }

  void _newGame() {
    setState(() {
      _game.initBoard();
    });
  }

  void _handleSwipe(DragEndDetails details) {
    if (details.primaryVelocity == null) return;

    double dx = details.velocity.pixelsPerSecond.dx;
    double dy = details.velocity.pixelsPerSecond.dy;
    Direction? direction;

    if (dx.abs() > dy.abs()) {
      if (dx > 0) {
        direction = Direction.right;
      } else {
        direction = Direction.left;
      }
    } else {
      if (dy > 0) {
        direction = Direction.down;
      } else {
        direction = Direction.up;
      }
    }

    if (direction != null) {
      setState(() {
        bool moved = _game.move(direction!);
        if (moved) {
          if (_game.isGameWon()) {
            _showDialog('You Win!', 'You have reached 2048!');
          } else if (_game.isGameOver()) {
            _showDialog('Game Over', 'No more moves left.');
          }
        }
      });
    }
  }

  void _handleButtonMove(Direction direction) {
    setState(() {
      bool moved = _game.move(direction);
      if (moved) {
        if (_game.isGameWon()) {
          _showDialog('You Win!', 'You have reached 2048!');
        } else if (_game.isGameOver()) {
          _showDialog('Game Over', 'No more moves left.');
        }
      }
    });
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2048 Game'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _newGame,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Score:',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  _game.score.toString(),
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double size = min(constraints.maxWidth, constraints.maxHeight);
                        return Center(
                          child: SizedBox(
                            width: size,
                            height: size,
                            child: GestureDetector(
                              onVerticalDragEnd: _handleSwipe,
                              onHorizontalDragEnd: _handleSwipe,
                              child: GameBoard(game: _game),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_circle_up, size: 48),
                          onPressed: () => _handleButtonMove(Direction.up),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_circle_left, size: 48),
                              onPressed: () => _handleButtonMove(Direction.left),
                            ),
                            const SizedBox(width: 48), // Center space
                            IconButton(
                              icon: const Icon(Icons.arrow_circle_right, size: 48),
                              onPressed: () => _handleButtonMove(Direction.right),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_circle_down, size: 48),
                          onPressed: () => _handleButtonMove(Direction.down),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}