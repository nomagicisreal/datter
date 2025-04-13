///
///
/// this file contains:
/// [Decider]
/// [Supporter]
/// [Sequencer]
/// [Extruding2D]
/// [TextFormFieldValidator]
///
/// [SizingPath], [SizingOffset], ...
/// [PaintFrom], [PaintingPath], [Painter]
/// [RectBuilder]
///
///
/// [WidgetParentBuilder]
/// [WidgetListBuilder]
/// [WidgetGlobalKeysBuilder]
///
/// extensions:
/// [FWidgetBuilder], [FWidgetParentBuilder]
///
///
///
///
part of '../../datter.dart';

typedef Decider<T, S> = Consumer<T> Function(S toggle);
typedef Supporter<T> = T Function(Supplier<int> indexing);
typedef Sequencer<T, I, S> = Mapper<int, S> Function(
  T previous,
  T next,
  I interval,
);

///
///
///
typedef Extruding2D = Rect Function(double width, double height);

typedef TextFormFieldValidator = FormFieldValidator<String> Function(
  String failedMessage,
);

///
///
/// sizing
///
///
typedef Sizing = Size Function(Size size);
typedef SizingDouble = double Function(Size size);
typedef SizingOffset = Offset Function(Size size);
typedef SizingRect = Rect Function(Size size);
typedef SizingPath = Path Function(Size size);
typedef SizingPathFrom<T> = SizingPath Function(T value);
typedef SizingOffsetIterable = Iterable<Offset> Function(Size size);
typedef SizingOffsetList = List<Offset> Function(Size size);
typedef SizingCubicOffsetIterable = Iterable<CubicOffset> Function(Size size);

///
/// painting
///
typedef PaintFrom = Paint Function(Canvas canvas, Size size);
typedef PaintingPath = void Function(Canvas canvas, Paint paint, Path path);
typedef Painter = Painting Function(SizingPath sizingPath);

///
/// rect
///
typedef RectBuilder = Rect Function(BuildContext context);

///
///
/// widget
///
///
typedef WidgetParentBuilder = Widget Function(
  BuildContext context,
  List<Widget> children,
);

typedef WidgetListBuilder = List<Widget> Function(BuildContext context);

typedef WidgetGlobalKeysBuilder<S extends State<StatefulWidget>> = Widget
    Function(
  BuildContext context,
  Map<String, GlobalKey<S>> keys,
);

///
/// static methods:
/// [none], ...
/// [of], ...
/// [sandwich], ...
/// [deviateBuilderOf], ...
///
extension FWidgetBuilder on WidgetBuilder {
  ///
  ///
  ///
  static Widget none(BuildContext context) => WSizedBox.none;

  static Widget noneAnimation(Animation animation, Widget child) => child;

  static Widget progressing(BuildContext _) => WProgressIndicator.circular;

  ///
  ///
  ///
  static WidgetBuilder of(Widget child) => (_) => child;

  static WidgetBuilder clipPath_reclipNever({
    Key? key,
    Clip clipBehavior = Clip.antiAlias,
    required SizingPath sizingPath,
    required WidgetBuilder builder,
  }) =>
          (context) => ClipPath(
        key: key,
        clipper: Clipping.reclipNever(sizingPath),
        clipBehavior: clipBehavior,
        child: builder(context),
      );

  ///
  ///
  ///
  static List<WidgetBuilder> sandwich({
    Axis direction = Axis.vertical,
    VerticalDirection verticalDirection = VerticalDirection.down,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    Clip clipBehavior = Clip.none,
    TextDirection textDirection = TextDirection.ltr,
    TextBaseline? textBaseline,
    required int breadCount,
    required Generator<WidgetBuilder> bread,
    required Generator<WidgetBuilder> meat,
  }) {
    List<WidgetBuilder> children(int index) => [
          bread(index),
          if (index < breadCount - 1) meat(index),
        ];

    return List<WidgetBuilder>.generate(
      breadCount,
      (index) => (context) => Flex(
        direction: direction,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        clipBehavior: clipBehavior,
        children: children(index).mapToList((build) => build(context)),
      ),
    );
  }

  ///
  ///
  ///
  static Applier<WidgetBuilder> deviateBuilderOf(Alignment alignment) {
    final x = alignment.x;
    final y = alignment.y;
    Row rowOf(List<Widget> children) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        );

    final rowBuilder = switch (x) {
      0 => (child) => rowOf([child]),
      1 => (child) => rowOf([child, WSizedBox.expand]),
      -1 => (child) => rowOf([WSizedBox.expand, child]),
      _ => throw UnimplementedError(),
    };

    Column columnOf(List<Widget> children) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        );

    final columnBuilder = switch (y) {
      0 => (child) => columnOf([child]),
      1 => (child) => columnOf([rowBuilder(child), WSizedBox.expand]),
      -1 => (child) => columnOf([WSizedBox.expand, rowBuilder(child)]),
      _ => throw UnimplementedError(),
    };

    return (child) => (context) => columnBuilder(child);
  }
}

///
/// static methods:
/// [stack], ...
/// instance methods:
/// [builderFrom]
///
///
extension FWidgetParentBuilder on WidgetParentBuilder {
  ///
  /// static methods
  ///
  static WidgetParentBuilder stack({
    Key? key,
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
    TextDirection? textDirection,
    StackFit fit = StackFit.loose,
    Clip clipBehavior = Clip.hardEdge,
  }) =>
      (context, children) => Stack(
            key: key,
            alignment: alignment,
            textDirection: textDirection,
            fit: fit,
            clipBehavior: clipBehavior,
            children: children,
          );

  static WidgetParentBuilder flex({
    required Axis direction,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    Clip clipBehavior = Clip.none,
  }) =>
      (context, children) => Flex(
            direction: direction,
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: mainAxisSize,
            crossAxisAlignment: crossAxisAlignment,
            textDirection: textDirection,
            verticalDirection: verticalDirection,
            textBaseline: textBaseline,
            clipBehavior: clipBehavior,
            children: children,
          );

  ///
  /// instance methods
  ///
  WidgetBuilder builderFrom(Iterable<WidgetBuilder> children) =>
      (context) => this(context, [...children.map((build) => build(context))]);
}
