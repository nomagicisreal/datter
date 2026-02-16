part of '../../datter.dart';

///
///
/// [Painter], [PainterAdjust]
/// [Clipper], [ClipperAdjust]
///
/// [Curving]
/// [BiCurveExtension]
///
/// [PathExtension]
/// [DateTimeRangeExtension]
///
///

///
///
///
class Painter extends CustomPainter {
  final Path path;
  final Paint paintPaint;
  final PaintingPath paintingPath;

  @override
  void paint(Canvas canvas, Size size) {
    paintingPath(canvas, paintPaint, path);
  }

  @override
  bool shouldRepaint(Painter oldDelegate) =>
      oldDelegate.path != path &&
      oldDelegate.paint != paint &&
      oldDelegate.paintingPath != paintingPath;

  const Painter({
    this.paintingPath = FPaintingPath.draw,
    required this.path,
    required Paint paint,
  }) : paintPaint = paint;
}

class PainterAdjust extends CustomPainter {
  final SizingPath sizingPath;
  final PaintFrom paintFrom;
  final PaintingPath paintingPath;

  @override
  void paint(Canvas canvas, Size size) {
    final path = sizingPath(size);
    final paint = paintFrom(canvas, size);
    paintingPath(canvas, paint, path);
  }

  @override
  bool shouldRepaint(PainterAdjust oldDelegate) =>
      oldDelegate.sizingPath != sizingPath &&
      oldDelegate.paintFrom != paintFrom &&
      oldDelegate.paintingPath != paintingPath;

  const PainterAdjust({
    this.paintingPath = FPaintingPath.draw,
    required this.sizingPath,
    required this.paintFrom,
  });
}

///
///
///
class Clipper<T> extends CustomClipper<T> {
  final T frame;

  @override
  T getClip(Size size) => frame;

  @override
  bool shouldReclip(Clipper<T> oldClipper) => oldClipper.frame != frame;

  const Clipper(this.frame);
}

class ClipperAdjust<T> extends CustomClipper<T> {
  final T Function(Size) adjust;

  @override
  T getClip(Size size) => adjust(size);

  @override
  bool shouldReclip(ClipperAdjust<T> oldClipper) => oldClipper.adjust != adjust;

  const ClipperAdjust(this.adjust);
}

// class ClipperPath extends CustomClipper<Path> {
//   final Path path;
//
//   @override
//   Path getClip(Size size) => path;
//
//   @override
//   bool shouldReclip(ClipperPath oldClipper) => oldClipper.path != path;
//
//   const ClipperPath(this.path);
// }
//
// class ClipperRect extends CustomClipper<Rect> {
//   final Rect rect;
//
//   @override
//   Rect getClip(Size size) => rect;
//
//   @override
//   bool shouldReclip(ClipperRect oldClipper) => oldClipper.rect != rect;
//
//   const ClipperRect(this.rect);
// }
//
// class ClipperSizingPath extends CustomClipper<Path> {
//   final SizingPath sizingPath;
//
//   @override
//   Path getClip(Size size) => sizingPath(size);
//
//   @override
//   bool shouldReclip(ClipperSizingPath oldClipper) =>
//       oldClipper.sizingPath != sizingPath;
//
//   const ClipperSizingPath(this.sizingPath);
// }

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
  Curving.sinPeriodOf(double times)
      : mapping = DoubleExtension.applierPeriod(times, math.sin);

  Curving.cosPeriodOf(double times)
      : mapping = DoubleExtension.applierPeriod(times, math.cos);

  Curving.tanPeriodOf(double times)
      : mapping = DoubleExtension.applierPeriod(times, math.tan);

  @override
  double transformInternal(double t) => mapping(t);
}

///
/// [all], ...
/// [intervalOf], ...
/// [invert], ...
///
extension BiCurveExtension on (Curve, Curve) {
  ///
  /// [all].length == 43, see https://api.flutter.dev/flutter/animation/Curves-class.html?gclid=CjwKCAiA-bmsBhAGEiwAoaQNmg9ZfimSGJRAty3QNZ0AA32ztq51qPlJfFPBsFc5Iv1n-EgFQtULyxoC8q0QAvD_BwE&gclsrc=aw.ds
  ///
  static const List<(Curve, Curve)> all = [
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

  static const linear = (Curves.linear, Curves.linear);
  static const decelerate = (Curves.decelerate, Curves.decelerate);
  static const fastLinearToSlowEaseIn =
      (Curves.fastLinearToSlowEaseIn, Curves.fastLinearToSlowEaseIn);
  static const fastEaseInToSlowEaseOut =
      (Curves.fastEaseInToSlowEaseOut, Curves.fastEaseInToSlowEaseOut);
  static const ease = (Curves.ease, Curves.ease);
  static const easeInToLinear = (Curves.easeInToLinear, Curves.easeInToLinear);
  static const linearToEaseOut =
      (Curves.linearToEaseOut, Curves.linearToEaseOut);
  static const easeIn = (Curves.easeIn, Curves.easeIn);
  static const easeInSine = (Curves.easeInSine, Curves.easeInSine);
  static const easeInQuad = (Curves.easeInQuad, Curves.easeInQuad);
  static const easeInCubic = (Curves.easeInCubic, Curves.easeInCubic);
  static const easeInQuart = (Curves.easeInQuart, Curves.easeInQuart);
  static const easeInQuint = (Curves.easeInQuint, Curves.easeInQuint);
  static const easeInExpo = (Curves.easeInExpo, Curves.easeInExpo);
  static const easeInCirc = (Curves.easeInCirc, Curves.easeInCirc);
  static const easeInBack = (Curves.easeInBack, Curves.easeInBack);
  static const easeOut = (Curves.easeOut, Curves.easeOut);
  static const easeOutSine = (Curves.easeOutSine, Curves.easeOutSine);
  static const easeOutQuad = (Curves.easeOutQuad, Curves.easeOutQuad);
  static const easeOutCubic = (Curves.easeOutCubic, Curves.easeOutCubic);
  static const easeOutQuart = (Curves.easeOutQuart, Curves.easeOutQuart);
  static const easeOutQuint = (Curves.easeOutQuint, Curves.easeOutQuint);
  static const easeOutExpo = (Curves.easeOutExpo, Curves.easeOutExpo);
  static const easeOutCirc = (Curves.easeOutCirc, Curves.easeOutCirc);
  static const easeOutBack = (Curves.easeOutBack, Curves.easeOutBack);
  static const easeInOut = (Curves.easeInOut, Curves.easeInOut);
  static const easeInOutSine = (Curves.easeInOutSine, Curves.easeInOutSine);
  static const easeInOutQuad = (Curves.easeInOutQuad, Curves.easeInOutQuad);
  static const easeInOutCubic = (Curves.easeInOutCubic, Curves.easeInOutCubic);
  static const easeInOutCubicEmphasized =
      (Curves.easeInOutCubicEmphasized, Curves.easeInOutCubicEmphasized);
  static const easeInOutQuart = (Curves.easeInOutQuart, Curves.easeInOutQuart);
  static const easeInOutQuint = (Curves.easeInOutQuint, Curves.easeInOutQuint);
  static const easeInOutExpo = (Curves.easeInOutExpo, Curves.easeInOutExpo);
  static const easeInOutCirc = (Curves.easeInOutCirc, Curves.easeInOutCirc);
  static const easeInOutBack = (Curves.easeInOutBack, Curves.easeInOutBack);
  static const fastOutSlowIn = (Curves.fastOutSlowIn, Curves.fastOutSlowIn);
  static const slowMiddle = (Curves.slowMiddle, Curves.slowMiddle);
  static const bounceIn = (Curves.bounceIn, Curves.bounceIn);
  static const bounceOut = (Curves.bounceOut, Curves.bounceOut);
  static const bounceInOut = (Curves.bounceInOut, Curves.bounceInOut);
  static const elasticIn = (Curves.elasticIn, Curves.elasticIn);
  static const elasticOut = (Curves.elasticOut, Curves.elasticOut);
  static const elasticInOut = (Curves.elasticInOut, Curves.elasticInOut);

  ///
  ///
  /// [intervalOf], [intervalForwardOf], [intervalReverseOf]
  /// [flip], [flipIntervalOf]
  /// [flipIntervalForwardOf], [flipIntervalReverseOf]
  ///
  ///

  ///
  /// [intervalOf], [intervalForwardOf], [intervalReverseOf]
  ///
  static (Curve, Curve) intervalOf(Curve curve, double begin, double end) =>
      (curve.interval(begin, end), curve.interval(begin, end));

  static (Curve, Curve) intervalForwardOf(
          Curve curve, double begin, double end) =>
      (curve.interval(begin, end), curve);

  static (Curve, Curve) intervalReverseOf(
          Curve curve, double begin, double end) =>
      (curve, curve.interval(begin, end));

  ///
  /// [flip], [flipIntervalOf]
  /// [flipIntervalForwardOf], [flipIntervalReverseOf]
  ///
  static (Curve, Curve) flip(Curve curve) => (curve, curve.flipped);

  static (Curve, Curve) flipIntervalOf(Curve curve, double begin, double end) =>
      (curve.interval(begin, end), curve.interval(begin, end, true));

  static (Curve, Curve) flipIntervalForwardOf(
          Curve curve, double begin, double end) =>
      (curve.interval(begin, end), curve.flipped);

  static (Curve, Curve) flipIntervalReverseOf(
          Curve curve, double begin, double end) =>
      (curve, curve.interval(begin, end, true));

  ///
  /// [applyIntervalToEnd]
  ///
  static Applier<(Curve, Curve)> applyIntervalToEnd(double begin) =>
      (curve) => curve.interval(begin, 1.0);

  ///
  /// [invert], [interval]
  /// [intervalForward], [intervalReverse]
  ///
  (Curve, Curve) get invert => (this.$2, this.$1);

  (Curve, Curve) interval(
    double begin,
    double end, [
    bool flipForward = false,
    bool flipReverse = false,
  ]) =>
      (
        this.$1.interval(begin, end, flipForward),
        this.$2.interval(begin, end, flipReverse),
      );

  (Curve, Curve) intervalForward(double begin, double end,
          [bool flip = false]) =>
      (this.$1.interval(begin, end, flip), this.$2);

  (Curve, Curve) intervalReverse(double begin, double end,
          [bool flip = false]) =>
      (this.$1, this.$2.interval(begin, end, flip));
}

///
/// [moveToPoint], ...
/// [arcFromStartToEnd], ...
/// [quadraticBezierToPoint], ...
/// [addOvalFromCircle], ...
/// [addPolygonCubic], ...
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

  ///
  ///
  ///
  void addPolygonCubic(Iterable<CubicOffset> points) {
    final iterator = points.iterator;
    var path = Path();
    if (iterator.moveNext()) {
      final points = iterator.current;
      path = path
        ..moveToPoint(points.a)
        ..cubicToPoint(points.b, points.c, points.d);
    }
    while (iterator.moveNext()) {
      final points = iterator.current;
      path = path
        ..lineToPoint(points.a)
        ..cubicToPoint(points.b, points.c, points.d);
    }
  }
}

///
///
///
extension DateTimeRangeExtension on DateTimeRange {
  ///
  /// [weekAfter], [weeksFrom], [weeksIneMonthFrom]
  /// [scopeFrom], [scopeMonthsFrom]
  ///

  ///
  /// [weekAfter], [weeksFrom], [weeksIneMonthFrom]
  ///
  static DateTimeRange weekAfter(DateTime date) => DateTimeRange(
        start: date,
        end: date.add(DurationExtension.day1 * DateTime.daysPerWeek),
      );

  static DateTimeRange weeksFrom({
    DateTime? date,
    Duration beginPending = Duration.zero,
    int beginWeekday = DateTime.sunday,
    int count = 1,
  }) {
    final begin = (date ?? DateTime.now())
        .add(beginPending)
        .firstDateOfWeek(beginWeekday);
    return DateTimeRange(
      start: begin,
      end: begin.add(DurationExtension.day1 * DateTime.daysPerWeek * count),
    );
  }

  static DateTimeRange weeksIneMonthFrom(
    DateTime date, [
    int beginWeekday = DateTime.sunday,
  ]) =>
      DateTimeRange(
        start: date.firstDateOfMonth.firstDateOfWeek(beginWeekday),
        end: date.lastDateOfMonth.lastDateOfWeek(beginWeekday),
      );

  DateTimeRange get normalized =>
      DateTimeRange(start: start.normalized, end: end.normalized);

  ///
  /// [scopeFrom], [scopeMonthsFrom]
  ///
  static DateTimeRange scopeFrom(
    DateTime date, {
    int yearsBefore = 0,
    int monthsBefore = 0,
    int daysBefore = 0,
    int hoursBefore = 0,
    int minutesBefore = 0,
    int secondsBefore = 0,
    int yearsAfter = 0,
    int monthsAfter = 0,
    int daysAfter = 0,
    int hoursAfter = 0,
    int minutesAfter = 0,
    int secondsAfter = 0,
  }) {
    final year = date.year;
    final month = date.month;
    final day = date.day;
    final hour = date.hour;
    final minute = date.minute;
    final second = date.second;
    return DateTimeRange(
      start: DateTime(
        year - yearsBefore,
        month - monthsBefore,
        day - daysBefore,
        hour - hoursBefore,
        minute - minutesBefore,
        second - secondsBefore,
      ),
      end: DateTime(
        year + yearsAfter,
        month + monthsAfter,
        day + daysAfter,
        hour + hoursAfter,
        minute + minutesAfter,
        second + secondsAfter,
      ),
    );
  }

  static DateTimeRange scopeMonthsFrom(
    DateTime date, {
    int before = 0,
    int after = 0,
  }) {
    final year = date.year;
    final month = date.month;
    final day = date.day;
    return DateTimeRange(
      start: DateTime(year, month - before, day).firstDateOfMonth,
      end: DateTime(year, month + after, day).lastDateOfMonth,
    );
  }

  ///
  /// [contains], [toDates], [toWeeks]
  ///
  bool contains(DateTime dateTime, [bool exclusive = true]) {
    final start = this.start;
    final end = this.end;
    final inside = dateTime.isAfter(start) && dateTime.isBefore(end);
    if (exclusive) return inside;
    final year = dateTime.year;
    final month = dateTime.month;
    final day = dateTime.day;
    return (year == start.year && month == start.month && day == start.day) ||
        (year == end.year && month == end.month && day == end.day);
  }

  List<DateTime> get toDates => List.generate(
        duration.inDays + 1,
        (index) => DateTime(
          start.year,
          start.month,
          start.day + index,
        ),
      );

  DateTimeRange toWeeks([
    int beginWeekday = DateTime.sunday,
  ]) =>
      DateTimeRange(
        start: start.firstDateOfWeek(beginWeekday),
        end: end.lastDateOfWeek(beginWeekday),
      );
}
