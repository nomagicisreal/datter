part of '../../datter.dart';

///
///
/// [IterableOffsetExtension]
/// [ListOffsetExtension]
///
/// [GeneratorOffsetExtension]
///
///

///
/// static methods: [keep], ...
/// instance methods: [diagonal], ...
///
extension SizeExtension on Size {
  ///
  ///
  ///
  static Size keep(Size v) => v;

  ///
  ///
  ///
  double get diagonal => (width.squared + height.squared).squareRoot;

  Size weightingWidth(double scale) => Size(width * scale, height);

  Size weightingHeight(double scale) => Size(width, height * scale);

  Size extrudingWidth(double value) => Size(width + value, height);

  Size extrudingHeight(double value) => Size(width, height + value);
}

///
/// static methods:
/// [keep], ...
/// [parallelUnitOf], ...
/// [perpendicularUnitOf], ...
///
/// instance methods:
/// [direct], ...
/// [isAtBottomRightOf], ...
/// [toSize], ...
///
extension OffsetExtension on Offset {
  ///
  ///
  ///
  static Offset keep(Offset v) => v;

  static Offset fromPoint(Point point) => switch (point) {
        Point2() => Offset(point.x, point.y),
        Point3() => throw UnimplementedError(),
      };

  static Offset unitFromDirection(Direction direction) => switch (direction) {
        Direction2D() => fromPoint(Point2.unitFromDirection(direction)),
        Direction3D() => throw UnimplementedError(),
      };

  ///
  ///
  ///
  static Offset parallelUnitOf(Offset a, Offset b) {
    final offset = b - a;
    return offset / offset.distance;
  }

  static Offset parallelVectorOf(Offset a, Offset b, double t) => (b - a) * t;

  static Offset parallelOffsetOf(Offset a, Offset b, double t) =>
      a + parallelVectorOf(a, b, t);

  static Offset parallelOffsetUnitOf(Offset a, Offset b, double t) =>
      a + parallelUnitOf(a, b) * t;

  static Offset parallelOffsetUnitOnCenterOf(Offset a, Offset b, double t) =>
      a.middleTo(b) + parallelUnitOf(a, b) * t;

  ///
  ///
  ///
  static Offset perpendicularUnitOf(Offset a, Offset b) =>
      (b - a).toPerpendicularUnit;

  static Offset perpendicularVectorOf(Offset a, Offset b, double t) =>
      (b - a).toPerpendicular * t;

  static Offset perpendicularOffsetOf(Offset a, Offset b, double t) =>
      a + perpendicularVectorOf(a, b, t);

  static Offset perpendicularOffsetUnitOf(Offset a, Offset b, double t) =>
      a + perpendicularUnitOf(a, b) * t;

  static Offset perpendicularOffsetUnitFromCenterOf(
    Offset a,
    Offset b,
    double t,
  ) =>
      a.middleTo(b) + perpendicularUnitOf(a, b) * t;

  ///
  ///
  ///
  Offset direct(double direction, [double distance = 1]) =>
      this + Offset.fromDirection(direction, distance);

  Offset middleTo(Offset p) => (p + this) / 2;

  double distanceHalfTo(Offset p) => (p - this).distance / 2;

  double directionPerpendicular({bool counterclockwise = true}) =>
      direction + Radian.angle_90 * (counterclockwise ? 1 : -1);

  ///
  ///
  ///
  bool isAtBottomRightOf(Offset offset) => this > offset;

  bool isAtTopLeftOf(Offset offset) => this < offset;

  bool isAtBottomLeftOf(Offset offset) => dx < offset.dx && dy > offset.dy;

  bool isAtTopRightOf(Offset offset) => dx > offset.dx && dy < offset.dy;

  ///
  ///
  ///
  Size get toSize => Size(dx, dy);

  Offset get toReciprocal => Offset(1 / dx, 1 / dy);

  Offset get toPerpendicularUnit =>
      Offset.fromDirection(directionPerpendicular());

  Offset get toPerpendicular =>
      Offset.fromDirection(directionPerpendicular(), distance);
}

///
/// static methods: [keep], ...
/// instance methods: [interval], ...
///
extension CurveExtension on Curve {
  ///
  ///
  ///
  static Curve keep(Curve v) => v;

  static Curve keepFlipped(Curve v) => v.flipped;

  ///
  ///
  ///
  Interval interval(double begin, double end, [bool shouldFlip = false]) =>
      Interval(begin, end, curve: shouldFlip ? flipped : this);
}

///
/// [keep_0231], ...
///
extension CubicExtension on Cubic {
  static Cubic keep_0231(Cubic cubic) =>
      Cubic(cubic.a, cubic.c, cubic.d, cubic.b);

  static Cubic keep_1230(Cubic cubic) =>
      Cubic(cubic.b, cubic.c, cubic.d, cubic.a);
}

///
/// static methods:
/// [keep], ...
/// [applyScaling], ...
/// [generatorWithValue], ...
///
/// instance methods:
/// [scaling], ...
///
///
extension IterableOffsetExtension on Iterable<Offset> {
  ///
  ///
  ///
  static Iterable<Offset> keep(Iterable<Offset> v) => v;

  ///
  ///
  ///
  static Applier<Iterable<Offset>> applyScaling(double scale) =>
      scale == 1 ? keep : (points) => points.scaling(scale);

  static Iterable<Offset> companionAdjustCenter(
    Iterable<Offset> points,
    Size size,
  ) =>
      points.adjustCenterFor(size);

  static Generator<Radius> fillRadiusCircular(double radius) =>
      (_) => Radius.circular(radius);

  ///
  /// generator
  ///
  static Generator<Offset> generatorWithValue(
    double value,
    MapperGenerator<double, Offset> generator,
  ) =>
      (i) => generator(value, i);

  static Generator<Offset> generatorLeftRightLeftRight(
    double dX,
    double dY, {
    required Offset topLeft,
    required Offset Function(int line, double dX, double dY) left,
    required Offset Function(int line, double dX, double dY) right,
  }) =>
      (i) {
        final indexLine = i ~/ 2;
        return topLeft +
            (i % 2 == 0 ? left(indexLine, dX, dY) : right(indexLine, dX, dY));
      };

  static Generator<Offset> generatorGrouping2({
    required double dX,
    required double dY,
    required int modulusX,
    required int modulusY,
    required double constantX,
    required double constantY,
    required double group2ConstantX,
    required double group2ConstantY,
    required int group2ThresholdX,
    required int group2ThresholdY,
  }) =>
      (index) => Offset(
            constantX +
                (index % modulusX) * dX +
                (index > group2ThresholdX ? group2ConstantX : 0),
            constantY +
                (index % modulusY) * dY +
                (index > group2ThresholdY ? group2ConstantY : 0),
          );

  static Generator<Offset> generatorTopBottomStyle1(double group2ConstantY) =>
      generatorGrouping2(
        dX: 78,
        dY: 12,
        modulusX: 6,
        modulusY: 24,
        constantX: -25,
        constantY: -60,
        group2ConstantX: 0,
        group2ConstantY: group2ConstantY,
        group2ThresholdX: 0,
        group2ThresholdY: 11,
      );

  ///
  ///
  ///
  Iterable<Offset> scaling(double value) => map((o) => o * value);

  Iterable<Offset> adjustCenterFor(Size size, {Offset origin = Offset.zero}) {
    final center = size.center(origin);
    return map((p) => p + center);
  }
}

///
///
///
/// [ListOffsetExtension]
///
///
///

extension ListOffsetExtension on List<Offset> {
  ///
  /// [symmetryInsert]
  ///
  List<Offset> symmetryInsert(
    double dPerpendicular,
    double dParallel,
  ) {
    final length = this.length;
    assert(length % 2 == 0);
    final insertionIndex = length ~/ 2;

    final begin = this[insertionIndex - 1];
    final end = this[insertionIndex];

    final unitParallel = OffsetExtension.parallelUnitOf(begin, end);
    final point =
        begin.middleTo(end) + unitParallel.toPerpendicular * dPerpendicular;

    return this
      ..insertAll(insertionIndex, [
        point - unitParallel * dParallel,
        point + unitParallel * dParallel,
      ]);
  }

  ///
  /// [cubicPoints]
  ///
  Map<Offset, CubicOffset> cubicPoints(double timesEdgeUnit, double timesEdge) {
    final n = length;
    return asMap().map((i, current) {
      // offset from current corner to previous corner
      final previous = OffsetExtension.parallelOffsetUnitOf(
        current,
        i == 0 ? last : this[i - 1],
        timesEdgeUnit,
      );

      // offset from current corner to next corner
      final next = OffsetExtension.parallelOffsetUnitOf(
        current,
        i == n - 1 ? first : this[i + 1],
        timesEdgeUnit,
      );
      return MapEntry(
        current,
        CubicOffset.fromPoints([
          previous,
          next,
          OffsetExtension.parallelOffsetOf(previous, current, timesEdge),
          OffsetExtension.parallelOffsetOf(current, next, timesEdge),
        ]),
      );
    });
  }
}

///
///
///
extension GeneratorOffsetExtension on Generator<Offset> {
  List<Widget> yieldingPositionedTranslated(
    int length, {
    required Applier<Offset> translation,
    required Widget child,
    FilterQuality? filterQuality,
    bool transformHitTests = true,
  }) =>
      yieldingMapToList(
        length,
        (position) => Positioned(
          left: position.dx,
          top: position.dy,
          child: Transform.translate(
            offset: translation(position),
            transformHitTests: transformHitTests,
            filterQuality: filterQuality,
            child: child,
          ),
        ),
      );
}
