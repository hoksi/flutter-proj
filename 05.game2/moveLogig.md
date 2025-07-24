### `_moveRight()` 로직 재분석 및 문제점

`lib/logic/game_logic.dart` 파일의 `_moveRight()` 함수는 현재 다음과 같은 방식으로 작동합니다:

1.  **타일 필터링 및 역순 정렬**:
    ```dart
    List<Tile?> currentRow = board[r].where((tile) => tile != null).toList().reversed.toList();
    ```
    이 부분에서 문제가 발생합니다. 예를 들어 `[Slime, null, Goblin, null]`에서 `null`을 제거하면 `[Slime, Goblin]`이 됩니다. 여기에 `.reversed.toList()`를 적용하면 `[Goblin, Slime]`이 됩니다.

2.  **압축 및 합치기**:
    `for (int i = 0; i < currentRow.length; i++)` 루프는 `[Goblin, Slime]`을 왼쪽으로 이동하는 것처럼 처리합니다. `Goblin`과 `Slime`은 값이 다르므로 합쳐지지 않고, `newRow`는 `[Goblin, Slime]`이 됩니다.

3.  **다시 역순 정렬**:
    ```dart
    newRow = newRow.reversed.toList();
    ```
    `[Goblin, Slime]`을 다시 역순 정렬하면 `[Slime, Goblin]`이 됩니다.

4.  **보드 업데이트**:
    `for (int c = 3; c >= 0; c--)` 루프는 보드의 오른쪽 끝부터 왼쪽으로 타일을 채워나갑니다.
    *   `c=3` (가장 오른쪽): `newRow[0]`인 `Slime`이 `board[r][3]`에 배치됩니다.
    *   `c=2`: `newRow[1]`인 `Goblin`이 `board[r][2]`에 배치됩니다.
    *   결과적으로 `[null, null, Goblin, Slime]`이 됩니다.

**문제점 요약:**

`_moveRight()` 함수는 `_moveLeft()` 로직을 재사용하기 위해 행을 두 번 뒤집는 방식을 사용합니다. 하지만 이 과정에서 타일의 상대적인 순서가 의도치 않게 변경되어, `[Slime, Goblin]`이 `[Goblin, Slime]`으로 배치되는 문제가 발생합니다. 즉, 타일의 값은 올바르게 합쳐지지만, 합쳐지지 않는 타일들의 상대적인 위치가 뒤바뀌는 것입니다.

### 해결 방안

오른쪽 이동 로직을 직접 구현하여 타일의 상대적인 순서를 유지하도록 수정해야 합니다. 이는 타일들을 오른쪽에서 왼쪽으로 처리하면서 `newRow`에 타일을 삽입하는 방식으로 구현할 수 있습니다.

**수정된 `_moveRight()` 로직 (가상 코드):**

```dart
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
```

이 수정된 로직을 적용하면 `[Slime, null, Goblin, null]`은 `[null, null, Slime, Goblin]`으로 올바르게 이동할 것입니다. `_moveDown()` 함수도 유사한 방식으로 수정해야 합니다.