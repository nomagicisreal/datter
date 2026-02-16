part of '../../datter.dart';

///
///
/// [FBoxConstraints]
/// [FBoxShadow]
/// [FBorderSide], [FBorderBox], [FBorderInput], [FBorderOutlined]
/// [FDecorationInput]
///
///

///
///
///
extension FBoxConstraints on BoxConstraints {
  static double shortSide(BoxConstraints constraints) =>
      math.min(constraints.maxHeight, constraints.maxWidth);

  static BoxConstraints keep(BoxConstraints v) => v;

  static BoxConstraints keepLoosen(BoxConstraints constraints) =>
      constraints.loosen();
}

///
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
/// subtypes of [OutlinedBorder]:
///   [StarBorder]
///   [LinearBorder]
///   [StadiumBorder]
///   [BeveledRectangleBorder]
///   [RoundedRectangleBorder]
///   [ContinuousRectangleBorder]
///   [CircleBorder]
///   [OvalBorder]
///
/// see https://api.flutter.dev/flutter/painting/ShapeBorder-class.html for more detail about [ShapeBorder]
/// [FBorderOutlined.linear] usually used with [ButtonStyle.shape] by invoking [TextButton.styleFrom]
///
///
///
///
///
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

///
///
/// [rowLabelIconText], ...
/// [style1], ...
///
///
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
