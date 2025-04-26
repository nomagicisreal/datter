part of '../../datter.dart';

///
///
/// this file contains:
/// [Extruding2D]
/// [TextFormFieldValidator]
///
/// [SizingPath], [SizingOffset], ...
/// [PaintFrom], [PaintingPath], [Painter]
/// [RectBuilder]
///
/// [Parenting]
///
/// takeaway:
/// [FWidgetBuilder].
/// [ColorExtension]
///
///
///
///

typedef Extruding2D = Rect Function(double width, double height);

typedef TextFormFieldValidator = FormFieldValidator<String> Function(
  String failedMessage,
);

///
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
typedef WidgetChildrenBuilder = List<Widget> Function(BuildContext context);
typedef WidgetValuedBuilder<T> = Widget Function(BuildContext context, T value);
typedef WidgetChildBuilder = Widget Function(
  BuildContext context,
  Widget child,
);
typedef WidgetCallableBuilder = Widget Function(
  BuildContext context,
  VoidCallback callable,
);
typedef WidgetGlobalKeysBuilder<T extends State> = Widget Function(
  BuildContext context,
  Map<String, GlobalKey<T>> keys,
);
typedef Parenting = Widget Function(List<Widget> children);

///
/// static methods:
/// [none], ...
/// [of], ...
/// [applier_deviate], ...
/// [parent_stack], ...
///
extension FWidgetBuilder on WidgetBuilder {
  ///
  ///
  ///
  static Widget none(BuildContext _) => WSizedBox.none;

  static Widget progressing(BuildContext _) => CircularProgressIndicator();

  static Widget noneAnimation(Animation animation, Widget child) => child;

  ///
  ///
  ///
  static WidgetBuilder of(Widget child) => (_) => child;

  static WidgetBuilder ofClipPath_reclipNever({
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

  static WidgetBuilder ofStack_centerOnSurface({
    double? widthFactor,
    double? heightFactor,
    VoidCallback? onTapSurface,
    required Mapper<BuildContext, Color> colorSurface,
    required WidgetBuilder builder,
  }) =>
      (context) => Stack(
            fit: StackFit.expand,
            children: [
              GestureDetector(
                onTap: onTapSurface,
                child: ColoredBox(color: colorSurface(context)),
              ),
              Center(
                widthFactor: widthFactor,
                heightFactor: heightFactor,
                child: builder(context),
              ),
            ],
          );

  ///
  ///
  ///
  static Applier<WidgetBuilder> applier_deviate(Alignment alignment) {
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

  ///
  ///
  ///
  static RoutePageBuilder routePageBuilder_of(Widget child) =>
      (_, __, ___) => child;

  static RoutePageBuilder routePageBuilder_ofBuilder(WidgetBuilder builder) =>
      (context, animation, secondaryAnimation) => builder(context);

  ///
  ///
  ///
  static Parenting parent_stack({
    Key? key,
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
    TextDirection? textDirection,
    StackFit fit = StackFit.loose,
    Clip clipBehavior = Clip.hardEdge,
  }) =>
      (children) => Stack(
            key: key,
            alignment: alignment,
            textDirection: textDirection,
            fit: fit,
            clipBehavior: clipBehavior,
            children: children,
          );

  static Parenting parent_flex({
    required Axis direction,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    Clip clipBehavior = Clip.none,
  }) =>
      (children) => Flex(
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
}

///
/// constants: [distinct20], ...
/// instance methods: [plusARGB], ...
///
extension ColorExtension on Color {
  ///
  /// 20 distinct colors, https://sashamaps.net/docs/resources/20-colors/
  ///
  static const Color _distinct20_pink = Color(0xFFfabed4);
  static const Color _distinct20_red = Color(0xFFe6194b);
  static const Color _distinct20_maroon = Color(0xFF800000);
  static const Color _distinct20_orange = Color(0xFFf58231);
  static const Color _distinct20_brown = Color(0xFF9a6324);
  static const Color _distinct20_beige = Color(0xFFfffac8);
  static const Color _distinct20_apricot = Color(0xFFffd8b1);
  static const Color _distinct20_yellow = Color(0xFFffe119);
  static const Color _distinct20_olive = Color(0xFF808000);
  static const Color _distinct20_lime = Color(0xFFbfef45);
  static const Color _distinct20_mint = Color(0xFFaaffc3);
  static const Color _distinct20_green = Color(0xFF3cb44b);
  static const Color _distinct20_cyan = Color(0xFF42d4f4);
  static const Color _distinct20_teal = Color(0xFF469990);
  static const Color _distinct20_blue = Color(0xFF4363d8);
  static const Color _distinct20_navy = Color(0xFF000075);
  static const Color _distinct20_lavender = Color(0xFFdcbeff);
  static const Color _distinct20_magenta = Color(0xFFf032e6);
  static const Color _distinct20_purple = Color(0xFF9111b4);
  static const Color _distinct20_grey = Color(0xFFa9a9a9);
  static const List<Color> distinct20 = [
    _distinct20_pink,
    _distinct20_red,
    _distinct20_maroon,
    _distinct20_orange,
    _distinct20_brown,
    _distinct20_beige,
    _distinct20_apricot,
    _distinct20_yellow,
    _distinct20_olive,
    _distinct20_lime,
    _distinct20_mint,
    _distinct20_green,
    _distinct20_cyan,
    _distinct20_teal,
    _distinct20_blue,
    _distinct20_navy,
    _distinct20_lavender,
    _distinct20_magenta,
    _distinct20_purple,
    _distinct20_grey,
  ];

  ///
  /// instance methods
  ///
  Color plusARGB(double alpha, double red, double green, double blue) =>
      Color.from(
        alpha: a + alpha,
        red: r + red,
        green: g + green,
        blue: b + blue,
      );

  Color minusARGB(int alpha, int red, int green, int blue) => Color.from(
        alpha: a - alpha,
        red: r - red,
        green: g - green,
        blue: b - blue,
      );

  Color plusAllRGB(double value) =>
      Color.from(alpha: a, red: r + value, green: g + value, blue: b + value);

  Color minusAllRGB(double value) =>
      Color.from(alpha: a, red: r - value, green: g - value, blue: b - value);
}
