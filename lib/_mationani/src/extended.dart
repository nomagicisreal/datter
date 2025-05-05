part of '../_mationani.dart';

///
///
/// [MationaniArrow]
/// [MationaniCutting]
///
/// future: floating action button
///

///
///
///
class MationaniArrow extends StatelessWidget {
  const MationaniArrow({
    super.key,
    this.dimension = 40,
    required this.onTap,
    required this.direction,
    required this.child,
  });

  final double dimension;
  final VoidCallback onTap;
  final DirectionIn4 direction;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: RotatedBox(
        quarterTurns: direction.index,
        child: InkWell(
          onTap: onTap,
          child: Mationani.mamion(
            ani: Ani.initRepeat(),
            mamable: MamableTransition.slide(
              FMatalue.offset_0To(
                KGeometry.offset_square_1 / 2,
                curve: CurveFR.of(Curving.sinPeriodOf(2)),
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

///
///
///
class MationaniCutting extends StatelessWidget {
  const MationaniCutting({
    super.key,
    this.pieces = 2,
    this.direction = DoubleExtension.radian_angle45,
    this.curveFadeOut,
    this.curve,
    required this.ani,
    required this.rotation,
    required this.distance,
    required this.child,
  }) : assert(pieces == 2 && direction == DoubleExtension.radian_angle45);

  final int pieces;
  final double direction;
  final double rotation;
  final double distance;
  final Ani ani;
  final CurveFR? curveFadeOut;
  final CurveFR? curve;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Mationani.manion(
      ani: ani,
      manable: ManableSet.respectivelyAndParent(
        parent: MamableTransition.fadeOut(curve: curveFadeOut),
        children: List.generate(
          pieces,
          (index) => FMatable.mamableSet_leave(
            alignment: Alignment.bottomRight,
            rotation: FMatalue.between_double_0To(
              (index == 0 ? -rotation : rotation) /
                  DoubleExtension.radian_angle360,
              curve: curve,
            ),
            sliding: FMatalue.offset_0To(
              index == 0
                  ? KGeometry.offset_bottomLeft * distance
                  : KGeometry.offset_topRight * distance,
              curve: curve,
            ),
          ),
        ),
      ),
      parenting: FWidgetBuilder.parent_stack(),
      children: List.generate(
        pieces,
        (index) => ClipPath(
          clipper: Clipping.reclipNever(
            index == 0
                ? (size) => Path()
                  ..lineToPoint(size.bottomRight(Offset.zero))
                  ..lineToPoint(size.bottomLeft(Offset.zero))
                : (size) => Path()
                  ..lineToPoint(size.bottomRight(Offset.zero))
                  ..lineToPoint(size.topRight(Offset.zero)),
          ),
          child: child,
        ),
      ),
    );
  }
}
