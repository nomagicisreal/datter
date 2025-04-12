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
///
/// extensions
///
///
///
///
///
extension FWidgetBuilder on WidgetBuilder {
  static WidgetBuilder of(Widget child) => (_) => child;

  static List<WidgetBuilder> ofList(List<Widget> children) =>
      children.mapToList((child) => (_) => child);

  static Widget none(BuildContext context) => WSizedBox.none;

  static Widget noneAnimation(Animation animation, Widget child) => child;

  static Widget progressing(BuildContext _) => WProgressIndicator.circular;

  static List<Widget> sandwich({
    Axis direction = Axis.vertical,
    VerticalDirection verticalDirection = VerticalDirection.down,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    Clip clipBehavior = Clip.none,
    TextDirection textDirection = TextDirection.ltr,
    TextBaseline? textBaseline,
    required int breadCount,
    required Generator<Widget> bread,
    required Generator<Widget> meat,
  }) {
    List<Widget> children(int index) => [
      bread(index),
      if (index < breadCount - 1) meat(index),
    ];

    return List<Widget>.generate(
      breadCount,
          (index) => Flex(
        direction: direction,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        clipBehavior: clipBehavior,
        children: children(index),
      ),
    );
  }

  static Applier<Widget> deviateBuilderOf(Alignment alignment) {
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

    return (child) => columnBuilder(child);
  }
}

extension FWidgetParentBuilder on WidgetParentBuilder {
  WidgetBuilder builderFrom(Iterable<WidgetBuilder> children) =>
          (context) => this(context, [...children.map((build) => build(context))]);
}
