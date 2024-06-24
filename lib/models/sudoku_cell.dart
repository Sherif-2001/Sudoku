class SudokuCell {
  final int row;
  final int col;
  int value;
  bool isInitial;
  bool isInvalid;

  SudokuCell(
      {required this.row,
      required this.col,
      required this.value,
      this.isInitial = false,
      this.isInvalid = false});
}
