extension ExString on String {
  String getFirstCharacter() {
    return isEmpty ? '' : substring(0, 1);
  }

  String getLastCharacter() {
    return isEmpty ? '' : substring(length - 1);
  }

  String slice(int size) {
    if (size.isNegative) {
      return length < size.abs() ? this : substring(length - size.abs(), length);
    }
    return length < size.abs() ? this : substring(0, size.abs());
  }
}
