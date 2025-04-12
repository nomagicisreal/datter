///
///
/// this file contains:
///
/// [SizeExtension]
/// [OffsetExtension]
/// [RectExtension]
/// [AlignmentExtension]
///
///
part of '../../datter.dart';

extension KGeometry on Size {
  ///
  /// size
  ///
  static const Size size_square_1 = Size.square(1);
  static const Size size_w1_h2 = Size(1, 2);
  static const Size size_w2_h3 = Size(2, 3);
  static const Size size_w3_h4 = Size(3, 4);
  static const Size size_w9_h16 = Size(9, 16);
  static const Size size_a4 = Size(21.0, 29.7); // in cm
  static const Size size_a3 = Size(29.7, 42.0);
  static const Size size_a2 = Size(42.0, 59.4);
  static const Size size_a1 = Size(59.4, 84.1);

  ///
  /// offset
  ///
  static const Offset offset_square_1 = Offset(1, 1);
  static const Offset offset_x_1 = Offset(1, 0);
  static const Offset offset_y_1 = Offset(0, 1);
  static const Offset offset_top = Offset(0, -1);
  static const Offset offset_left = Offset(-1, 0);
  static const Offset offset_right = offset_x_1;
  static const Offset offset_bottom = offset_y_1;
  static const Offset offset_center = Offset.zero;
  static const Offset offset_topLeft = Offset(-math.sqrt1_2, -math.sqrt1_2);
  static const Offset offset_topRight = Offset(math.sqrt1_2, -math.sqrt1_2);
  static const Offset offset_bottomLeft = Offset(-math.sqrt1_2, math.sqrt1_2);
  static const Offset offset_bottomRight = Offset(math.sqrt1_2, math.sqrt1_2);

  ///
  /// edge insets
  ///
  static const EdgeInsets edgeInsets_leftBottom =
      EdgeInsets.only(left: 1, bottom: 1);
  static const EdgeInsets edgeInsets_left = EdgeInsets.only(left: 1);
  static const EdgeInsets edgeInsets_leftTop = EdgeInsets.only(left: 1, top: 1);
  static const EdgeInsets edgeInsets_top = EdgeInsets.only(top: 1);
  static const EdgeInsets edgeInsets_rightTop =
      EdgeInsets.only(right: 1, top: 1);
  static const EdgeInsets edgeInsets_right = EdgeInsets.only(right: 1);
  static const EdgeInsets edgeInsets_rightBottom =
      EdgeInsets.only(right: 1, bottom: 1);
  static const EdgeInsets edgeInsets_bottom = EdgeInsets.only(bottom: 1);
  static const EdgeInsets edgeInsets_horizontal =
      EdgeInsets.symmetric(horizontal: 1);
  static const EdgeInsets edgeInsets_vertical =
      EdgeInsets.symmetric(vertical: 1);
  static const EdgeInsets edgeInsets_all = EdgeInsets.all(1);

  ///
  /// radius
  ///
  static const Radius radius_circular_1 = Radius.circular(1);
  static const Radius radius_ellipse_x1_y2 = Radius.elliptical(1, 2);
  static const Radius radius_ellipse_x1_y3 = Radius.elliptical(1, 3);
  static const Radius radius_ellipse_x1_y4 = Radius.elliptical(1, 4);
  static const Radius radius_ellipse_x1_y5 = Radius.elliptical(1, 5);
  static const Radius radius_ellipse_x2_y3 = Radius.elliptical(2, 3);

  ///
  /// border radius
  ///
  static const BorderRadius borderRadius_zero = BorderRadius.all(Radius.zero);
  static const BorderRadius borderRadius_circularAll =
      BorderRadius.all(radius_circular_1);
  static const BorderRadius borderRadius_circularTopLeft =
      BorderRadius.only(topLeft: radius_circular_1);
  static const BorderRadius borderRadius_circularTopRight =
      BorderRadius.only(topRight: radius_circular_1);
  static const BorderRadius borderRadius_circularBottomLeft =
      BorderRadius.only(bottomLeft: radius_circular_1);
  static const BorderRadius borderRadius_circularBottomRight =
      BorderRadius.only(bottomRight: radius_circular_1);
  static const BorderRadius borderRadius_circularLeft =
      BorderRadius.horizontal(left: radius_circular_1);
  static const BorderRadius borderRadius_circularTop =
      BorderRadius.vertical(top: radius_circular_1);
  static const BorderRadius borderRadius_circularRight =
      BorderRadius.horizontal(right: radius_circular_1);
  static const BorderRadius borderRadius_circularBottom =
      BorderRadius.vertical(bottom: radius_circular_1);
}

///
/// static methods: [keep], ...
/// instance methods: [diagonal], ...
///
extension SizeExtension on Size {
  ///
  /// [keep]
  ///
  static Size keep(Size v) => v;

  ///
  ///
  ///
  double get diagonal => (width.squared + height.squared).squareRoot;

  ///
  /// [weightingWidth], [weightingHeight]
  /// [extrudingWidth], [extrudingHeight]
  ///
  Size weightingWidth(double scale) => Size(width * scale, height);

  Size weightingHeight(double scale) => Size(width, height * scale);

  Size extrudingWidth(double value) => Size(width + value, height);

  Size extrudingHeight(double value) => Size(width, height + value);
}

///
/// static methods: [keep], ...
/// instance methods: [fromPoint], ...
///
extension OffsetExtension on Offset {
  ///
  /// [keep]
  ///
  static Offset keep(Offset v) => v;

  ///
  /// [fromPoint]
  /// [unitFromDirection]
  ///
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
  /// static methods:
  ///
  ///

  ///
  /// [parallelUnitOf]
  /// [parallelVectorOf]
  /// [parallelOffsetOf]
  /// [parallelOffsetUnitOf]
  /// [parallelOffsetUnitOnCenterOf]
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
  /// [perpendicularUnitOf]
  /// [perpendicularVectorOf]
  /// [perpendicularOffsetOf]
  /// [perpendicularOffsetUnitOf]
  /// [perpendicularOffsetUnitFromCenterOf]
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
  /// instance methods
  ///
  ///
  ///

  ///
  /// [direct], [directionPerpendicular]
  /// [middleTo], [distanceHalfTo]
  ///
  Offset direct(double direction, [double distance = 1]) =>
      this + Offset.fromDirection(direction, distance);

  Offset middleTo(Offset p) => (p + this) / 2;

  double distanceHalfTo(Offset p) => (p - this).distance / 2;

  double directionPerpendicular({bool counterclockwise = true}) =>
      direction + Radian.angle_90 * (counterclockwise ? 1 : -1);

  ///
  /// [isAtBottomRightOf], [isAtTopLeftOf]
  /// [isAtBottomLeftOf], [isAtTopRightOf]
  ///
  bool isAtBottomRightOf(Offset offset) => this > offset;

  bool isAtTopLeftOf(Offset offset) => this < offset;

  bool isAtBottomLeftOf(Offset offset) => dx < offset.dx && dy > offset.dy;

  bool isAtTopRightOf(Offset offset) => dx > offset.dx && dy < offset.dy;

  ///
  /// [toSize], [toReciprocal]
  /// [toPerpendicularUnit], [toPerpendicular]
  ///
  Size get toSize => Size(dx, dy);

  Offset get toReciprocal => Offset(1 / dx, 1 / dy);

  Offset get toPerpendicularUnit =>
      Offset.fromDirection(directionPerpendicular());

  Offset get toPerpendicular =>
      Offset.fromDirection(directionPerpendicular(), distance);
}

///
/// static methods:
/// [fromZeroTo], ...
///
extension RectExtension on Rect {
  static Rect fromZeroTo(Size size) => Offset.zero & size;

  static Rect fromLTSize(double left, double top, Size size) =>
      Rect.fromLTWH(left, top, size.width, size.height);

  static Rect fromOffsetSize(Offset zero, Size size) =>
      Rect.fromLTWH(zero.dx, zero.dy, size.width, size.height);

  static Rect fromCenterSize(Offset center, Size size) =>
      Rect.fromCenter(center: center, width: size.width, height: size.height);

  static Rect fromCircle(Offset center, double radius) =>
      Rect.fromCircle(center: center, radius: radius);

  ///
  ///
  /// instance methods
  ///
  ///
  double get distanceDiagonal => size.diagonal;

  Offset offsetFromDirection(Direction direction) => switch (direction) {
        Direction2D() => () {
            final direction2DIn8 = switch (direction) {
              Direction2DIn4() => direction.toDirection8,
              Direction2DIn8() => direction,
            };
            return switch (direction2DIn8) {
              Direction2DIn8.top => topCenter,
              Direction2DIn8.left => centerLeft,
              Direction2DIn8.right => centerRight,
              Direction2DIn8.bottom => bottomCenter,
              Direction2DIn8.topLeft => topLeft,
              Direction2DIn8.topRight => topRight,
              Direction2DIn8.bottomLeft => bottomLeft,
              Direction2DIn8.bottomRight => bottomRight,
            };
          }(),
        Direction3D() => throw UnimplementedError(),
      };
}

///
///
///
/// alignment
///
///
///

///
/// [flipped]
/// [radianRangeForSide], [radianBoundaryForSide]
/// [radianRangeForSideStepOf]
/// [directionOfSideSpace]
///
/// [parseRect]
///
///
extension AlignmentExtension on Alignment {
  Alignment get flipped => Alignment(-x, -y);

  static Alignment fromDirection(Direction2D direction) => switch (direction) {
        Direction2DIn4() => fromDirection(direction.toDirection8),
        Direction2DIn8() => switch (direction) {
            Direction2DIn8.top => Alignment.topCenter,
            Direction2DIn8.left => Alignment.centerLeft,
            Direction2DIn8.right => Alignment.centerRight,
            Direction2DIn8.bottom => Alignment.bottomCenter,
            Direction2DIn8.topLeft => Alignment.topLeft,
            Direction2DIn8.topRight => Alignment.topRight,
            Direction2DIn8.bottomLeft => Alignment.bottomLeft,
            Direction2DIn8.bottomRight => Alignment.bottomRight,
          }
      };

  double get radianRangeForSide {
    final boundary = radianBoundaryForSide;
    return boundary.$2 - boundary.$1;
  }

  (double, double) get radianBoundaryForSide => switch (this) {
        Alignment.center => (0, Radian.angle_360),
        Alignment.centerLeft => (-Radian.angle_90, Radian.angle_90),
        Alignment.centerRight => (Radian.angle_90, Radian.angle_270),
        Alignment.topCenter => (0, Radian.angle_180),
        Alignment.topLeft => (0, Radian.angle_90),
        Alignment.topRight => (Radian.angle_90, Radian.angle_180),
        Alignment.bottomCenter => (Radian.angle_180, Radian.angle_360),
        Alignment.bottomLeft => (Radian.angle_270, Radian.angle_360),
        Alignment.bottomRight => (Radian.angle_180, Radian.angle_270),
        _ => throw UnimplementedError(),
      };

  double radianRangeForSideStepOf(int count) =>
      radianRangeForSide / (this == Alignment.center ? count : count - 1);

  Generator<double> directionOfSideSpace(bool isClockwise, int count) {
    final boundary = radianBoundaryForSide;
    final origin = isClockwise ? boundary.$1 : boundary.$2;
    final step = radianRangeForSideStepOf(count);

    return isClockwise
        ? (index) => origin + step * index
        : (index) => origin - step * index;
  }

  Offset parseRect(Rect rect) => switch (this) {
        Alignment.topLeft => rect.topLeft,
        Alignment.topCenter => rect.topCenter,
        Alignment.topRight => rect.topRight,
        Alignment.centerLeft => rect.centerLeft,
        Alignment.center => rect.center,
        Alignment.centerRight => rect.centerRight,
        Alignment.bottomLeft => rect.bottomLeft,
        Alignment.bottomCenter => rect.bottomCenter,
        Alignment.bottomRight => rect.bottomRight,
        _ => throw UnimplementedError(),
      };
}
