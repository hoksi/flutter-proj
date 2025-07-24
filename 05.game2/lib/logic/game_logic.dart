import 'package:flutter/foundation.dart'; // ChangeNotifier를 위해 추가
import 'dart:math';
import 'package:uuid/uuid.dart';
import '../models/tile.dart';

// 게임의 이동 방향을 정의하는 열거형
enum Direction {
  up,
  down,
  left,
  right,
}

// 2048 게임의 핵심 로직을 담당하는 클래스
class GameLogic extends ChangeNotifier {
  // 4x4 게임 보드를 나타내는 2차원 리스트. 각 셀은 Tile 객체 또는 null을 가질 수 있음.
  late List<List<Tile?>> board;
  // 현재 게임 점수
  int score = 0;
  // 타일에 고유 ID를 부여하기 위한 Uuid 인스턴스
  final Uuid _uuid = const Uuid();

  // GameLogic 객체 생성 시 보드를 초기화
  GameLogic() {
    initBoard();
  }

  // 게임 보드를 초기화하고 새로운 타일 두 개를 생성하여 게임 시작
  void initBoard() {
    // 모든 셀을 null (빈 칸)으로 초기화
    board = List.generate(4, (i) => List.generate(4, (j) => null));
    score = 0; // 점수 초기화
    spawnNewTile(); // 첫 번째 타일 생성
    spawnNewTile(); // 두 번째 타일 생성
    notifyListeners(); // 보드 초기화 후 UI 업데이트 알림
  }

  // 비어있는 셀에 새로운 타일(값 2 또는 4)을 생성하여 추가
  Tile? spawnNewTile() {
    List<Point<int>> emptyCells = [];
    // 비어있는 모든 셀의 좌표를 emptyCells 리스트에 추가
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (board[i][j] == null) {
          emptyCells.add(Point(i, j));
        }
      }
    }

    // 비어있는 셀이 있다면
    if (emptyCells.isNotEmpty) {
      // 비어있는 셀 중 하나를 무작위로 선택
      Point<int> randomCell = emptyCells[Random().nextInt(emptyCells.length)];
      // 90% 확률로 2, 10% 확률로 4 값을 가짐
      int value = Random().nextDouble() < 0.9 ? 2 : 4;
      // 새로운 Tile 객체 생성
      Tile newTile = Tile(
        id: _uuid.v4(), // 고유 ID 부여
        value: value,
        row: randomCell.x,
        col: randomCell.y,
        isNew: true, // 새로 생성된 타일임을 표시 (애니메이션 등에 활용)
      );
      // 보드에 새로운 타일 배치
      board[randomCell.x][randomCell.y] = newTile;
      return newTile;
    }
    // 비어있는 셀이 없으면 null 반환 (게임 오버 상황일 수 있음)
    return null;
  }

  // 지정된 방향으로 타일을 이동시키고 합치는 메인 함수
  // 보드에 변화가 있었는지 여부를 반환
  bool move(Direction direction) {
    // 현재 보드의 상태를 깊은 복사하여 이전 상태를 저장 (변화 감지용)
    List<List<Tile?>> previousBoard = List.generate(4, (i) => List.generate(4, (j) => board[i][j]?.copyWith()));

    bool boardChanged = false;

    // 모든 타일의 isMerged 및 isNew 플래그를 초기화 (새로운 이동 처리 전)
    for (int r = 0; r < 4; r++) {
      for (int c = 0; c < 4; c++) {
        board[r][c]?.isMerged = false;
        board[r][c]?.isNew = false;
      }
    }

    // 방향에 따라 적절한 이동 함수 호출
    switch (direction) {
      case Direction.left:
        boardChanged = _moveLeft();
        break;
      case Direction.right:
        boardChanged = _moveRight();
        break;
      case Direction.up:
        boardChanged = _moveUp();
        break;
      case Direction.down:
        boardChanged = _moveDown();
        break;
    }

    // 이동 후 보드에 실제 변화가 있었는지 최종 확인
    // (이동 함수 내에서 changed 플래그가 설정되지 않았더라도, 타일의 위치나 값이 변경될 수 있으므로)
    if (!boardChanged) {
      for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
          // 이전 보드와 현재 보드의 타일 값 비교
          if (board[i][j]?.value != previousBoard[i][j]?.value) {
            boardChanged = true;
            break;
          }
        }
        if (boardChanged) break;
      }
    }
    
    // 보드에 변화가 있었다면 true 반환, 아니면 false 반환
    notifyListeners(); // 상태 변경 알림
    return boardChanged;
  }

  // 타일을 왼쪽으로 이동시키고 합치는 로직
  bool _moveLeft() {
    bool changed = false; // 보드 변경 여부
    for (int r = 0; r < 4; r++) { // 각 행에 대해 반복
      // 현재 행에서 null이 아닌 타일들만 필터링하여 리스트 생성
      List<Tile?> currentRow = board[r].where((tile) => tile != null).toList();
      List<Tile?> newRow = []; // 이동 및 합쳐진 후의 새로운 행
      bool mergedThisTurn = false; // 현재 턴에 합치기가 발생했는지 여부

      for (int i = 0; i < currentRow.length; i++) {
        // 다음 타일이 존재하고, 현재 타일과 다음 타일의 값이 같으며, 이번 턴에 아직 합치기가 발생하지 않았다면
        if (i + 1 < currentRow.length && currentRow[i]!.value == currentRow[i + 1]!.value && !mergedThisTurn) {
          int mergedValue = currentRow[i]!.value * 2; // 값 두 배로 합치기
          score += mergedValue; // 점수 증가
          // 합쳐진 타일 생성 (isMerged 플래그 true)
          newRow.add(currentRow[i]!.copyWith(value: mergedValue, isMerged: true));
          i++; // 다음 타일은 이미 합쳐졌으므로 건너뛰기
          mergedThisTurn = true; // 이번 턴에 합치기 발생
        } else {
          newRow.add(currentRow[i]!); // 합쳐지지 않은 타일은 그대로 추가
          mergedThisTurn = false; // 합치기 플래그 초기화
        }
      }

      // 새로운 행의 타일들을 보드에 업데이트하고 null로 채우기
      for (int c = 0; c < 4; c++) {
        if (c < newRow.length) { // 새로운 행에 타일이 있다면
          // 현재 보드의 타일과 새로운 타일의 ID 또는 값이 다르면 변경된 것으로 간주
          if (board[r][c]?.id != newRow[c]?.id || board[r][c]?.value != newRow[c]?.value) {
            changed = true;
          }
          // 타일의 위치(row, col) 업데이트
          newRow[c] = newRow[c]!.copyWith(row: r, col: c);
          board[r][c] = newRow[c]; // 보드에 타일 배치
        } else { // 새로운 행에 타일이 없다면 (빈 칸)
          if (board[r][c] != null) { // 기존에 타일이 있었다면 변경된 것으로 간주
            changed = true;
          }
          board[r][c] = null; // 빈 칸으로 설정
        }
      }
    }
    return changed; // 보드 변경 여부 반환
  }

  // 타일을 오른쪽으로 이동시키고 합치는 로직
  bool _moveRight() {
    bool changed = false;
    for (int r = 0; r < 4; r++) {
      List<Tile?> currentRow = board[r].where((tile) => tile != null).toList(); // 초기 역순 정렬 제거
      List<Tile?> newRow = [];
      bool mergedThisTurn = false;

      // 오른쪽에서 왼쪽으로 타일 처리
      for (int i = currentRow.length - 1; i >= 0; i--) { // 리스트의 끝에서부터 시작
        if (i - 1 >= 0 && currentRow[i]!.value == currentRow[i - 1]!.value && !mergedThisTurn) {
          // 이전 타일과 합쳐질 수 있다면
          int mergedValue = currentRow[i]!.value * 2;
          score += mergedValue;
          newRow.insert(0, currentRow[i]!.copyWith(value: mergedValue, isMerged: true)); // newRow의 맨 앞에 삽입
          i--; // 합쳐진 타일은 건너뛰기
          mergedThisTurn = true;
        } else {
          newRow.insert(0, currentRow[i]!); // 합쳐지지 않은 타일은 newRow의 맨 앞에 삽입
          mergedThisTurn = false;
        }
      }

      // 남은 공간을 null로 채워 오른쪽 정렬
      while (newRow.length < 4) {
        newRow.insert(0, null); // newRow의 맨 앞에 null 삽입
      }

      // 보드 업데이트
      for (int c = 0; c < 4; c++) {
        if (board[r][c]?.id != newRow[c]?.id || board[r][c]?.value != newRow[c]?.value) {
          changed = true;
        }
        if (newRow[c] != null) {
          newRow[c] = newRow[c]!.copyWith(row: r, col: c);
        }
        board[r][c] = newRow[c];
      }
    }
    return changed;
  }

  // 타일을 위쪽으로 이동시키고 합치는 로직
  bool _moveUp() {
    bool changed = false;
    // 보드를 전치(transpose)하여 열을 행처럼 처리
    List<List<Tile?>> transposedBoard = _transpose(board);
    for (int c = 0; c < 4; c++) { // 각 열(전치된 보드에서는 행)에 대해 반복
      List<Tile?> currentCol = transposedBoard[c].where((tile) => tile != null).toList();
      List<Tile?> newCol = [];
      bool mergedThisTurn = false;

      for (int i = 0; i < currentCol.length; i++) {
        if (i + 1 < currentCol.length && currentCol[i]!.value == currentCol[i + 1]!.value && !mergedThisTurn) {
          int mergedValue = currentCol[i]!.value * 2;
          score += mergedValue;
          newCol.add(currentCol[i]!.copyWith(value: mergedValue, isMerged: true));
          i++;
          mergedThisTurn = true;
        } else {
          newCol.add(currentCol[i]!);
          mergedThisTurn = false;
        }
      }

      // 새로운 열의 타일들을 보드에 업데이트하고 null로 채우기 (위쪽 정렬)
      for (int r = 0; r < 4; r++) { // 위에서 아래로 채워나감
        if (r < newCol.length) {
          if (board[r][c]?.id != newCol[r]?.id || board[r][c]?.value != newCol[r]?.value) {
            changed = true;
          }
          newCol[r] = newCol[r]!.copyWith(row: r, col: c);
          board[r][c] = newCol[r];
        } else {
          if (board[r][c] != null) {
            changed = true;
          }
          board[r][c] = null;
        }
      }
    }
    return changed;
  }

  // 타일을 아래쪽으로 이동시키고 합치는 로직
  bool _moveDown() {
    bool changed = false;
    // 보드를 전치(transpose)하여 열을 행처럼 처리
    List<List<Tile?>> transposedBoard = _transpose(board);
    for (int c = 0; c < 4; c++) { // 각 열(전치된 보드에서는 행)에 대해 반복
      List<Tile?> currentCol = transposedBoard[c].where((tile) => tile != null).toList(); // 초기 역순 정렬 제거
      List<Tile?> newCol = [];
      bool mergedThisTurn = false;

      // 아래쪽에서 위쪽으로 타일 처리
      for (int i = currentCol.length - 1; i >= 0; i--) { // 리스트의 끝에서부터 시작
        if (i - 1 >= 0 && currentCol[i]!.value == currentCol[i - 1]!.value && !mergedThisTurn) {
          // 이전 타일과 합쳐질 수 있다면
          int mergedValue = currentCol[i]!.value * 2;
          score += mergedValue;
          newCol.insert(0, currentCol[i]!.copyWith(value: mergedValue, isMerged: true)); // newCol의 맨 앞에 삽입
          i--; // 합쳐진 타일은 건너뛰기
          mergedThisTurn = true;
        } else {
          newCol.insert(0, currentCol[i]!); // 합쳐지지 않은 타일은 newCol의 맨 앞에 삽입
          mergedThisTurn = false;
        }
      }

      // 남은 공간을 null로 채워 아래쪽 정렬
      while (newCol.length < 4) {
        newCol.insert(0, null); // newCol의 맨 앞에 null 삽입
      }

      // 보드 업데이트
      for (int r = 0; r < 4; r++) {
        if (board[r][c]?.id != newCol[r]?.id || board[r][c]?.value != newCol[r]?.value) {
          changed = true;
        }
        if (newCol[r] != null) {
          newCol[r] = newCol[r]!.copyWith(row: r, col: c);
        }
        board[r][c] = newCol[r];
      }
    }
    return changed;
  }

  // 4x4 행렬을 전치(transpose)하는 헬퍼 함수 (행과 열을 바꿈)
  List<List<Tile?>> _transpose(List<List<Tile?>> matrix) {
    return List.generate(4, (i) => List.generate(4, (j) => matrix[j][i]));
  }

  // 게임 오버 여부를 확인하는 함수
  bool isGameOver() {
    // 비어있는 셀이 있다면 게임 오버가 아님
    if (_hasEmptyCell()) {
      return false;
    }

    // 합칠 수 있는 타일이 있는지 확인
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        // 가로 방향으로 합칠 수 있는 타일이 있는지 확인
        if (j < 3 && board[i][j]?.value == board[i][j + 1]?.value) {
          return false;
        }
        // 세로 방향으로 합칠 수 있는 타일이 있는지 확인
        if (i < 3 && board[i][j]?.value == board[i + 1][j]?.value) {
          return false;
        }
      }
    }
    // 비어있는 셀도 없고, 합칠 수 있는 타일도 없으면 게임 오버
    return true;
  }

  // 보드에 비어있는 셀이 있는지 확인하는 헬퍼 함수
  bool _hasEmptyCell() {
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (board[i][j] == null) {
          return true;
        }
      }
    }
    return false;
  }

  // 게임 승리(2048 타일 생성) 여부를 확인하는 함수
  bool isGameWon() {
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (board[i][j]?.value == 2048) {
          return true;
        }
      }
    }
    return false;
  }
}

