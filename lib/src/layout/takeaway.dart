part of '../../datter.dart';

///
/// [FPaintingPath]
/// [FRectBuilder]
/// [FExtruding2D]
///

extension FPaintingPath on PaintingPath {
  static void draw(Canvas canvas, Paint paint, Path path) =>
      canvas.drawPath(path, paint);
}

///
///
///
extension FRectBuilder on RectFromContext {
  static RectFromContext get zero => (context) => Rect.zero;

  ///
  /// rect
  ///
  static RectFromContext get rectZeroToFull =>
      (context) => Offset.zero & context.sizeMedia;

  static RectFromContext rectZeroToSize(Sizing sizing) =>
      (context) => Offset.zero & sizing(context.sizeMedia);

  static RectFromContext rectOffsetToSize(
    SizingOffset positioning,
    Sizing sizing,
  ) =>
      (context) {
        final size = context.sizeMedia;
        return positioning(size) & sizing(size);
      };

  ///
  /// circle
  ///
  static RectFromContext get circleZeroToFull => (context) =>
      RectExtension.fromCircle(Offset.zero, context.sizeMedia.diagonal);

  static RectFromContext circleZeroToRadius(SizingDouble sizing) =>
      (context) => RectExtension.fromCircle(
            Offset.zero,
            sizing(context.sizeMedia),
          );

  static RectFromContext circleOffsetToSize(
    SizingOffset positioning,
    SizingDouble sizing,
  ) =>
      (context) {
        final size = context.sizeMedia;
        return RectExtension.fromCircle(positioning(size), sizing(size));
      };

  ///
  /// oval
  ///
  static RectFromContext get ovalZeroToFull =>
      (context) => RectExtension.fromCenterSize(Offset.zero, context.sizeMedia);

  static RectFromContext ovalZeroToSize(Sizing sizing) =>
      (context) => RectExtension.fromCenterSize(
            Offset.zero,
            sizing(context.sizeMedia),
          );

  static RectFromContext ovalOffsetToSize(
    SizingOffset positioning,
    Sizing sizing,
  ) =>
      (context) {
        final size = context.sizeMedia;
        return RectExtension.fromCenterSize(positioning(size), sizing(size));
      };
}

///
/// static methods:
/// [directOnSize], [directOnWidth], [directByDimension]
/// [fromRectDirection]
///
/// instance methods:
/// [translateOnSize], [translateOnWidth], [translateOfDimension]
///
///
extension FExtruding2D on Extruding2D {
  static Mapper<double, Rect> directOnSize({
    required Rect rect,
    required DirectionIn8 direction,
    required double width,
    required double height,
    bool timesOrPlus = true,
  }) =>
      fromRectDirection(rect, direction).translateOnSize(
        width,
        height,
        timesOrPlus: timesOrPlus,
      );

  static Mapper<double, Rect> directOnWidth({
    required Rect rect,
    required DirectionIn8 direction,
    required double width,
  }) =>
      fromRectDirection(rect, direction).translateOnWidth(width);

  static Mapper<double, Rect> directByDimension({
    required Rect rect,
    required DirectionIn8 direction,
    required double dimension,
    bool timesOrPlus = true,
  }) =>
      fromRectDirection(rect, direction).translateOfDimension(
        dimension,
        timesOrPlus: timesOrPlus,
      );

  static Extruding2D fromRectDirection(Rect rect, DirectionIn8 direction) =>
      switch (direction) {
        DirectionIn8.top => () {
            final origin = rect.topCenter;
            return (width, length) => Rect.fromPoints(
                  origin + Offset(width / 2, 0),
                  origin + Offset(-width / 2, -length),
                );
          }(),
        DirectionIn8.left => () {
            final origin = rect.centerLeft;
            return (width, length) => Rect.fromPoints(
                  origin + Offset(0, width / 2),
                  origin + Offset(-length, -width / 2),
                );
          }(),
        DirectionIn8.right => () {
            final origin = rect.centerRight;
            return (width, length) => Rect.fromPoints(
                  origin + Offset(0, width / 2),
                  origin + Offset(length, -width / 2),
                );
          }(),
        DirectionIn8.bottom => () {
            final origin = rect.bottomCenter;
            return (width, length) => Rect.fromPoints(
                  origin + Offset(width / 2, 0),
                  origin + Offset(-width / 2, length),
                );
          }(),
        DirectionIn8.topLeft => () {
            final origin = rect.topLeft;
            return (width, length) => Rect.fromPoints(
                  origin,
                  origin + Offset(-length, -length) * DoubleExtension.sqrt1_2,
                );
          }(),
        DirectionIn8.topRight => () {
            final origin = rect.topRight;
            return (width, length) => Rect.fromPoints(
                  origin,
                  origin + Offset(length, -length) * DoubleExtension.sqrt1_2,
                );
          }(),
        DirectionIn8.bottomLeft => () {
            final origin = rect.bottomLeft;
            return (width, length) => Rect.fromPoints(
                  origin,
                  origin + Offset(-length, length) * DoubleExtension.sqrt1_2,
                );
          }(),
        DirectionIn8.bottomRight => () {
            final origin = rect.bottomRight;
            return (width, length) => Rect.fromPoints(
                  origin,
                  origin + Offset(length, length) * DoubleExtension.sqrt1_2,
                );
          }(),
      };

  ///
  /// when [timesOrPlus] == true, its means that extruding value will be multiplied on [height]
  /// when [timesOrPlus] == false, its means that extruding value will be added on [height]
  ///
  Mapper<double, Rect> translateOnSize(
    double width,
    double height, {
    bool timesOrPlus = true,
  }) {
    final calculating = timesOrPlus ? (v) => height * v : (v) => height + v;
    return (value) => this(width, calculating(value));
  }

  Mapper<double, Rect> translateOnWidth(double width) =>
      translateOnSize(width, 0, timesOrPlus: false);

  Mapper<double, Rect> translateOfDimension(
    double dimension, {
    bool timesOrPlus = true,
  }) =>
      translateOnSize(dimension, dimension, timesOrPlus: timesOrPlus);
}
