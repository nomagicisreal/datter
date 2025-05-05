part of '../../datter.dart';

///
/// classes:
/// [CubicOffset]
/// [RRegularPolygonCubicOnEdge]
///
/// extensions:
/// [SizeExtension]
/// [OffsetExtension]
///
/// [CurveExtension]
/// [CubicExtension]
///
/// [RectExtension]
/// [AlignmentExtension]
///
/// [RenderBoxExtension]
/// [PositionedExtension]
///
///

///
/// [x], ...
/// [a], ...
/// [mapX], ...
///
/// static methods:
/// [CubicOffset.companionSizeAdjustCenter], ...
/// [CubicOffset.map_p0231], ...
///
///
class CubicOffset {
  final Cubic x;
  final Cubic y;

  const CubicOffset(this.x, this.y);

  CubicOffset.fromPoints(List<Offset> offsets)
      : assert(offsets.length == 4),
        x = Cubic(offsets[0].dx, offsets[1].dx, offsets[2].dx, offsets[3].dx),
        y = Cubic(offsets[0].dy, offsets[1].dy, offsets[2].dy, offsets[3].dy);

  ///
  ///
  ///
  Offset get a => Offset(x.a, y.a);

  Offset get b => Offset(x.b, y.b);

  Offset get c => Offset(x.c, y.c);

  Offset get d => Offset(x.d, y.d);

  List<Offset> get points =>
      [Offset(x.a, y.a), Offset(x.b, y.b), Offset(x.c, y.c), Offset(x.d, y.d)];

  ///
  ///
  ///
  CubicOffset mapX(Applier<Cubic> mapping) => CubicOffset(mapping(x), y);

  CubicOffset mapY(Applier<Cubic> mapping) => CubicOffset(x, mapping(y));

  CubicOffset mapXY(Applier<Cubic> mapping) =>
      CubicOffset(mapping(x), mapping(y));

  Offset operator [](int index) => switch (index) {
        0 => Offset(x.a, y.a),
        1 => Offset(x.b, y.b),
        2 => Offset(x.c, y.c),
        3 => Offset(x.d, y.d),
        _ => throw UnimplementedError(index.toString()),
      };

  CubicOffset operator *(double scale) => CubicOffset(
        Cubic(x.a * scale, x.b * scale, x.c * scale, x.d * scale),
        Cubic(y.a * scale, y.b * scale, y.c * scale, y.d * scale),
      );

  ///
  ///
  ///
  static CubicOffset companionSizeAdjustCenter(
    CubicOffset cubicOffset,
    Size size,
  ) =>
      CubicOffset.fromPoints(
        cubicOffset.points.adjustCenterFor(size).toList(),
      );

  ///
  ///
  ///
  static Map<Offset, List<Offset>> map_p0231(
          Map<Offset, List<Offset>> points) =>
      points.map(
        (points, cubicPoints) => MapEntry(
          points,
          KOffsetPermutation4.p0231(cubicPoints),
        ),
      );

  static Map<Offset, List<Offset>> map_p1230(
          Map<Offset, List<Offset>> points) =>
      points.map(
        (points, cubicPoints) => MapEntry(
          points,
          KOffsetPermutation4.p1230(cubicPoints),
        ),
      );

  static Applier<Map<Offset, List<Offset>>> apply_map(
    Applier<List<Offset>> mapping,
  ) =>
      (points) => points
          .map((points, cubicPoints) => MapEntry(points, mapping(cubicPoints)));
}

///
/// [n], ...
///
/// static methods:
/// [cornersOf], ...
/// [corners], ... (getters)
///
/// See Also:
///   * [FSizingPath.polygonCubic], [FSizingPath.polygonCubicFromSize]
///
///
class RRegularPolygonCubicOnEdge extends RegularPolygon
    with RegularPolygonRadiusSingle {
  @override
  final int n;
  @override
  final double radiusCircumscribedCircle;
  @override
  final double cornerRadius;

  final double timesForEdge;
  final Applier<Map<Offset, CubicOffset>> cubicPointsMapper;
  final Companion<CubicOffset, Size> cornerAdjust;

  ///
  ///
  ///
  const RRegularPolygonCubicOnEdge(
    this.n, {
    this.timesForEdge = 0,
    this.cornerRadius = 0,
    this.cubicPointsMapper = _cubicPointsMapper,
    this.cornerAdjust = CubicOffset.companionSizeAdjustCenter,
    required this.radiusCircumscribedCircle,
  });

  RRegularPolygonCubicOnEdge.from(
    RRegularPolygonCubicOnEdge polygon, {
    double timesForEdge = 0,
    Mapper<RRegularPolygonCubicOnEdge, double>? cornerRadius,
    Applier<Map<Offset, CubicOffset>> cubicPointsMapper = _cubicPointsMapper,
    Companion<CubicOffset, Size> cornerAdjust =
        CubicOffset.companionSizeAdjustCenter,
  }) : this(
          polygon.n,
          timesForEdge: timesForEdge,
          cornerRadius: cornerRadius?.call(polygon) ?? 0,
          cubicPointsMapper: cubicPointsMapper,
          cornerAdjust: cornerAdjust,
          radiusCircumscribedCircle: polygon.radiusCircumscribedCircle,
        );

  ///
  ///
  ///
  static List<Offset> cornersOf(
    int n,
    double radiusCircumscribedCircle, {
    Size? size,
  }) {
    final step = DoubleExtension.radian_angle360 / n;
    final center = size?.center(Offset.zero) ?? Offset.zero;
    return List.generate(
      n,
      (i) => center + Offset.fromDirection(step * i, radiusCircumscribedCircle),
      growable: false,
    );
  }

  // [cornerPrevious, controlPointA, controlPointB, cornerNext]
  static Map<Offset, CubicOffset> _cubicPointsMapper(
    Map<Offset, CubicOffset> points,
  ) =>
      points.mapValues((value) => value.mapXY(CubicExtension.keep_0231));

  ///
  ///
  ///
  /// getters
  ///
  ///
  ///

  @override
  List<Offset> get corners => cornersOf(n, radiusCircumscribedCircle);

  ///
  /// [cubicPoints]
  /// [cubicPointsFrom]
  ///
  Iterable<CubicOffset> get cubicPoints =>
      cubicPointsMapper(corners.cubicPoints(
        RegularPolygonRadiusSingle.tangentFrom(cornerRadius, n),
        timesForEdge,
      )).values;

  Iterable<CubicOffset> cubicPointsFrom(
    double cornerRadius,
    double timesEdge,
  ) =>
      cubicPointsMapper(corners.cubicPoints(
        RegularPolygonRadiusSingle.tangentFrom(cornerRadius, n),
        timesEdge,
      )).values;

  static List<double> get stepsOfEdgeTimes => [
        double.negativeInfinity,
        0,
        1,
        double.infinity,
      ];
}

///
/// static methods: [fromZeroTo], ...
/// instance methods: [distanceDiagonal], ...
///
extension RectExtension on Rect {
  ///
  ///
  ///
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
  ///
  double get distanceDiagonal => size.diagonal;

  Offset offsetFromDirection(DirectionIn8 direction) => switch (direction) {
        DirectionIn8.top => topCenter,
        DirectionIn8.left => centerLeft,
        DirectionIn8.right => centerRight,
        DirectionIn8.bottom => bottomCenter,
        DirectionIn8.topLeft => topLeft,
        DirectionIn8.topRight => topRight,
        DirectionIn8.bottomLeft => bottomLeft,
        DirectionIn8.bottomRight => bottomRight,
      };
}

///
/// static methods: [fromDirection], ...
/// instance methods: [flipped], ...
///
extension AlignmentExtension on Alignment {
  static Alignment fromDirection(DirectionIn8 direction) => switch (direction) {
        DirectionIn8.top => Alignment.topCenter,
        DirectionIn8.left => Alignment.centerLeft,
        DirectionIn8.right => Alignment.centerRight,
        DirectionIn8.bottom => Alignment.bottomCenter,
        DirectionIn8.topLeft => Alignment.topLeft,
        DirectionIn8.topRight => Alignment.topRight,
        DirectionIn8.bottomLeft => Alignment.bottomLeft,
        DirectionIn8.bottomRight => Alignment.bottomRight,
      };

  Alignment get flipped => Alignment(-x, -y);

  double get radianRangeForSide {
    final boundary = radianBoundaryForSide;
    return boundary.$2 - boundary.$1;
  }

  (double, double) get radianBoundaryForSide => switch (this) {
        Alignment.center => (0, DoubleExtension.radian_angle360),
        Alignment.centerLeft => (
            -DoubleExtension.radian_angle90,
            DoubleExtension.radian_angle90
          ),
        Alignment.centerRight => (
            DoubleExtension.radian_angle90,
            DoubleExtension.radian_angle270
          ),
        Alignment.topCenter => (0, DoubleExtension.radian_angle180),
        Alignment.topLeft => (0, DoubleExtension.radian_angle90),
        Alignment.topRight => (
            DoubleExtension.radian_angle90,
            DoubleExtension.radian_angle180
          ),
        Alignment.bottomCenter => (
            DoubleExtension.radian_angle180,
            DoubleExtension.radian_angle360
          ),
        Alignment.bottomLeft => (
            DoubleExtension.radian_angle270,
            DoubleExtension.radian_angle360
          ),
        Alignment.bottomRight => (
            DoubleExtension.radian_angle180,
            DoubleExtension.radian_angle270
          ),
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

///
///
///
extension RenderBoxExtension on RenderBox {
  Rect get fromLocalToGlobalRect =>
      RectExtension.fromOffsetSize(localToGlobal(Offset.zero), size);
}

///
///
///
extension PositionedExtension on Positioned {
  Rect? get rect =>
      (left == null || top == null || width == null || height == null)
          ? null
          : Rect.fromLTWH(left!, top!, width!, height!);
}
