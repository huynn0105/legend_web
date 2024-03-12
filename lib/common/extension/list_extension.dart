extension ExNonNullableList<T> on List<T> {
  List<List<T>> reshape({required int column}) {
    List<List<T>> result = [];
    int row = length ~/ column;
    if (length % column > 0) {
      row++;
    }
    for (int r = 0; r < row; r++) {
      List<T> tmp = [];
      for (int c = 0; c < column; c++) {
        int i = r * column + c;
        if (i < length) {
          tmp.add(this[i]);
        }
      }
      result.add(tmp);
    }
    return result;
  }
}

extension ExNullableList<T> on List<T>? {
  T? valueAt(int? index) {
    if (this == null || index == null || index < 0 || index >= this!.length) {
      return null;
    }
    return this![index];
  }

  T? getFirst() {
    if (this == null) {
      return null;
    }
    return valueAt(0);
  }

  T? getLast() {
    if (this == null) {
      return null;
    }
    return valueAt(this!.length - 1);
  }

  List<T> updateAt(int index, T t) {
    if (this == null || index < 0 || index >= this!.length) {
      return [];
    }
    List<T> list = [];
    list.add(t);
    this!.replaceRange(index, index + 1, list);
    return this!;
  }
}