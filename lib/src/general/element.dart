///
/// this file contains:
///
/// [ColorExtension]
///
/// [FBoxShadow]
/// [FBorderSide], [FBorderBox], [FBorderInput], [FBorderOutlined]
/// [FDecorationBox], [FDecorationShape], [FDecorationInput]
///
///
///
///
part of '../../datter.dart';

///
///
/// constants: [distinct20], ...
/// instance methods: [plusARGB], ...
///
extension ColorExtension on Color {
  ///
  ///
  /// constants
  ///
  ///
  // 20 distinct colors, https://sashamaps.net/docs/resources/20-colors/
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
  ///
  ///
  /// instance methods
  ///
  ///
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

///
///
/// [FBoxShadow]
///   [FBoxShadow.blurNormal]
///   [FBoxShadow.blurSolid]
///   [FBoxShadow.blurOuter]
///   [FBoxShadow.blurInner]
///
///
extension FBoxShadow on BoxShadow {
  static BoxShadow blurNormal({
    Color color = Colors.white,
    Offset offset = Offset.zero,
    double spreadRadius = 0.0,
    double blurRadius = 0.0,
  }) =>
      BoxShadow(
        color: color,
        offset: offset,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        blurStyle: BlurStyle.normal,
      );

  static BoxShadow blurSolid({
    Color color = Colors.white,
    Offset offset = Offset.zero,
    double spreadRadius = 0.0,
    double blurRadius = 0.0,
  }) =>
      BoxShadow(
        color: color,
        offset: offset,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        blurStyle: BlurStyle.solid,
      );

  static BoxShadow blurOuter({
    Color color = Colors.white,
    Offset offset = Offset.zero,
    double spreadRadius = 0.0,
    double blurRadius = 0.0,
  }) =>
      BoxShadow(
        color: color,
        offset: offset,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        blurStyle: BlurStyle.outer,
      );

  static BoxShadow blurInner({
    Color color = Colors.white,
    Offset offset = Offset.zero,
    double spreadRadius = 0.0,
    double blurRadius = 0.0,
  }) =>
      BoxShadow(
        color: color,
        offset: offset,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        blurStyle: BlurStyle.inner,
      );
}

///
///
///
///
///
/// [FBorderSide]
///   [FBorderSide.solidInside]
///   [FBorderSide.solidCenter]
///   [FBorderSide.solidOutside]
///
/// [FBorderBox]
///   [FBorderBox.sideSolidCenter]
///   [FBorderBox.directionalSideSolidCenter]
///
/// [FBorderInput]
///   [FBorderInput.outline]
///   [FBorderInput.outlineSolidInside]
///   [FBorderInput.underline]
///
/// [FBorderOutlined]
///   [FBorderOutlined.star]
///   [FBorderOutlined.linear]
///   [FBorderOutlined.stadium]
///   [FBorderOutlined.beveledRectangle]
///   [FBorderOutlined.roundedRectangle]
///   [FBorderOutlined.continuousRectangle]
///   [FBorderOutlined.circle]
///   [FBorderOutlined.oval]
///
/// see https://api.flutter.dev/flutter/painting/ShapeBorder-class.html for more detail about [ShapeBorder]
/// [FBorderOutlined.linear] usually used with [ButtonStyle.shape] by invoking [TextButton.styleFrom]
///
///
///
///
///

// border side
extension FBorderSide on BorderSide {
  static BorderSide solidInside({
    Color color = Colors.blueGrey,
    double width = 1.5,
  }) =>
      BorderSide(
        color: color,
        width: width,
        style: BorderStyle.solid,
        strokeAlign: BorderSide.strokeAlignInside,
      );

  static BorderSide solidCenter({
    Color color = Colors.blueGrey,
    double width = 1.5,
  }) =>
      BorderSide(
        color: color,
        width: width,
        style: BorderStyle.solid,
        strokeAlign: BorderSide.strokeAlignCenter,
      );

  static BorderSide solidOutside({
    Color color = Colors.blueGrey,
    double width = 1.5,
  }) =>
      BorderSide(
        color: color,
        width: width,
        style: BorderStyle.solid,
        strokeAlign: BorderSide.strokeAlignOutside,
      );
}

// box border
extension FBorderBox on BoxBorder {
  static Border sideSolidCenter({
    Color color = Colors.blueGrey,
    double width = 1.5,
  }) =>
      Border.fromBorderSide(
        FBorderSide.solidCenter(color: color, width: width),
      );

  static BorderDirectional directionalSideSolidCenter({
    Color color = Colors.blueGrey,
    double width = 1.5,
  }) {
    final side = FBorderSide.solidCenter(color: color, width: width);
    return BorderDirectional(top: side, start: side, end: side, bottom: side);
  }
}

// input border
extension FBorderInput on InputBorder {
  static OutlineInputBorder outline({
    BorderSide borderSide = const BorderSide(),
    double gapPadding = 4.0,
    required BorderRadius borderRadius,
  }) =>
      OutlineInputBorder(
        borderSide: borderSide,
        borderRadius: borderRadius,
        gapPadding: gapPadding,
      );

  static OutlineInputBorder outlineSolidInside({
    Color color = Colors.blueGrey,
    double width = 1.5,
    double gapPadding = 4.0,
    required BorderRadius borderRadius,
  }) =>
      OutlineInputBorder(
        borderSide: FBorderSide.solidInside(
          color: color,
          width: width,
        ),
        borderRadius: borderRadius,
        gapPadding: gapPadding,
      );

  static UnderlineInputBorder underline({
    BorderSide borderSide = const BorderSide(),
    BorderRadius borderRadius = KGeometry.borderRadius_circularTop_1,
  }) =>
      UnderlineInputBorder(
        borderSide: borderSide,
        borderRadius: borderRadius,
      );
}

// outlined border
extension FBorderOutlined on OutlinedBorder {
  static StarBorder star({
    BorderSide side = BorderSide.none,
    double points = 5,
    double innerRadiusRatio = 0.4,
    double pointRounding = 0,
    double valleyRounding = 0,
    double rotation = 0,
    double squash = 0,
  }) =>
      StarBorder(
        side: side,
        points: points,
        innerRadiusRatio: innerRadiusRatio,
        pointRounding: pointRounding,
        valleyRounding: valleyRounding,
        rotation: rotation,
        squash: squash,
      );

  static LinearBorder linear({
    BorderSide side = BorderSide.none,
    LinearBorderEdge? start,
    LinearBorderEdge? end,
    LinearBorderEdge? top,
    LinearBorderEdge? bottom,
  }) =>
      LinearBorder(
        side: side,
        start: start,
        end: end,
        top: top,
        bottom: bottom,
      );

  static StadiumBorder stadium([BorderSide side = BorderSide.none]) =>
      StadiumBorder(side: side);

  static BeveledRectangleBorder beveledRectangle({
    BorderSide side = BorderSide.none,
    required BorderRadius borderRadius,
  }) =>
      BeveledRectangleBorder(
        side: side,
        borderRadius: borderRadius,
      );

  static RoundedRectangleBorder roundedRectangle({
    BorderSide side = BorderSide.none,
    required BorderRadius borderRadius,
  }) =>
      RoundedRectangleBorder(
        side: side,
        borderRadius: borderRadius,
      );

  static ContinuousRectangleBorder continuousRectangle({
    BorderSide side = BorderSide.none,
    required BorderRadius borderRadius,
  }) =>
      ContinuousRectangleBorder(side: side, borderRadius: borderRadius);

  static CircleBorder circle({
    BorderSide side = BorderSide.none,
    double eccentricity = 0.0,
  }) =>
      CircleBorder(side: side, eccentricity: eccentricity);

  static CircleBorder oval({
    BorderSide side = BorderSide.none,
    double eccentricity = 1.0,
  }) =>
      OvalBorder(side: side, eccentricity: eccentricity);
}

///
///
///
///
///
///
///
///
///
/// [FDecorationBox]
///   [FDecorationBox.rectangle]
///   [FDecorationBox.circle]
///
/// [FDecorationShape]
///   [FDecorationShape.box]
///   [FDecorationShape.input]
///   [FDecorationShape.outlined]
///
/// [FDecorationInput]
///   [FDecorationInput.rowLabelIconText]
///   [FDecorationInput.style1]
///
///
///
///
///
///
///
///

// box decoration
extension FDecorationBox on BoxDecoration {
  static BoxDecoration rectangle({
    Color? color,
    DecorationImage? image,
    Border? border,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    BlendMode? backgroundBlendMode,
  }) =>
      BoxDecoration(
        color: color,
        image: image,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        backgroundBlendMode: backgroundBlendMode,
        shape: BoxShape.rectangle,
      );

  static BoxDecoration circle({
    Color? color,
    DecorationImage? image,
    Border? border,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    BlendMode? backgroundBlendMode,
  }) =>
      BoxDecoration(
        color: color,
        image: image,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        backgroundBlendMode: backgroundBlendMode,
        shape: BoxShape.circle,
      );
}

// shape decoration
extension FDecorationShape on ShapeDecoration {
  static ShapeDecoration box({
    required BoxBorder shape,
    Color? color,
    DecorationImage? image,
    List<BoxShadow>? shadows,
    Gradient? gradient,
  }) =>
      ShapeDecoration(
        shape: shape,
        color: color,
        image: image,
        gradient: gradient,
        shadows: shadows,
      );

  static ShapeDecoration input({
    required InputBorder shape,
    Color? color,
    DecorationImage? image,
    List<BoxShadow>? shadows,
    Gradient? gradient,
  }) =>
      ShapeDecoration(
        shape: shape,
        color: color,
        image: image,
        gradient: gradient,
        shadows: shadows,
      );

  static ShapeDecoration outlined({
    required OutlinedBorder shape,
    Color? color,
    DecorationImage? image,
    List<BoxShadow>? shadows,
    Gradient? gradient,
  }) =>
      ShapeDecoration(
        shape: shape,
        color: color,
        image: image,
        gradient: gradient,
        shadows: shadows,
      );
}

// input decoration
extension FDecorationInput on InputDecoration {
  static InputDecoration rowLabelIconText({
    InputBorder? border,
    required Icon icon,
    required Text text,
  }) =>
      InputDecoration(
        alignLabelWithHint: true,
        border: border,
        contentPadding: switch (border) {
          null => EdgeInsets.zero,
          _ => throw UnimplementedError(),
        },
        label: Row(children: [icon, text]),
      );

  static InputDecoration style1({
    required InputBorder enabledBorder,
  }) =>
      InputDecoration(
        labelStyle: TextStyle(color: Colors.blueGrey),
        enabledBorder: enabledBorder,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.5),
          borderRadius: KGeometry.borderRadius_circularAll_1 * 10,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.5),
          borderRadius: KGeometry.borderRadius_circularAll_1 * 10,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.5),
          borderRadius: KGeometry.borderRadius_circularAll_1 * 10,
        ),
      );
}
