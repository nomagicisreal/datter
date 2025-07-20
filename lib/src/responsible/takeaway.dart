part of '../../datter.dart';

extension FValueChanged<T> on ValueChanged<T> {
  static ValueChanged<DirectionIn4> indexingByVerticalDrag({
    required ValueChanged<int> onIndex,
    required int currentIndex,
    required int maxIndex,
  }) =>
          (direction) => onIndex(
        direction == DirectionIn4.top
            ? math.min(currentIndex + 1, maxIndex)
            : math.max(currentIndex - 1, 0),
      );
}