part of '../../datter.dart';

///
///
/// [Painting], [Clipping]
///
/// [Curving], [CurveFR]
///
/// [PathExtension]
///
///

///
/// [_shouldRePaint], ...
/// [paint], ...
/// [Painting.rePaintWhenUpdate], ...
///
class Painting extends CustomPainter {
  final Fusionor<Painting, bool> _shouldRePaint;
  final SizingPath sizingPath;
  final PaintFrom paintFrom;
  final PaintingPath paintingPath;

  ///
  ///
  ///
  @override
  void paint(Canvas canvas, Size size) {
    final path = sizingPath(size);
    final paint = paintFrom(canvas, size);
    paintingPath(canvas, paint, path);
  }

  @override
  bool shouldRepaint(Painting oldDelegate) => _shouldRePaint(oldDelegate, this);

  static bool _rePaintWhenUpdate(Painting oldP, Painting p) => true;

  static bool _rePaintNever(Painting oldP, Painting p) => false;

  ///
  ///
  ///
  const Painting.rePaintWhenUpdate({
    required this.paintingPath,
    required this.sizingPath,
    required this.paintFrom,
  }) : _shouldRePaint = _rePaintWhenUpdate;

  const Painting.rePaintNever({
    required this.paintingPath,
    required this.paintFrom,
    required this.sizingPath,
  }) : _shouldRePaint = _rePaintNever;

  factory Painting.rRegularPolygon(
    PaintFrom paintFrom,
    RRegularPolygonCubicOnEdge polygon,
  ) =>
      Painting.rePaintNever(
        paintingPath: FPaintingPath.draw,
        paintFrom: paintFrom,
        sizingPath: FSizingPath.polygonCubic(polygon.cubicPoints),
      );
}

///
///
/// [sizingPath], ...
/// [Clipping.rectOf], ...
///
///
class Clipping extends CustomClipper<Path> {
  final SizingPath sizingPath;
  final Fusionor<Clipping, bool> _shouldReClip;

  @override
  Path getClip(Size size) => sizingPath(size);

  @override
  bool shouldReclip(Clipping oldClipper) => _shouldReClip(oldClipper, this);

  static bool _reclipWhenUpdate(Clipping oldC, Clipping c) => true;

  static bool _reclipNever(Clipping oldC, Clipping c) => false;

  const Clipping.reclipWhenUpdate(this.sizingPath)
      : _shouldReClip = _reclipWhenUpdate;

  const Clipping.reclipNever(this.sizingPath) : _shouldReClip = _reclipNever;

  ///
  ///
  ///
  factory Clipping.rectOf(Rect rect) =>
      Clipping.reclipNever(FSizingPath.rect(rect));

  factory Clipping.rectFromZeroTo(Size size) =>
      Clipping.rectOf(Offset.zero & size);

  factory Clipping.rectFromZeroToOffset(Offset corner) =>
      Clipping.rectOf(Rect.fromPoints(Offset.zero, corner));

  factory Clipping.rRegularPolygon(
    RRegularPolygonCubicOnEdge polygon, {
    Companion<CubicOffset, Size> adjust = CubicOffset.companionSizeAdjustCenter,
  }) =>
      Clipping.reclipNever(
        FSizingPath.polygonCubic(polygon.cubicPoints, adjust: adjust),
      );
}

///
/// [mapping]
/// [Curving.sinPeriodOf], ...
///
class Curving extends Curve {
  final Applier<double> mapping;

  const Curving(this.mapping);

  ///
  ///
  ///
  Curving.sinPeriodOf(int times)
      : mapping = DoubleExtension.applyOnPeriodSinByTimes(times);

  Curving.cosPeriodOf(int times)
      : mapping = DoubleExtension.applyOnPeriodCosByTimes(times);

  Curving.tanPeriodOf(int times)
      : mapping = DoubleExtension.applyOnPeriodTanByTimes(times);

  @override
  double transformInternal(double t) => mapping(t);
}

///
/// [forward], [reverse]
/// [interval], ...
/// [CurveFR.of], ...
/// [CurveFR.flip], ...
/// [CurveFR.fusionIntervalFlipIn]
/// [all], ...
///
class CurveFR {
  final Curve forward;
  final Curve reverse;

  const CurveFR(this.forward, this.reverse);

  ///
  ///
  ///
  CurveFR interval(
      double begin,
      double end, [
        bool flipForward = false,
        bool flipReverse = false,
      ]) =>
      CurveFR(
        forward.interval(begin, end, flipForward),
        reverse.interval(begin, end, flipReverse),
      );

  CurveFR intervalForward(double begin, double end, [bool flip = false]) =>
      CurveFR(forward.interval(begin, end, flip), reverse);

  CurveFR intervalReverse(double begin, double end, [bool flip = false]) =>
      CurveFR(forward, reverse.interval(begin, end, flip));

  CurveFR get invert => CurveFR(reverse, forward);


  ///
  ///
  ///
  const CurveFR.of(Curve curve)
      : forward = curve,
        reverse = curve;

  CurveFR.intervalOf(Curve curve, double begin, double end)
      : forward = curve.interval(begin, end),
        reverse = curve.interval(begin, end);

  CurveFR.intervalForwardOf(Curve curve, double begin, double end)
      : forward = curve.interval(begin, end),
        reverse = curve;

  CurveFR.intervalReverseOf(Curve curve, double begin, double end)
      : forward = curve,
        reverse = curve.interval(begin, end);

  ///
  ///
  ///
  CurveFR.flip(Curve curve)
      : forward = curve,
        reverse = curve.flipped;

  CurveFR.flipIntervalOf(Curve curve, double begin, double end)
      : forward = curve.interval(begin, end),
        reverse = curve.interval(begin, end, true);

  CurveFR.flipIntervalForwardOf(Curve curve, double begin, double end)
      : forward = curve.interval(begin, end),
        reverse = curve.flipped;

  CurveFR.flipIntervalReverseOf(Curve curve, double begin, double end)
      : forward = curve,
        reverse = curve.interval(begin, end, true);

  ///
  ///
  ///
  static Synthesizer<CurveFR, double, double, CurveFR> fusionIntervalFlipIn(
    int steps,
  ) =>
      (curve, begin, end) => curve.interval(begin / steps, end / steps);

  static Synthesizer<int, double, double, CurveFR>
      fusionIntervalFlipForSymmetryPeriodSinIn(
    int steps,
  ) =>
          (times, begin, end) =>
              CurveFR.of(Curving.sinPeriodOf(times)).interval(
                begin / steps,
                end / steps,
              );

  ///
  /// [all].length == 43, see https://api.flutter.dev/flutter/animation/Curves-class.html?gclid=CjwKCAiA-bmsBhAGEiwAoaQNmg9ZfimSGJRAty3QNZ0AA32ztq51qPlJfFPBsFc5Iv1n-EgFQtULyxoC8q0QAvD_BwE&gclsrc=aw.ds
  ///
  static const List<CurveFR> all = [
    linear,
    decelerate,
    fastLinearToSlowEaseIn,
    fastEaseInToSlowEaseOut,
    ease,
    easeInToLinear,
    linearToEaseOut,
    easeIn,
    easeInSine,
    easeInQuad,
    easeInCubic,
    easeInQuart,
    easeInQuint,
    easeInExpo,
    easeInCirc,
    easeInBack,
    easeOut,
    easeOutSine,
    easeOutQuad,
    easeOutCubic,
    easeOutQuart,
    easeOutQuint,
    easeOutExpo,
    easeOutCirc,
    easeOutBack,
    easeInOut,
    easeInOutSine,
    easeInOutQuad,
    easeInOutCubic,
    easeInOutCubicEmphasized,
    easeInOutQuart,
    easeInOutQuint,
    easeInOutExpo,
    easeInOutCirc,
    easeInOutBack,
    fastOutSlowIn,
    slowMiddle,
    bounceIn,
    bounceOut,
    bounceInOut,
    elasticIn,
    elasticOut,
    elasticInOut,
  ];

  static const linear = CurveFR.of(Curves.linear);
  static const decelerate = CurveFR.of(Curves.decelerate);
  static const fastLinearToSlowEaseIn =
      CurveFR.of(Curves.fastLinearToSlowEaseIn);
  static const fastEaseInToSlowEaseOut =
      CurveFR.of(Curves.fastEaseInToSlowEaseOut);
  static const ease = CurveFR.of(Curves.ease);
  static const easeInToLinear = CurveFR.of(Curves.easeInToLinear);
  static const linearToEaseOut = CurveFR.of(Curves.linearToEaseOut);
  static const easeIn = CurveFR.of(Curves.easeIn);
  static const easeInSine = CurveFR.of(Curves.easeInSine);
  static const easeInQuad = CurveFR.of(Curves.easeInQuad);
  static const easeInCubic = CurveFR.of(Curves.easeInCubic);
  static const easeInQuart = CurveFR.of(Curves.easeInQuart);
  static const easeInQuint = CurveFR.of(Curves.easeInQuint);
  static const easeInExpo = CurveFR.of(Curves.easeInExpo);
  static const easeInCirc = CurveFR.of(Curves.easeInCirc);
  static const easeInBack = CurveFR.of(Curves.easeInBack);
  static const easeOut = CurveFR.of(Curves.easeOut);
  static const easeOutSine = CurveFR.of(Curves.easeOutSine);
  static const easeOutQuad = CurveFR.of(Curves.easeOutQuad);
  static const easeOutCubic = CurveFR.of(Curves.easeOutCubic);
  static const easeOutQuart = CurveFR.of(Curves.easeOutQuart);
  static const easeOutQuint = CurveFR.of(Curves.easeOutQuint);
  static const easeOutExpo = CurveFR.of(Curves.easeOutExpo);
  static const easeOutCirc = CurveFR.of(Curves.easeOutCirc);
  static const easeOutBack = CurveFR.of(Curves.easeOutBack);
  static const easeInOut = CurveFR.of(Curves.easeInOut);
  static const easeInOutSine = CurveFR.of(Curves.easeInOutSine);
  static const easeInOutQuad = CurveFR.of(Curves.easeInOutQuad);
  static const easeInOutCubic = CurveFR.of(Curves.easeInOutCubic);
  static const easeInOutCubicEmphasized =
      CurveFR.of(Curves.easeInOutCubicEmphasized);
  static const easeInOutQuart = CurveFR.of(Curves.easeInOutQuart);
  static const easeInOutQuint = CurveFR.of(Curves.easeInOutQuint);
  static const easeInOutExpo = CurveFR.of(Curves.easeInOutExpo);
  static const easeInOutCirc = CurveFR.of(Curves.easeInOutCirc);
  static const easeInOutBack = CurveFR.of(Curves.easeInOutBack);
  static const fastOutSlowIn = CurveFR.of(Curves.fastOutSlowIn);
  static const slowMiddle = CurveFR.of(Curves.slowMiddle);
  static const bounceIn = CurveFR.of(Curves.bounceIn);
  static const bounceOut = CurveFR.of(Curves.bounceOut);
  static const bounceInOut = CurveFR.of(Curves.bounceInOut);
  static const elasticIn = CurveFR.of(Curves.elasticIn);
  static const elasticOut = CurveFR.of(Curves.elasticOut);
  static const elasticInOut = CurveFR.of(Curves.elasticInOut);
}

///
/// [moveToPoint], ...
/// [arcFromStartToEnd], ...
/// [quadraticBezierToPoint], ...
/// [addOvalFromCircle], ...
///
extension PathExtension on Path {
  ///
  ///
  ///
  void moveToPoint(Offset point) => moveTo(point.dx, point.dy);

  void moveOrLineToPoint(Offset point, bool shouldMove) =>
      shouldMove ? moveToPoint(point) : lineTo(point.dx, point.dy);

  void lineToPoint(Offset point) => lineTo(point.dx, point.dy);

  void lineFromAToB(Offset a, Offset b) => this
    ..moveToPoint(a)
    ..lineToPoint(b);

  void lineFromAToAll(Offset a, Iterable<Offset> points) => points.fold<Path>(
        this..moveToPoint(a),
        (path, point) => path..lineToPoint(point),
      );

  ///
  ///
  ///
  void arcFromStartToEnd(
    Offset arcStart,
    Offset arcEnd, {
    Radius radius = Radius.zero,
    bool clockwise = true,
    double rotation = 0.0,
    bool largeArc = false,
  }) =>
      this
        ..moveToPoint(arcStart)
        ..arcToPoint(
          arcEnd,
          radius: radius,
          clockwise: clockwise,
          rotation: rotation,
          largeArc: largeArc,
        );

  ///
  ///
  /// see https://www.youtube.com/watch?v=aVwxzDHniEw for explanation of cubic bezier
  ///
  ///
  void quadraticBezierToPoint(Offset controlPoint, Offset endPoint) =>
      quadraticBezierTo(
          controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

  void quadraticBezierToRelativePoint(Offset controlPoint, Offset endPoint) =>
      relativeQuadraticBezierTo(
          controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

  void cubicToPoint(
          Offset controlPoint1, Offset controlPoint2, Offset endPoint) =>
      cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
          controlPoint2.dy, endPoint.dx, endPoint.dy);

  void cubicToRelativePoint(
          Offset controlPoint1, Offset controlPoint2, Offset endPoint) =>
      relativeCubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
          controlPoint2.dy, endPoint.dx, endPoint.dy);

  void cubicOffset(CubicOffset offsets) => this
    ..moveToPoint(offsets.a)
    ..cubicToPoint(offsets.b, offsets.c, offsets.d);

  ///
  ///
  ///
  void addOvalFromCircle(Offset center, double radius) =>
      addOval(Rect.fromCircle(center: center, radius: radius));

  void addRectFromPoints(Offset a, Offset b) => addRect(Rect.fromPoints(a, b));

  void addRectFromCenter(Offset center, double width, double height) =>
      addRect(Rect.fromCenter(center: center, width: width, height: height));

  void addRectFromLTWH(double left, double top, double width, double height) =>
      addRect(Rect.fromLTWH(left, top, width, height));
}
