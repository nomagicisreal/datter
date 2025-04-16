part of '../../datter.dart';

///
///
/// stateful widget:
/// [WProgressIndicator]
/// [WImage]
///
/// stateless widget:
/// [WDrawer]
/// [WListView]
/// [WIcon]
/// [WGridPaper]
/// [WSpacer], [WDivider]
///
/// render object widget:
/// [WSizedBox]
/// [WColoredBox]
/// [WCustomPaint], [WClipPath]
/// [WRadioList]
/// [FTransform]
///
///
///

extension WImage on Image {
  static assetsInDimension(
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
extension WDrawer on Drawer {
  static const none = Drawer();
}

///
///
///
extension WListView on ListView {
  static ListView get fakeBigSmall_25 => ListView.builder(
        padding: KGeometry.edgeInsets_vertical_1 * 8,
        itemCount: 25,
        itemBuilder: (context, index) => Container(
          margin: KGeometry.edgeInsets_horizontal_1 * 24 +
              KGeometry.edgeInsets_vertical_1 * 8,
          height: index.isOdd ? 128 : 36,
          decoration: BoxDecoration(
            borderRadius: KGeometry.borderRadius_circularAll_1 * 8,
            color: Colors.grey.shade600,
          ),
        ),
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

extension WSpacer on Spacer {
  static const Spacer none = Spacer();
}

extension WDivider on Divider {
  static const white = Divider(color: Colors.white);
  static const black_3 = Divider(thickness: 3);
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
  static SizedBox height(double dimension, {Widget? child}) =>
      SizedBox(height: dimension, child: child);

  static SizedBox width(double dimension, {Widget? child}) =>
      SizedBox(width: dimension, child: child);

  static Widget squareColored({
    required double dimension,
    required Color color,
    bool center = false,
    Widget? child,
  }) =>
      center
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
    bool isWidth = true,
    required double dimension,
    required List<Widget> sibling,
  }) =>
      sibling.sandwich(
        List.generate(
          sibling.length - 1,
          isWidth
              ? (_) => WSizedBox.width(dimension)
              : (_) => WSizedBox.height(dimension),
          growable: false,
        ),
      );
}

///
///
///
extension WColoredBox on ColoredBox {
  static const ColoredBox white = ColoredBox(color: Colors.white);
  static const ColoredBox red = ColoredBox(color: Colors.red);
  static const ColoredBox orange = ColoredBox(color: Colors.orange);
  static const ColoredBox yellow = ColoredBox(color: Colors.yellow);
  static const ColoredBox green = ColoredBox(color: Colors.green);
  static const ColoredBox blue = ColoredBox(color: Colors.blue);
  static const ColoredBox blueAccent = ColoredBox(color: Colors.blueAccent);
  static const ColoredBox purple = ColoredBox(color: Colors.purple);
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
///
extension WRadioList on RadioListTile {
  static List<RadioListTile<String?>> listString({
    required String? optionsHost,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) =>
      options.mapToList(
        (option) => RadioListTile<String?>(
          groupValue: optionsHost,
          title: Text(option),
          value: option,
          onChanged: onChanged,
        ),
      );
}

///
///
///
extension WFutureBuilder on FutureBuilder {
  static FutureBuilder progressOrBuild<T>({
    WidgetBuilder progressBuilder = FWidgetBuilder.progressing,
    WidgetBuilder? builderNull,
    required Future<T> future,
    required WidgetValuedBuilder<T> builder,
  }) =>
      FutureBuilder<T>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            if (data == null) {
              return builderNull?.call(context) ?? (throw UnimplementedError());
            }
            return builder(context, data);
          }
          return progressBuilder(context);
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
/// [ifInQuadrant], ...
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
  /// 'right' and 'left' are the same no matter in dart or in math
  ///
  static bool ifInQuadrant(double radian, int quadrant) {
    final r = Radian.moduleBy360Angle(radian);
    return switch (quadrant) {
      1 => r.isRangeOpen(Radian.angle_270, Radian.angle_360) ||
          r.isRangeOpen(-Radian.angle_90, 0),
      2 => r.isRangeOpen(Radian.angle_180, Radian.angle_270) ||
          r.isRangeOpen(-Radian.angle_180, -Radian.angle_90),
      3 => r.isRangeOpen(Radian.angle_90, Radian.angle_180) ||
          r.isRangeOpen(-Radian.angle_270, -Radian.angle_180),
      4 => r.isRangeOpen(0, Radian.angle_90) ||
          r.isRangeOpen(-Radian.angle_360, -Radian.angle_270),
      _ => throw UnimplementedError(),
    };
  }

  static bool ifOnRight(double radian) => Radian2(radian).azimuthalOnRight;

  static bool ifOnLeft(double radian) => Radian2(radian).azimuthalOnLeft;

  static bool ifOnTop(double radian) =>
      Radian.ifWithinAngle0_180N(Radian.moduleBy360Angle(radian));

  static bool ifOnBottom(double radian) =>
      Radian.ifWithinAngle0_180(Radian.moduleBy360Angle(radian));
}
