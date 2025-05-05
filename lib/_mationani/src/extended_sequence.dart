part of '../_mationani.dart';

///
///
/// * [AniSequence]
/// * [AniSequenceStep]
/// * [AniSequenceInterval]
/// * [AniSequenceStyle]
///
/// * [MationaniSequence]
/// * [BetweenInterval]
///
///

///
///
///
typedef AniSequencer<M extends Matable>
    = Sequencer<AniSequenceStep, AniSequenceInterval, M>;

///
///
///
final class AniSequence {
  final List<Mamable> abilities;
  final List<Duration> durations;

  const AniSequence._(this.abilities, this.durations);

  factory AniSequence({
    required int totalStep,
    required AniSequenceStyle style,
    required Generator<AniSequenceStep> step,
    required Generator<AniSequenceInterval> interval,
  }) {
    final durations = <Duration>[];
    AniSequenceInterval intervalGenerator(int index) {
      final i = interval(index);
      durations.add(i.duration);
      return i;
    }

    var i = -1;
    final sequencer = AniSequence._sequencerOf(style);
    return AniSequence._(
      step.linkToListTill<AniSequenceInterval, Mamable>(
        totalStep,
        intervalGenerator,
        (previous, next, interval) => sequencer(previous, next, interval)(++i),
      ),
      durations,
    );
  }

  ///
  /// if [step] == null, there is no animation,
  /// if [step] % 2 == 0, there is forward animation,
  /// if [step] % 2 == 1, there is reverse animation,
  ///
  static Mationani mationani_mamionSequence(
    int? step, {
    Key? key,
    required AniSequence sequence,
    required Widget child,
    required AnimationControllerInitializer initializer,
  }) {
    final i = step ?? 0;
    return Mationani.mamion(
      key: key,
      ani: Ani.updateSequencingWhen(
        step == null ? null : i % 2 == 0,
        duration: sequence.durations[i],
        initializer: initializer,
      ),
      mamable: sequence.abilities[i],
      child: child,
    );
  }

  static AniSequencer<Mamable> _sequencerOf(AniSequenceStyle style) =>
      switch (style) {
        AniSequenceStyle.transformTRS => (previous, next, interval) {
            final curve = CurveFR.of(interval.curves[0]);
            return AniSequenceStyle._sequence(
              previous: previous,
              next: next,
              combine: (begin, end) {
                final a = begin.points3;
                final b = end.points3;
                return MamableSet(
                  [
                    MamableTransform.translation(
                      translate: Between(begin: a[0], end: b[0], curve: curve),
                      alignment: Alignment.topLeft,
                    ),
                    MamableTransform.rotation(
                      rotate: Between(begin: a[1], end: b[1], curve: curve),
                      alignment: Alignment.topLeft,
                    ),
                    MamableTransform.scale(
                      scale: Between(begin: a[2], end: b[2], curve: curve),
                      alignment: Alignment.topLeft,
                    ),
                  ],
                );
              },
            );
          },
        AniSequenceStyle.transitionRotateSlideBezierCubic =>
          (previous, next, interval) {
            final curve = CurveFR.of(interval.curves[0]);
            final controlPoints = interval.offsets;
            return AniSequenceStyle._sequence(
              previous: previous,
              next: next,
              combine: (begin, end) => MamableSet([
                MamableTransition.rotate(Between(
                  begin: begin.values[0],
                  end: end.values[0],
                  curve: curve,
                )),
                MamableTransition.slide(BetweenSpline2D(
                  onLerp: BetweenSpline2D.lerpBezierCubic(
                    begin: begin.offsets[0],
                    end: end.offsets[0],
                    c1: previous.offsets[0] + controlPoints[0],
                    c2: previous.offsets[0] + controlPoints[1],
                  ),
                  curve: curve,
                )),
              ]),
            );
          },
      };
}

///
///
final class AniSequenceStep {
  final List<double> values;
  final List<Offset> offsets;
  final List<Point3> points3;

  const AniSequenceStep({
    this.values = const [],
    this.offsets = const [],
    this.points3 = const [],
  });
}

///
///
final class AniSequenceInterval {
  final Duration duration;
  final List<Curve> curves;
  final List<Offset> offsets; // for curving control, interval step

  const AniSequenceInterval({
    this.duration = DurationExtension.second1,
    required this.curves,
    this.offsets = const [],
  });
}

///
///
enum AniSequenceStyle {
  // TRS: Translation, Rotation, Scaling
  transformTRS,

  // rotate, slide in bezier cubic
  transitionRotateSlideBezierCubic;

  ///
  /// [_forwardOrReverse] is the only way to sequence [Mamable] for now
  ///
  static bool _forwardOrReverse(int i) => i % 2 == 0;

  static Mapper<int, Mamable> _sequence({
    Predicator<int> predicator = _forwardOrReverse,
    required AniSequenceStep previous,
    required AniSequenceStep next,
    required Fusionor<AniSequenceStep, Mamable> combine,
  }) =>
      (i) => combine(
            predicator(i) ? previous : next,
            predicator(i) ? next : previous,
          );
}

///
///
///
abstract final class MationaniSequence {
  static Between<T> between<T>({
    BetweenInterval weight = BetweenInterval.linear,
    CurveFR? curve,
    required List<T> steps,
  }) =>
      Between.constant(
        begin: steps.first,
        end: steps.last,
        onLerp: BetweenInterval._link(
          totalStep: steps.length,
          step: (i) => steps[i],
          interval: (i) => weight,
        ),
        curve: curve,
      );

  static Between<T> between_generator<T>({
    required int totalStep,
    required Generator<T> step,
    required Generator<BetweenInterval> interval,
    CurveFR? curve,
    Sequencer<T, Lerper<T>, Between<T>>? sequencer,
  }) =>
      Between.constant(
        begin: step(0),
        end: step(totalStep - 1),
        onLerp: BetweenInterval._link(
          totalStep: totalStep,
          step: step,
          interval: interval,
          sequencer: sequencer,
        ),
        curve: curve,
      );

  static Between<T> outAndBack<T>({
    required T begin,
    required T target,
    CurveFR? curve,
    double ratio = 1.0,
    Curve curveOut = Curves.fastOutSlowIn,
    Curve curveBack = Curves.fastOutSlowIn,
    Sequencer<T, Lerper<T>, Between<T>>? sequencer,
  }) =>
      Between.constant(
        begin: begin,
        end: begin,
        onLerp: BetweenInterval._link(
          totalStep: 3,
          step: (i) => i == 1 ? target : begin,
          interval: (i) => i == 0
              ? BetweenInterval(ratio, curve: curveOut)
              : BetweenInterval(1 / ratio, curve: curveBack),
          sequencer: sequencer,
        ),
        curve: curve,
      );
}

///
///
///
class BetweenInterval {
  final double weight;
  final Curve curve;

  Lerper<T> lerp<T>(T a, T b) {
    final curving = curve.transform;
    final onLerp = Between.lerperOf<T>(a, b);
    return (t) => onLerp(curving(t));
  }

  const BetweenInterval(this.weight, {this.curve = Curves.linear});

  static const BetweenInterval linear = BetweenInterval(1);

  ///
  ///
  /// the index 0 of [interval] is between index 0 and 1 of [step]
  /// the index 1 of [interval] is between index 1 and 2 of [step], and so on.
  ///
  ///
  static Lerper<T> _link<T>({
    required int totalStep,
    required Generator<T> step,
    required Generator<BetweenInterval> interval,
    Sequencer<T, Lerper<T>, Between<T>>? sequencer,
  }) {
    final seq = sequencer ?? _sequencer<T>;
    var i = -1;
    return TweenSequence(
      step.linkToListTill(
        totalStep,
        interval,
        (previous, next, interval) => TweenSequenceItem<T>(
          tween: seq(previous, next, interval.lerp(previous, next))(++i),
          weight: interval.weight,
        ),
      ),
    ).transform;
  }

  static Mapper<int, Between<T>> _sequencer<T>(
    T previous,
    T next,
    Lerper<T> onLerp,
  ) =>
      (_) => Between.constant(
          begin: previous, end: next, onLerp: onLerp, curve: null);
}
