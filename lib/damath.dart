import 'package:damath/damath.dart';

extension DoubleExtension2 on double {
  static bool predicateRadianOutRound(double value) =>
      value >= DoubleExtension.radian_angle360 ||
      value <= -DoubleExtension.radian_angle360;

  static bool predicateRadianInRound(double value) {
    if (value >= DoubleExtension.radian_angle360) return false;
    if (value <= -DoubleExtension.radian_angle360) return false;
    return true;
  }

// comment on isOrdered, see also collection/collection isSorted(compare)
// implement isNotOrdered
}

extension IterableComparable2<C extends Comparable> on Iterable<C> {
  // update isOrdered
  bool isNotOrdered({OrderLinear? order, bool strictly = false}) {
    final invalid = IteratorComparable.predicateInvalid;
    if (order != null) return iterator.exist(invalid(order, strictly));
    return iterator.exist(invalid(OrderLinear.increase, strictly)) ||
        iterator.exist(invalid(OrderLinear.decrease, strictly));
  }

  bool isOrdered2({OrderLinear? order, bool strictly = false}) =>
      isNotOrdered(order: order, strictly: strictly);
}

extension IteratorDouble2 on Iterator<double> {
  bool get everySignEqual {
    if (!moveNext()) throw StateError(Erroring.iterableNoElement);
    if (current.isNegative) {
      if (any(DoubleExtension.predicatePositive)) return false;
    } else {
      if (any(DoubleExtension.predicateNegative)) return false;
    }
    return true;
  }
}
