extension StringExtension on String {
  bool isDigit(int index) {
    return this.codeUnitAt(index) >= 48 && this.codeUnitAt(index) <= 57;
  }
}
