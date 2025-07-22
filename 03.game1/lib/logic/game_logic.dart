import 'dart:math';

enum Direction {
  up,
  down,
  left,
  right,
}

class GameLogic {
  late List<List<int>> board;
  int score = 0;

  GameLogic() {
    initBoard();
  }

  void initBoard() {
    board = List.generate(4, (i) => List.generate(4, (j) => 0));
    score = 0;
    spawnNewTile();
    spawnNewTile();
  }

  void spawnNewTile() {
    List<Point<int>> emptyCells = [];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (board[i][j] == 0) {
          emptyCells.add(Point(i, j));
        }
      }
    }

    if (emptyCells.isNotEmpty) {
      Point<int> randomCell = emptyCells[Random().nextInt(emptyCells.length)];
      board[randomCell.x][randomCell.y] = Random().nextDouble() < 0.9 ? 2 : 4;
    }
  }

  bool move(Direction direction) {
    List<List<int>> previousBoard = board.map((row) => List<int>.from(row)).toList();

    switch (direction) {
      case Direction.left:
        _moveLeft();
        break;
      case Direction.right:
        _moveRight();
        break;
      case Direction.up:
        _moveUp();
        break;
      case Direction.down:
        _moveDown();
        break;
    }

    bool boardChanged = false;
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (board[i][j] != previousBoard[i][j]) {
          boardChanged = true;
          break;
        }
      }
    }

    if (boardChanged) {
      spawnNewTile();
    }
    return boardChanged;
  }

  void _moveLeft() {
    for (int i = 0; i < 4; i++) {
      board[i] = _slideAndMergeRow(board[i]);
    }
  }

  void _moveRight() {
    for (int i = 0; i < 4; i++) {
      board[i] = _slideAndMergeRow(board[i].reversed.toList()).reversed.toList();
    }
  }

  void _moveUp() {
    List<List<int>> transposedBoard = _transpose(board);
    for (int i = 0; i < 4; i++) {
      transposedBoard[i] = _slideAndMergeRow(transposedBoard[i]);
    }
    board = _transpose(transposedBoard);
  }

  void _moveDown() {
    List<List<int>> transposedBoard = _transpose(board);
    for (int i = 0; i < 4; i++) {
      transposedBoard[i] = _slideAndMergeRow(transposedBoard[i].reversed.toList()).reversed.toList();
    }
    board = _transpose(transposedBoard);
  }

  List<int> _slideAndMergeRow(List<int> row) {
    List<int> newRow = row.where((val) => val != 0).toList();
    List<int> mergedRow = [];
    bool mergedThisTurn = false;

    for (int i = 0; i < newRow.length; i++) {
      if (i + 1 < newRow.length && newRow[i] == newRow[i + 1] && !mergedThisTurn) {
        int mergedValue = newRow[i] * 2;
        mergedRow.add(mergedValue);
        score += mergedValue;
        i++; // Skip the next tile as it's merged
        mergedThisTurn = true;
      } else {
        mergedRow.add(newRow[i]);
        mergedThisTurn = false;
      }
    }

    while (mergedRow.length < 4) {
      mergedRow.add(0);
    }
    return mergedRow;
  }

  List<List<int>> _transpose(List<List<int>> matrix) {
    return List.generate(4, (i) => List.generate(4, (j) => matrix[j][i]));
  }

  bool isGameOver() {
    if (_hasEmptyCell()) {
      return false;
    }

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (j < 3 && board[i][j] == board[i][j + 1]) {
          return false;
        }
        if (i < 3 && board[i][j] == board[i + 1][j]) {
          return false;
        }
      }
    }
    return true;
  }

  bool _hasEmptyCell() {
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (board[i][j] == 0) {
          return true;
        }
      }
    }
    return false;
  }


  bool isGameWon() {
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (board[i][j] == 2048) {
          return true;
        }
      }
    }
    return false;
  }
}
