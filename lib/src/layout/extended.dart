part of '../../datter.dart';

///
/// methods:
/// [lerperFrom]
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
/// [lerperFrom]
///
Lerper<T> lerperFrom<T>(T begin, T end) {
  try {
    return DoubleExtension.lerperFrom(begin, end);
  } on StateError catch (e) {
    if (e.message == FErrorMessage.lerperNoImplementation) {
      return switch (begin) {
        Size _ => (t) => Size.lerp(begin, end as Size, t)!,
        Rect _ => (t) => Rect.lerp(begin, end as Rect, t)!,
        Color _ => (t) => Color.lerp(begin, end as Color, t)!,
        EdgeInsets _ => (t) => EdgeInsets.lerp(begin, end as EdgeInsets?, t)!,
        RelativeRect _ => (t) =>
            RelativeRect.lerp(begin, end as RelativeRect?, t)!,
        AlignmentGeometry _ => (t) =>
            AlignmentGeometry.lerp(begin, end as AlignmentGeometry?, t)!,
        SizingPath _ => throw ArgumentError(
            'Use BetweenPath instead of Between<SizingPath>',
          ),
        Decoration _ => switch (begin) {
            BoxDecoration _ => end is BoxDecoration && begin.shape == end.shape
                ? (t) => BoxDecoration.lerp(begin, end, t)!
                : throw UnimplementedError(
                    'BoxShape should not be interpolated'),
            ShapeDecoration _ => switch (end) {
                ShapeDecoration _ => begin.shape == end.shape
                    ? (t) => ShapeDecoration.lerp(begin, end, t)!
                    : switch (begin.shape) {
                        CircleBorder _ || RoundedRectangleBorder _ => switch (
                              end.shape) {
                            CircleBorder _ || RoundedRectangleBorder _ => (t) =>
                                Decoration.lerp(begin, end, t)!,
                            _ => throw UnimplementedError(
                                "'$begin shouldn't be interpolated to $end'",
                              ),
                          },
                        _ => throw UnimplementedError(
                            "'$begin shouldn't be interpolated to $end'",
                          ),
                      },
                _ => throw UnimplementedError(),
              },
            _ => throw UnimplementedError(),
          },
        ShapeBorder _ => switch (begin) {
            BoxBorder _ => switch (end) {
                BoxBorder _ => (t) => BoxBorder.lerp(begin, end, t)!,
                _ => throw UnimplementedError(),
              },
            InputBorder _ => switch (end) {
                InputBorder _ => (t) => ShapeBorder.lerp(begin, end, t)!,
                _ => throw UnimplementedError(),
              },
            OutlinedBorder _ => switch (end) {
                OutlinedBorder _ => (t) => OutlinedBorder.lerp(begin, end, t)!,
                _ => throw UnimplementedError(),
              },
            _ => throw UnimplementedError(),
          },
        _ => Tween<T>(begin: begin, end: end).transform,
      } as Lerper<T>;
    }
    rethrow;
  }
}

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
    final step = Radian.angle_360 / n;
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
/// static methods: [fromDirection], ...
/// instance methods: [flipped], ...
///
extension AlignmentExtension on Alignment {
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

  Alignment get flipped => Alignment(-x, -y);

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