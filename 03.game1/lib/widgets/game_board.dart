import 'package:flutter/material.dart';
import '../logic/game_logic.dart';
import 'tile_widget.dart';

class GameBoard extends StatelessWidget {
  final GameLogic game;

  const GameBoard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemCount: 16,
          itemBuilder: (context, index) {
            int row = index ~/ 4;
            int col = index % 4;
            return TileWidget(value: game.board[row][col]);
          },
        ),
      ),
    );
  }
}
