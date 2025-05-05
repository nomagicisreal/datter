part of '../../datter.dart';

///
///
/// stateful widget:
/// [WImage]
///
/// stateless widget:
/// [WIcon]
/// [WGridPaper]
///
/// render object widget:
/// [WSizedBox]
/// [WCustomPaint], [WClipPath]
/// [WRadioList]
/// [FTransform]
///
///
///

extension WImage on Image {
  static Image assetsInDimension(
    String path,
    double dimension, {
    Alignment alignment = Alignment.center,
    FilterQuality filterQuality = FilterQuality.medium,
  }) =>
      Image.asset(
        path,
        height: dimension,
        width: dimension,
        alignment: alignment,
        filterQuality: filterQuality,
      );
}

///
///
///
extension WIcon on Icon {
  static const check = Icon(Icons.check);
  static const close = Icon(Icons.close);
  static const cross = close;
  static const multiple = close;
  static const add = Icon(Icons.add);
  static const plus = add;
  static const minus = Icon(Icons.remove);
  static const question_mark = Icon(Icons.question_mark);
  static const play = Icon(Icons.play_arrow);
  static const pause = Icon(Icons.pause);
  static const stop = Icon(Icons.stop);
  static const delete = Icon(Icons.delete);
  static const send = Icon(Icons.send);
  static const chevron_right = Icon(Icons.chevron_right);
  static const chevron_left = Icon(Icons.chevron_left);
  static const chevron_right_large = Icon(Icons.arrow_forward_ios);
  static const chevron_left_large = Icon(Icons.arrow_back_ios);
  static const arrow_rightward = Icon(Icons.arrow_forward);
  static const arrow_leftward = Icon(Icons.arrow_back);
}

extension WGridPaper on GridPaper {
  static const none = GridPaper();
  static const simple =
      GridPaper(color: Colors.white, interval: 100, subdivisions: 1);

  static const simpleList = <GridPaper>[simple, simple, simple];

  static const simpleListList = <List<GridPaper>>[
    <GridPaper>[simple, simple, simple],
    <GridPaper>[simple, simple, simple]
  ];
}

///
///
/// [height], ...
/// [sandwich], ...
///
extension WSizedBox on SizedBox {
  static const none = SizedBox();
  static const shrink = SizedBox.shrink();
  static const expand = SizedBox.expand();

  ///
  ///
  ///
  static Widget squareColored({
    required double dimension,
    required Color color,
    bool centered = false,
    Widget? child,
  }) =>
      centered
          ? Center(
              child: SizedBox.square(
                dimension: dimension,
                child: ColoredBox(color: color, child: child),
              ),
            )
          : SizedBox.square(
              dimension: dimension,
              child: ColoredBox(color: color, child: child),
            );

  ///
  ///
  ///
  static List<Widget> sandwich({
    Axis axis = Axis.horizontal,
    required double dimension,
    required List<Widget> sibling,
  }) =>
      sibling.sandwich(
        List.generate(
          sibling.length - 1,
          axis == Axis.horizontal
              ? (_) => SizedBox(width: dimension)
              : (_) => SizedBox(height: dimension),
          growable: false,
        ),
      );
}

///
///
///
extension WCustomPaint on CustomPaint {
  static CustomPaint repaintNever({
    PaintingPath paintingPath = FPaintingPath.draw,
    required PaintFrom paintFrom,
    required SizingPath sizingPath,
  }) =>
      CustomPaint(
        painter: Painting.rePaintNever(
          paintingPath: paintingPath,
          paintFrom: paintFrom,
          sizingPath: sizingPath,
        ),
      );

  static CustomPaint repaintWhenUpdate({
    PaintingPath paintingPath = FPaintingPath.draw,
    required PaintFrom paintFrom,
    required SizingPath sizingPath,
  }) =>
      CustomPaint(
        painter: Painting.rePaintWhenUpdate(
          paintingPath: paintingPath,
          paintFrom: paintFrom,
          sizingPath: sizingPath,
        ),
      );

  ///
  ///
  ///
  static CustomPaint drawRRegularPolygon(
    RRegularPolygonCubicOnEdge polygon, {
    required PaintFrom pathFrom,
    Widget? child,
  }) =>
      CustomPaint(
        painter: Painting.rRegularPolygon(pathFrom, polygon),
        child: child,
      );
}

///
///
/// [WClipPath._shape]
///   [WClipPath.shapeCircle]
///   [WClipPath.shapeOval]
///   [WClipPath.shapeStar]
///   [WClipPath.shapeStadium]
///   [WClipPath.shapeBeveledRectangle]
///   [WClipPath.shapeRoundedRectangle]
///   [WClipPath.shapeContinuousRectangle]
///
/// [WClipPath.rRectColored]
///
/// [WClipPath.reClipNever]
/// [WClipPath.rectFromZeroToSize]
/// [WClipPath.polygonRRegular]
/// [WClipPath.pathPolygonRRegularDecoratedBox]
///
///
/// there is no [BorderSide] when using [ShapeBorderClipper], See Also the comment above [FBorderSide]
///
///
extension WClipPath on ClipPath {
  static Widget shapeCircle({
    Key? key,
    Clip clipBehavior = Clip.antiAlias,
    Widget? child,
    double eccentricity = 0.0,
  }) =>
      ClipPath.shape(
        key: key,
        shape: CircleBorder(side: BorderSide.none, eccentricity: eccentricity),
        clipBehavior: clipBehavior,
        child: child,
      );

  static Widget shapeOval({
    Key? key,
    Clip clipBehavior = Clip.antiAlias,
    Widget? child,
    double eccentricity = 1.0,
  }) =>
      ClipPath.shape(
        key: key,
        shape: OvalBorder(side: BorderSide.none, eccentricity: eccentricity),
        clipBehavior: clipBehavior,
        child: child,
      );

  static Widget shapeStar({
    Key? key,
    Clip clipBehavior = Clip.antiAlias,
    Widget? child,
    double points = 5,
    double innerRadiusRatio = 0.4,
    double pointRounding = 0,
    double valleyRounding = 0,
    double rotation = 0,
    double squash = 0,
  }) =>
      ClipPath.shape(
        key: key,
        shape: StarBorder(
          side: BorderSide.none,
          points: points,
          innerRadiusRatio: innerRadiusRatio,
          pointRounding: pointRounding,
          valleyRounding: valleyRounding,
          rotation: rotation,
          squash: squash,
        ),
        clipBehavior: clipBehavior,
        child: child,
      );

  static Widget shapeStadium({
    Key? key,
    Clip clipBehavior = Clip.antiAlias,
    Widget? child,
  }) =>
      ClipPath.shape(
        key: key,
        shape: const StadiumBorder(side: BorderSide.none),
        clipBehavior: clipBehavior,
        child: child,
      );

  static Widget shapeBeveledRectangle({
    Key? key,
    Clip clipBehavior = Clip.antiAlias,
    Widget? child,
    required BorderRadius borderRadius,
  }) =>
      ClipPath.shape(
        key: key,
        shape: BeveledRectangleBorder(
          side: BorderSide.none,
          borderRadius: borderRadius,
        ),
        clipBehavior: clipBehavior,
        child: child,
      );

  static Widget shapeRoundedRectangle({
    Key? key,
    Clip clipBehavior = Clip.antiAlias,
    Widget? child,
    required BorderRadius borderRadius,
  }) =>
      ClipPath.shape(
        key: key,
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: borderRadius,
        ),
        clipBehavior: clipBehavior,
        child: child,
      );

  static Widget shapeContinuousRectangle({
    Key? key,
    Clip clipBehavior = Clip.antiAlias,
    Widget? child,
    required BorderRadius borderRadius,
  }) =>
      ClipPath.shape(
        key: key,
        shape: ContinuousRectangleBorder(
          side: BorderSide.none,
          borderRadius: borderRadius,
        ),
        clipBehavior: clipBehavior,
        child: child,
      );

  ///
  ///
  /// with build-in clipper
  ///
  ///
  ///
  static ClipRRect rRectColored({
    required BorderRadius borderRadius,
    required Color color,
    CustomClipper<RRect>? clipper,
    Clip clipBehavior = Clip.antiAlias,
    Widget? child,
  }) =>
      ClipRRect(
        clipper: clipper,
        clipBehavior: clipBehavior,
        borderRadius: borderRadius,
        child: ColoredBox(color: color, child: child),
      );

  ///
  ///
  ///
  /// with [Clipping]
  ///
  ///
  ///
  static ClipPath reClipNever({
    Clip clipBehavior = Clip.antiAlias,
    required SizingPath sizingPath,
    required Widget child,
  }) =>
      ClipPath(
        clipBehavior: clipBehavior,
        clipper: Clipping.reclipNever(sizingPath),
        child: child,
      );

  static ClipPath rectFromZeroToSize({
    Clip clipBehavior = Clip.antiAlias,
    required Size size,
    required Widget child,
  }) =>
      ClipPath(
        clipBehavior: clipBehavior,
        clipper: Clipping.rectOf(Offset.zero & size),
        child: child,
      );

  static ClipPath polygonRRegular(
    RRegularPolygonCubicOnEdge polygon, {
    Key? key,
    Clip clipBehavior = Clip.antiAlias,
    Widget? child,
    Companion<CubicOffset, Size> adjust = CubicOffset.companionSizeAdjustCenter,
  }) =>
      ClipPath(
        key: key,
        clipBehavior: clipBehavior,
        clipper: Clipping.reclipNever(
          FSizingPath.polygonCubic(polygon.cubicPoints, adjust: adjust),
        ),
        child: child,
      );

  static ClipPath pathPolygonRRegularDecoratedBox(
    Decoration decoration,
    RRegularPolygonCubicOnEdge polygon, {
    DecorationPosition position = DecorationPosition.background,
    Widget? child,
  }) =>
      ClipPath(
        clipper: Clipping.rRegularPolygon(polygon),
        child: DecoratedBox(
          decoration: decoration,
          position: position,
          child: child,
        ),
      );
}

///
///
///
extension WAwaitBuilder on FutureBuilder {
  ///
  ///
  ///
  static FutureBuilder<T> future_progressingOrBuild<T>({
    WidgetBuilder progressBuilder = FWidgetBuilder.progressing,
    WidgetBuilder? builderNull,
    required Future<T> future,
    required WidgetValuedBuilder<T?> builder,
  }) =>
      FutureBuilder<T>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) return builder(context, snapshot.data);
          return progressBuilder(context);
        },
      );

  ///
  ///
  ///
  static StreamBuilder<T> stream_normal<T>({
    Key? key,
    T? initialData,
    ValueWidgetBuilder<T?>? noneConnectionBuilder,
    ValueWidgetBuilder<T?>? doneConnectBuilder,
    ValueWidgetBuilder<Object?>? errorBuilder,
    ValueWidgetBuilder<T?>? waitingDataBuilder,
    ValueWidgetBuilder<T?>? activeBuilder,
    WidgetBuilder noDataBuilder = FWidgetBuilder.progressing,
    required Stream<T> stream,
    required ValueWidgetBuilder<T?> builder,
    Widget? child,
  }) =>
      StreamBuilder<T>(
        key: key,
        initialData: initialData,
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return errorBuilder?.call(context, snapshot.error, child) ??
                (throw UnimplementedError());
          }
          if (!snapshot.hasData) return noDataBuilder(context);
          final status = snapshot.connectionState;
          return (switch (status) {
                ConnectionState.none => noneConnectionBuilder,
                ConnectionState.waiting => waitingDataBuilder,
                ConnectionState.active => activeBuilder,
                ConnectionState.done => doneConnectBuilder,
              } ??
              builder)(context, snapshot.data, child);
        },
      );
}

///
///
/// [identity]
///
/// [FTransform] is an extension for translating from "my coordinate system" to "dart coordinate system".
/// the discussion here follows the definitions in the comment above [Radian3.direct].
/// To distinguish the coordinate system between "my coordinate system" to "dart coordinate system",
/// it's necessary to read the comment above [Radian3.direct], which shows what "my coordinate system" is.
///
/// [Direction3DIn6] is a link between "dart coordinate system" and "my coordinate system",
/// the comment belows shows the way how "dart coordinate system" can be described by [Direction3DIn6].
/// take [Offset.fromDirection] for example, its radian 0 ~ 2π going through:
///   1. [Direction3DIn6.right]
///   2. [Direction3DIn6.bottom]
///   3. [Direction3DIn6.left]
///   4. [Direction3DIn6.top]
///   5. [Direction3DIn6.right], ...
/// its evidence that [Offset.fromDirection] start from [Direction3DIn6.right],
/// and the axis of [Offset.fromDirection] can be presented as "[Direction3DIn6.front] -> [Direction3DIn6.back]".
/// because only when the perspective comes from [Direction3DIn6.front] to [Direction3DIn6.back],
/// the order from 1 to 6 is counterclockwise;
/// it's won't be counterclockwise if "[Direction3DIn6.back] -> [Direction3DIn6.front]".
///
/// Not only [Offset], [Transform] and [Matrix4] can also be described by [Direction3DIn6], their:
///   z axis is [Direction3DIn6.front] -> [Direction3DIn6.back], radian start from [Direction3DIn6.right]
///   x axis is [Direction3DIn6.left] -> [Direction3DIn6.right], radian start from [Direction3DIn6.back]
///   y axis is [Direction3DIn6.top] -> [Direction3DIn6.bottom], radian start from [Direction3DIn6.left]
///
///

///
///
/// [identity], ...
/// [translateSpace2], ...
/// [ifInQuadrant], ... (Notice that the coordinate system should be in consistent with [Transform] widget)
///
///
///
extension FTransform on Transform {
  ///
  ///
  ///
  static Transform identity({
    required Applier<Matrix4> apply,
    required Widget child,
  }) =>
      Transform(
        transform: apply(Matrix4.identity()),
        child: child,
      );

  ///
  ///
  ///
  static Point2 translateSpace2(Point2 p) => Point2(p.x, -p.y);

  static Point3 translateSpace3(Point3 p) => Point3(p.x, -p.z, -p.y);

  ///
  /// 'right' and 'left' are the same no matter in flutter or in math.
  /// 'top' and 'bottom' are different between in flutter and in math
  ///
  static bool ifOnRight(double radian) =>
      FTransform.ifInQuadrant(radian, 1) || FTransform.ifInQuadrant(radian, 4);

  static bool ifOnLeft(double radian) =>
      FTransform.ifInQuadrant(radian, 2) || FTransform.ifInQuadrant(radian, 3);

  // different from math
  static bool ifOnBottom(double radian) =>
      FTransform.ifInQuadrant(radian, 1) || FTransform.ifInQuadrant(radian, 2);

  static bool ifOnTop(double radian) =>
      FTransform.ifInQuadrant(radian, 3) || FTransform.ifInQuadrant(radian, 4);

  static bool ifInQuadrant(double radian, int quadrant) {
    final r = radian % DoubleExtension.radian_angle360;
    return switch (quadrant) {
      1 => r.isRangeOpen(
            DoubleExtension.radian_angle270,
            DoubleExtension.radian_angle360,
          ) ||
          r.isRangeOpen(-DoubleExtension.radian_angle90, 0),
      2 => r.isRangeOpen(
            DoubleExtension.radian_angle180,
            DoubleExtension.radian_angle270,
          ) ||
          r.isRangeOpen(-DoubleExtension.radian_angle180,
              -DoubleExtension.radian_angle90),
      3 => r.isRangeOpen(
            DoubleExtension.radian_angle90,
            DoubleExtension.radian_angle180,
          ) ||
          r.isRangeOpen(-DoubleExtension.radian_angle270,
              -DoubleExtension.radian_angle180),
      4 => r.isRangeOpen(0, DoubleExtension.radian_angle90) ||
          r.isRangeOpen(-DoubleExtension.radian_angle360,
              -DoubleExtension.radian_angle270),
      _ => throw UnimplementedError(),
    };
  }

// ///
// ///
// ///
// static Transform formFromDirection({
//   double zDeep = 100,
//   required Direction3DIn6 direction,
//   required Widget child,
// }) =>
//     switch (direction) {
//       Direction3DIn6.front => Transform(
//         transform: Matrix4.identity(),
//         alignment: Alignment.center,
//         child: child,
//       ),
//       Direction3DIn6.back => Transform(
//         alignment: Alignment.center,
//         transform: Matrix4.identity()..translateOf(Point3.ofZ(-zDeep)),
//         child: child,
//       ),
//       Direction3DIn6.left => Transform(
//         alignment: Alignment.centerLeft,
//         transform: Matrix4.identity()..rotateY(DoubleExtension.radian_angle90),
//         child: child,
//       ),
//       Direction3DIn6.right => Transform(
//         alignment: Alignment.centerRight,
//         transform: Matrix4.identity()..rotateY(-DoubleExtension.radian_angle90),
//         child: child,
//       ),
//       Direction3DIn6.top => Transform(
//         alignment: Alignment.topCenter,
//         transform: Matrix4.identity()..rotateX(-DoubleExtension.radian_angle90),
//         child: child,
//       ),
//       Direction3DIn6.bottom => Transform(
//         alignment: Alignment.bottomCenter,
//         transform: Matrix4.identity()..rotateX(DoubleExtension.radian_angle90),
//         child: child,
//       ),
//     };
}
