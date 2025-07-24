import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart'; // Provider 임포트
import '../logic/game_logic.dart';
import '../widgets/game_board.dart';
import '../const/constants.dart'; // Import AppConstants

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  void _newGame(BuildContext context) {
    Provider.of<GameLogic>(context, listen: false).initBoard();
  }

  void _handleMove(BuildContext context, Direction direction) async {
    final gameLogic = Provider.of<GameLogic>(context, listen: false);
    bool moved = gameLogic.move(direction);
    if (moved) {
      await Future.delayed(AppConstants.tileAnimationDuration); // Wait for animation to complete
      gameLogic.spawnNewTile(); // This will call notifyListeners() internally
      if (gameLogic.isGameWon()) {
        _showDialog(context, 'You Win!', 'You have reached 2048!');
      } else if (gameLogic.isGameOver()) {
        _showDialog(context, 'Game Over', 'No more moves left.');
      }
    }
  }

  void _handleSwipe(BuildContext context, DragEndDetails details) {
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
      _handleMove(context, direction);
    }
  }

  void _handleButtonMove(BuildContext context, Direction direction) {
    _handleMove(context, direction);
  }

  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _newGame(context); // Start a new game after closing the dialog
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange, // Button background color
              foregroundColor: Colors.white, // Button text color
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text(
              'Play Again',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
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
            onPressed: () => _newGame(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<GameLogic>(
              builder: (context, gameLogic, child) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'SCORE',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      gameLogic.score.toString(),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
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
                              onVerticalDragEnd: (details) => _handleSwipe(context, details),
                              onHorizontalDragEnd: (details) => _handleSwipe(context, details),
                              child: GameBoard(), // GameBoard no longer needs gameLogic directly
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
                          onPressed: () => _handleButtonMove(context, Direction.up),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_circle_left, size: 48),
                              onPressed: () => _handleButtonMove(context, Direction.left),
                            ),
                            const SizedBox(width: 48), // Center space
                            IconButton(
                              icon: const Icon(Icons.arrow_circle_right, size: 48),
                              onPressed: () => _handleButtonMove(context, Direction.right),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_circle_down, size: 48),
                          onPressed: () => _handleButtonMove(context, Direction.down),
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