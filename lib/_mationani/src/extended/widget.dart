part of '../../_mationani.dart';

///
///
/// [MationaniCuttingAnchored]
///
///

class AlignmentBorder extends Alignment {
  const AlignmentBorder._(super.x, super.y);

  const AlignmentBorder.left(double y) : this._(-1, y);

  const AlignmentBorder.top(double x) : this._(x, -1);

  const AlignmentBorder.right(double y) : this._(1, y);

  const AlignmentBorder.bottom(double x) : this._(x, 1);

  static const AlignmentBorder topLeft = AlignmentBorder.top(-1);
  static const AlignmentBorder topRight = AlignmentBorder.top(1);
  static const AlignmentBorder bottomLeft = AlignmentBorder.bottom(-1);
  static const AlignmentBorder bottomRight = AlignmentBorder.bottom(1);

  static bool validateCuttingOn(
    AlignmentBorder alignment,
    Iterable<double> radians,
  ) {
    final iterator = radians.iterator;
    if (!iterator.moveNext()) throw StateError(Erroring.iterableNoElement);

    // require ordered
    if (radians.isNotOrdered(order: OrderLinear.increase, strictly: true)) {
      return false;
    }

    // require boundary
    final first = iterator.current, last = iterator.last;
    assert(
      first >= -DoubleExtension.radian_angle180 &&
          last <= DoubleExtension.radian_angle180,
      'convention: require radians between ±π',
    );
    final x = alignment.x, y = alignment.y;

    // left
    if (x == -1) {
      const r90 = DoubleExtension.radian_angle90;

      // topLeft
      if (y == -1) {
        if (first >= r90 || first <= 0) return false;
        if (last >= r90 || last <= 0) return false;
        return true;
      }

      // bottomLeft
      if (y == 1) {
        if (first >= 0 || first <= -r90) return false;
        if (last >= 0 || last <= -r90) return false;
        return true;
      }

      if (first.abs() >= r90 || last.abs() >= r90) return false;
      return true;
    }

    // right
    if (x == 1) {
      const r90 = DoubleExtension.radian_angle90,
          r180 = DoubleExtension.radian_angle180;

      // topRight
      if (y == -1) {
        if (first <= r90 || first >= r180) return false;
        if (last <= r90 || last >= r180) return false;
        return true;
      }

      // bottomRight
      if (y == 1) {
        if (first >= -r90 || first <= -r180) return false;
        if (last >= -r90 || last <= -r180) return false;
        return true;
      }

      if (first.abs() <= r90 || last.abs() <= r90) return false;
      return true;
    }

    // bottom
    const r180 = DoubleExtension.radian_angle180;
    if (y == 1) {
      if (first >= 0 || first <= -r180) return false;
      if (last >= 0 || last <= -r180) return false;
      return true;
    }

    // top
    assert(y == -1);
    if (first <= 0 || first >= r180) return false;
    if (last <= 0 || last >= r180) return false;
    return true;
  }

  static List<AlignmentBorder> fromRadians(
    AlignmentBorder alignment,
    List<double> radians,
  ) {
    throw UnimplementedError();
  }
}

///
///
/// todo: cutting
///
class MationaniCuttingAnchored extends StatelessWidget {
  const MationaniCuttingAnchored({
    super.key,
    this.alignment = AlignmentBorder.topLeft,
    this.ends = const [AlignmentBorder.bottomRight],
    this.curveFadeOut,
    this.curve,
    required this.ani,
    required this.rotation,
    required this.distance,
    required this.child,
  }) : pieces = ends.length + 1;

  MationaniCuttingAnchored.fromRadians({
    super.key,
    this.alignment = AlignmentBorder.topLeft,
    required List<double> radians,
    this.curveFadeOut,
    this.curve,
    required this.ani,
    required this.rotation,
    required this.distance,
    required this.child,
  })  : pieces = radians.length + 1,
        ends = AlignmentBorder.fromRadians(alignment, radians);

  final int pieces;
  final AlignmentBorder alignment;
  final List<AlignmentBorder> ends;
  final double rotation;
  final double distance;
  final Ani ani;
  final (Curve, Curve)? curveFadeOut;
  final (Curve, Curve)? curve;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final pieces = this.pieces,
        alignment = this.alignment,
        distance = this.distance,
        rotation = this.rotation;
    return Mationani.manion(
      ani: ani,
      manable: ManableSet.respectivelyAndParent(
        parent: MamableTransition.fadeOut(curve: curveFadeOut),
        children: List.generate(
          pieces,
          (index) => MamableSet([
            MamableTransition.rotate(
              FMatalue.between_double_0To(
                (index == 0 ? rotation : -rotation),
                curve: curve,
              ),
              alignment: alignment,
            ),
            MamableTransition.slide(
              FMatalue.offset_0To(
                index == 0
                    ? KGeometry.offset_bottomLeft * distance
                    : KGeometry.offset_topRight * distance,
                curve: curve,
              ),
            ),
          ]),
        ),
      ),
      parenting: FWidgetBuilder.parent_stack(),
      children: List.generate(
        pieces,
        (index) => ClipPath(
          clipper: Clipping.reclipNever(
            index == 0
                ? (size) => Path()
                  // ..moveTo(alignment.x, alignment.y)
                  ..lineToPoint(size.bottomRight(Offset.zero))
                  ..lineToPoint(size.bottomLeft(Offset.zero))
                : (size) => Path()
                  // ..moveTo(alignment.x, alignment.y)
                  ..lineToPoint(size.bottomRight(Offset.zero))
                  ..lineToPoint(size.topRight(Offset.zero)),
          ),
          child: child,
        ),
      ),
    );
  }
}
