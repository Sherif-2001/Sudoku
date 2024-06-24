import 'dart:math';

import 'package:sudoku/models/sudoku_cell.dart';

enum Difficulty { easy, normal, hard }

class SudokuBoard {
  List<List<SudokuCell>> board = List.generate(
      9,
      (row) =>
          List.generate(9, (col) => SudokuCell(row: row, col: col, value: 0)));

  bool isValid(int row, int col, int num) {
    // Check row and column
    for (int i = 0; i < 9; i++) {
      if (board[row][i].value == num && i != col) {
        return false;
      }
      if (board[i][col].value == num && i != row) {
        return false;
      }
    }

    // Check 3x3 grid
    int startRow = (row ~/ 3) * 3;
    int startCol = (col ~/ 3) * 3;
    for (int i = startRow; i < startRow + 3; i++) {
      for (int j = startCol; j < startCol + 3; j++) {
        if (board[i][j].value == num && (i != row || j != col)) {
          return false;
        }
      }
    }

    return true;
  }

  bool solve() {
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        if (board[row][col].value == 0) {
          for (int num = 1; num <= 9; num++) {
            if (isValid(row, col, num)) {
              board[row][col].value = num;
              if (solve()) {
                return true;
              }
              board[row][col].value = 0;
            }
          }
          return false;
        }
      }
    }
    return true;
  }

  bool isGameComplete() {
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        if (board[row][col].value == 0) {
          return false;
        }
        if (board[row][col].isInvalid) {
          return false;
        }
      }
    }
    return true;
  }

  void fillDiagonal() {
    for (int i = 0; i < 9; i += 3) {
      fillBox(i, i);
    }
  }

  void fillBox(int row, int col) {
    int num;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        do {
          num = Random().nextInt(9) + 1;
        } while (!isValid(row + i, col + j, num));
        board[row + i][col + j].value = num;
      }
    }
  }

  void removeDigits(int count) {
    while (count != 0) {
      int cellId = Random().nextInt(81);

      int row = cellId ~/ 9;
      int col = cellId % 9;

      if (board[row][col].value != 0) {
        board[row][col].value = 0;
        count--;
      }
    }
  }

  void generatePuzzle(Difficulty difficulty) {
    board = List.generate(
        9,
        (row) => List.generate(
            9, (col) => SudokuCell(row: row, col: col, value: 0)));
    fillDiagonal();
    solve();
    switch (difficulty) {
      case Difficulty.easy:
        removeDigits(1); // Adjust the number of removed digits for difficulty
        break;
      case Difficulty.normal:
        removeDigits(40); // Adjust the number of removed digits for difficulty
        break;
      case Difficulty.hard:
        removeDigits(60); // Adjust the number of removed digits for difficulty
        break;
    }

    // Mark the initial cells
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        board[i][j].isInitial = false;
        if (board[i][j].value != 0) {
          board[i][j].isInitial = true;
        }
      }
    }
  }
}
