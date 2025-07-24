import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Provider 임포트
import '../logic/game_logic.dart';
import '../models/tile.dart';
import 'tile_widget.dart';
import '../const/constants.dart'; // Import AppConstants

class GameBoard extends StatefulWidget {
  const GameBoard({super.key}); // game 파라미터 제거

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    // Provider를 통해 GameLogic 인스턴스에 접근
    final gameLogic = Provider.of<GameLogic>(context);

    return AspectRatio(
      aspectRatio: 1.0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double boardSize = constraints.biggest.shortestSide;
          final double boardPadding = 8.0; // Padding for the entire grid
          final double gap = 8.0; // Gap between tiles

          // Calculate tileSize based on the full boardSize, accounting for padding and gaps
          // boardSize = 2 * boardPadding + 4 * tileSize + 3 * gap
          // 4 * tileSize = boardSize - 2 * boardPadding - 3 * gap
          final double tileSize = (boardSize - (2 * boardPadding) - (3 * gap)) / 4;

          List<Widget> children = [];

          // Add empty cells as background
          for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 4; j++) {
              children.add(
                Positioned(
                  left: boardPadding + j * (tileSize + gap),
                  top: boardPadding + i * (tileSize + gap),
                  child: Container(
                    width: tileSize,
                    height: tileSize,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              );
            }
          }

          // Add actual tiles
          for (int r = 0; r < 4; r++) {
            for (int c = 0; c < 4; c++) {
              Tile? tile = gameLogic.board[r][c]; // gameLogic.board 사용
              if (tile != null) {
                children.add(
                  AnimatedPositioned(
                    key: ValueKey(tile.id),
                    duration: AppConstants.tileAnimationDuration,
                    curve: Curves.easeOut,
                    left: boardPadding + tile.col * (tileSize + gap),
                    top: boardPadding + tile.row * (tileSize + gap),
                    width: tileSize,
                    height: tileSize,
                    child: TileWidget(value: tile.value),
                  ),
                );
              }
            }
          }

          return Container(
            padding: EdgeInsets.all(boardPadding), // Add padding back here
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Stack(
              children: children,
            ),
          );
        },
      ),
    );
  }
}
