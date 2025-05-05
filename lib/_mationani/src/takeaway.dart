part of '../_mationani.dart';

///
///
/// * [FMatalue]
/// * [FMatable]
///
///

///
/// [between_double_0From], ...
/// [between_offset_0From], ...
/// [between_point3_0From], ...
///
/// [amplitude_double_0From], ...
/// [amplitude_offset_0From], ...
/// [amplitude_point3_0From], ...
/// [amplitude_radian3_0From], ...
///
abstract final class FMatalue {
  ///
  ///
  ///
  static Between<double> between_double_0From(double begin, {CurveFR? curve}) =>
      Between(begin: begin, end: 0, curve: curve);

  static Between<double> between_double_0To(double end, {CurveFR? curve}) =>
      Between(begin: 0, end: end, curve: curve);

  static Between<double> between_double_1From(double begin, {CurveFR? curve}) =>
      Between(begin: begin, end: 1, curve: curve);

  static Between<double> between_double_1To(double end, {CurveFR? curve}) =>
      Between(begin: 1, end: end, curve: curve);

  ///
  ///
  ///
  static Between<Offset> between_offset_0From(Offset begin, {CurveFR? curve}) =>
      Between(begin: begin, end: Offset.zero, curve: curve);

  static Between<Offset> offset_0To(Offset end, {CurveFR? curve}) =>
      Between(begin: Offset.zero, end: end, curve: curve);

  static Between<Offset> between_offset_ofDirection(
          double direction, double begin, double end,
          {CurveFR? curve}) =>
      Between(
        begin: Offset.fromDirection(direction, begin),
        end: Offset.fromDirection(direction, end),
        curve: curve,
      );

  static Between<Offset> between_offset_ofDirection0From(
    double direction,
    double begin, {
    CurveFR? curve,
  }) =>
      between_offset_ofDirection(direction, begin, 0, curve: curve);

  static Between<Offset> between_offset_ofDirection0To(
    double direction,
    double end, {
    CurveFR? curve,
  }) =>
      between_offset_ofDirection(direction, 0, end, curve: curve);

  ///
  ///
  ///
  static Between<Point3> between_point3_0From(Point3 begin, {CurveFR? curve}) =>
      Between(begin: begin, end: Point3.zero, curve: curve);

  static Between<Point3> between_point3_0To(Point3 end, {CurveFR? curve}) =>
      Between(begin: Point3.zero, end: end, curve: curve);


// ///
// ///
// ///
// static Amplitude<double> amplitude_sin_double_0From(double begin,
//     double times, {
//       CurveFR? curve,
//     }) =>
//     Amplitude(begin, 0.0, times, curving: Curving.sinPeriodOf(times));
//
// static Amplitude<double> amplitude_sin_double_0To(double end,
//     double times, {
//       CurveFR? curve,
//     }) =>
//     Amplitude(0, end, times, curving: Curving.sinPeriodOf(times));
//
// static Amplitude<double> amplitude_sin_double_1To(double end,
//     double times, {
//       CurveFR? curve,
//     }) =>
//     Amplitude(1, end, times, curving: Curving.sinPeriodOf(times));
//
// ///
// ///
// ///
// static Amplitude<Offset> amplitude_sin_offset_0From(Offset begin,
//     double times, {
//       CurveFR? curve,
//     }) =>
//     Amplitude(begin, Offset.zero, times, curving: Curving.sinPeriodOf(times));
//
// static Amplitude<Offset> amplitude_sin_offset_0To(Offset end,
//     double times, {
//       CurveFR? curve,
//     }) =>
//     Amplitude(Offset.zero, end, times, curving: Curving.sinPeriodOf(times));
//
// ///
// ///
// ///
// static Amplitude<Point3> amplitude_sin_point3_0From(Point3 begin,
//     double times, {
//       CurveFR? curve,
//     }) =>
//     Amplitude(begin, Point3.zero, times, curving: Curving.sinPeriodOf(times));
//
// static Amplitude<Point3> amplitude_sin_point3_0To(Point3 end,
//     double times, {
//       CurveFR? curve,
//     }) =>
//     Amplitude(Point3.zero, end, times, curving: Curving.sinPeriodOf(times));
//
// ///
// ///
// ///
// static Amplitude<Radian3> amplitude_sin_radian3_0From(Radian3 begin,
//     double times, {
//       CurveFR? curve,
//     }) =>
//     Amplitude(
//       begin,
//       Radian3.zero,
//       times,
//       curving: Curving.sinPeriodOf(times),
//     );
//
// static Amplitude<Radian3> amplitude_sin_radian3_0To(Radian3 end,
//     double times, {
//       CurveFR? curve,
//     }) =>
//     Amplitude(Radian3.zero, end, times, curving: Curving.sinPeriodOf(times));
}

///
///
/// [generator_mamableSet_spill]
/// [generator_mamableSet_shoot],
///
///
abstract final class FMatable {
  const FMatable();

  ///
  /// fading first
  ///
  static MamableSet appear({
    Alignment alignmentScale = Alignment.center,
    required Between<double> fading,
    required Between<double> scaling,
  }) =>
      MamableSet([
        MamableTransition.fade(fading),
        MamableTransition.scale(scaling, alignment: alignmentScale),
      ]);

  static MamableSet spill({
    required Between<double> fading,
    required Between<Offset> sliding,
  }) =>
      MamableSet([
        MamableTransition.fade(fading),
        MamableTransition.slide(sliding),
      ]);

  static MamableSet penetrate({
    double opacityShowing = 1.0,
    CurveFR? curveClip,
    Clip clipBehavior = Clip.hardEdge,
    required Between<double> fading,
    required Between<Rect> recting,
    required SizingPathFrom<Rect> sizingPathFrom,
  }) =>
      MamableSet([
        MamableTransition.fade(fading),
        MamableClipper(
          BetweenPath<Rect>(
            recting,
            onAnimate: (rect) => sizingPathFrom(rect),
            curve: curveClip,
          ),
          clipBehavior: clipBehavior,
        ),
      ]);

  ///
  /// with slide
  ///
  static MamableSet mamableSet_leave({
    Alignment alignment = Alignment.topLeft,
    required Between<double> rotation,
    required Between<Offset> sliding,
  }) =>
      MamableSet([
        MamableTransition.rotate(rotation, alignment: alignment),
        MamableTransition.slide(sliding),
      ]);

  static MamableSet mamableSet_shoot({
    Alignment alignmentScale = Alignment.topLeft,
    required Between<Offset> sliding,
    required Between<double> scaling,
  }) =>
      MamableSet([
        MamableTransition.slide(sliding),
        MamableTransition.scale(scaling, alignment: alignmentScale),
      ]);

  static MamableSet enlarge({
    Alignment alignmentScale = Alignment.topLeft,
    required Between<double> scaling,
    required Between<Offset> sliding,
  }) =>
      MamableSet([
        MamableTransition.scale(scaling, alignment: alignmentScale),
        MamableTransition.slide(sliding),
      ]);

  static MamableSet slideToThenScale({
    required Offset destination,
    required double scaleEnd,
    double interval = 0.5, // must between 0.0 ~ 1.0
    CurveFR curveScale = CurveFR.linear,
    CurveFR curveSlide = CurveFR.linear,
  }) =>
      MamableSet([
        MamableTransition.slide(Between(
          begin: Offset.zero,
          end: destination,
          curve: curveSlide.interval(0, interval),
        )),
        MamableTransition.scale(
          Between(
            begin: 1.0,
            end: scaleEnd,
            curve: curveScale.interval(interval, 1),
          ),
          alignment: Alignment.center,
        )
      ]);

  ///
  ///
  ///
  static Generator<MamableSet> generator_mamableSet_spill(
    Generator<double> direction,
    double distance, {
    CurveFR? curve,
    required int total,
  }) {
    final interval = 1 / total;
    return (index) => FMatable.spill(
          fading: Between(begin: 0.0, end: 1.0, curve: curve),
          sliding: FMatalue.between_offset_ofDirection(
            direction(index),
            0,
            distance,
            curve: curve.nullOrMap((c) => c.interval(interval * index, 1.0)),
          ),
        );
  }

  static Generator<MamableSet> generator_mamableSet_shoot(
    Offset delta, {
    Generator<double> distribution = FKeep.generateDouble,
    CurveFR? curve,
    required Alignment alignmentScale,
    required int total,
  }) {
    final interval = 1 / total;
    return (index) => FMatable.mamableSet_shoot(
          alignmentScale: alignmentScale,
          sliding: FMatalue.offset_0To(
            delta * distribution(index),
            curve: curve,
          ),
          scaling: FMatalue.between_double_1From(
            0.0,
            curve: curve.nullOrMap((c) => c.interval(interval * index, 1.0)),
          ),
        );
  }
}
