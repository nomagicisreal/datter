///
///
/// this file contains:
///
/// [KOffsetPermutation4], [KMapperCubicPointsPermutation]
///
/// [KInterval]
/// [KMaskFilter]
/// [KFloatingActionButton]
///
///
/// [VPaintFill], [VPaintStroke]
/// [VThemeData]
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
part of '../../datter.dart';
// ignore_for_file: non_constant_identifier_names, constant_identifier_names

///
///
///
/// offset
///
///
///
extension KOffsetPermutation4 on List<Offset> {
  // 0, 1, 2, 3
  // 1, 2, 3, a (add a, remove a)
  // 2, 3, a, b
  // 3, a, 1, c
  static List<Offset> p0123(List<Offset> list) => list;

  static List<Offset> p1230(List<Offset> list) => list..cloneSwitch();

  static List<Offset> p2301(List<Offset> list) => p1230(list)..cloneSwitch();

  static List<Offset> p3012(List<Offset> list) => p2301(list)..cloneSwitch();

  // a, 2, 3, b (add 1, remove b)
  // 2, 3, 1, a
  // 3, 1, a, c
  // 1, a, 2, d
  static List<Offset> p0231(List<Offset> list) => list
    ..add(list[1])
    ..removeAt(1);

  static List<Offset> p2310(List<Offset> list) => p0231(list)..cloneSwitch();

  static List<Offset> p3102(List<Offset> list) => p2310(list)..cloneSwitch();

  static List<Offset> p1023(List<Offset> list) => p3102(list)..cloneSwitch();

  // 0, 1, 3, 2 (add 2, remove 2)
  // 1, 3, 2, 0
  // 3, 2, 0, 1
  // 2, 0, 1, 3
  static List<Offset> p0132(List<Offset> list) => list
    ..add(list[2])
    ..removeAt(2);

  static List<Offset> p1320(List<Offset> list) => p0132(list)..cloneSwitch();

  static List<Offset> p3201(List<Offset> list) => p1320(list)..cloneSwitch();

  static List<Offset> p2013(List<Offset> list) => p3201(list)..cloneSwitch();

  // 1, 3, 0, 2 (add 02, remove 02)
  // 3, 0, 2, 1
  // 0, 2, 1, 3
  // 2, 1, 3, 0
  static List<Offset> p1302(List<Offset> list) => p1230(list)
    ..add(list[1])
    ..removeAt(1);

  static List<Offset> p3021(List<Offset> list) => p1302(list)..cloneSwitch();

  static List<Offset> p0213(List<Offset> list) => p3021(list)..cloneSwitch();

  static List<Offset> p2130(List<Offset> list) => p0213(list)..cloneSwitch();

  // 0, 3, 1, 2 (add 12, remove 12)
  // 3, 1, 2, 0
  // 1, 2, 0, 3
  // 2, 0, 3, 1
  static List<Offset> p0312(List<Offset> list) => p0231(list)
    ..add(list[1])
    ..removeAt(1);

  static List<Offset> p3120(List<Offset> list) => p0312(list)..cloneSwitch();

  static List<Offset> p1203(List<Offset> list) => p3120(list)..cloneSwitch();

  static List<Offset> p2031(List<Offset> list) => p1203(list)..cloneSwitch();

  // 0, 3, 2, 1 (add 21, remove 21)
  // 3, 2, 1, 0
  // 2, 1, 0, 3
  // 1, 0, 3, 2
  static List<Offset> p0321(List<Offset> list) => p0132(list)
    ..add(list[1])
    ..removeAt(1);

  static List<Offset> p3210(List<Offset> list) => p0321(list)..cloneSwitch();

  static List<Offset> p2103(List<Offset> list) => p3210(list)..cloneSwitch();

  static List<Offset> p1032(List<Offset> list) => p2103(list)..cloneSwitch();
}

extension KMapperCubicPointsPermutation on Applier<Map<Offset, List<Offset>>> {
  static const Applier<Map<Offset, List<Offset>>> p0231 = _0231;
  static const Applier<Map<Offset, List<Offset>>> p1230 = _1230;

  static Map<Offset, List<Offset>> _0231(Map<Offset, List<Offset>> points) =>
      points.map(
        (points, cubicPoints) => MapEntry(
          points,
          KOffsetPermutation4.p0231(cubicPoints),
        ),
      );

  static Map<Offset, List<Offset>> _1230(Map<Offset, List<Offset>> points) =>
      points.map(
        (points, cubicPoints) => MapEntry(
          points,
          KOffsetPermutation4.p1230(cubicPoints),
        ),
      );

  static Applier<Map<Offset, List<Offset>>> of(Applier<List<Offset>> mapping) =>
      (points) => points
          .map((points, cubicPoints) => MapEntry(points, mapping(cubicPoints)));
}

///
///
///
///
///
///
/// radius, border radius
///
///
///
///
///
///

///
///
///
/// curve, interval
///
///
///
extension KInterval on Interval {
  static const easeInOut_00_04 = Interval(0, 0.4, curve: Curves.easeInOut);
  static const easeInOut_00_05 = Interval(0, 0.5, curve: Curves.easeInOut);
  static const easeOut_00_06 = Interval(0, 0.6, curve: Curves.easeOut);
  static const easeInOut_02_08 = Interval(0.2, 0.8, curve: Curves.easeInOut);
  static const easeInOut_04_10 = Interval(0.4, 1, curve: Curves.easeInOut);
  static const fastOutSlowIn_00_05 =
      Interval(0, 0.5, curve: Curves.fastOutSlowIn);
}

///
///
///
/// mask filter
///
///
///

extension KMaskFilter on Paint {
  /// normal
  static const MaskFilter normal_05 = MaskFilter.blur(BlurStyle.normal, 0.5);
  static const MaskFilter normal_1 = MaskFilter.blur(BlurStyle.normal, 1);
  static const MaskFilter normal_2 = MaskFilter.blur(BlurStyle.normal, 2);
  static const MaskFilter normal_3 = MaskFilter.blur(BlurStyle.normal, 3);
  static const MaskFilter normal_4 = MaskFilter.blur(BlurStyle.normal, 4);
  static const MaskFilter normal_5 = MaskFilter.blur(BlurStyle.normal, 5);
  static const MaskFilter normal_6 = MaskFilter.blur(BlurStyle.normal, 6);
  static const MaskFilter normal_7 = MaskFilter.blur(BlurStyle.normal, 7);
  static const MaskFilter normal_8 = MaskFilter.blur(BlurStyle.normal, 8);
  static const MaskFilter normal_9 = MaskFilter.blur(BlurStyle.normal, 9);
  static const MaskFilter normal_10 = MaskFilter.blur(BlurStyle.normal, 10);

  /// solid
  static const MaskFilter solid_05 = MaskFilter.blur(BlurStyle.solid, 0.5);
}

///
///
/// floating action button
///
///
extension KFloatingActionButton on FloatingActionButton {
  static const List<FloatingActionButtonLocation> locations = [
    FloatingActionButtonLocation.miniStartTop,
    FloatingActionButtonLocation.miniStartDocked,
    FloatingActionButtonLocation.miniStartFloat,
    FloatingActionButtonLocation.miniCenterTop,
    FloatingActionButtonLocation.miniCenterDocked,
    FloatingActionButtonLocation.miniCenterFloat,
    FloatingActionButtonLocation.miniEndTop,
    FloatingActionButtonLocation.miniEndDocked,
    FloatingActionButtonLocation.miniEndFloat,
    FloatingActionButtonLocation.startTop,
    FloatingActionButtonLocation.startDocked,
    FloatingActionButtonLocation.startFloat,
    FloatingActionButtonLocation.centerTop,
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
    FloatingActionButtonLocation.endTop,
    FloatingActionButtonLocation.endDocked,
    FloatingActionButtonLocation.endFloat,
    FloatingActionButtonLocation.endContained,
  ];
}

///
///
///
///
/// value
///
///
///
///

//
extension VPaintFill on Paint {
  static Paint get _fill => Paint()..style = PaintingStyle.fill;

  ///
  /// blur
  ///
  static Paint get blurNormal_05 => _fill..maskFilter = KMaskFilter.normal_05;

  static Paint get blurNormal_1 => _fill..maskFilter = KMaskFilter.normal_1;

  static Paint get blurNormal_2 => _fill..maskFilter = KMaskFilter.normal_2;

  static Paint get blurNormal_3 => _fill..maskFilter = KMaskFilter.normal_3;

  static Paint get blurNormal_4 => _fill..maskFilter = KMaskFilter.normal_4;

  static Paint get blurNormal_5 => _fill..maskFilter = KMaskFilter.normal_5;
}

//
extension VPaintStroke on Paint {
  static Paint get _stroke => Paint()..style = PaintingStyle.stroke;

  static Paint get capRound => _stroke..strokeCap = StrokeCap.round;

  static Paint get capSquare => _stroke..strokeCap = StrokeCap.square;

  static Paint get capButt => _stroke..strokeCap = StrokeCap.butt;
}

///
///
///
/// theme
///
///
///

extension VThemeData on ThemeData {
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      );

  static ThemeData get style1 {
    const primaryBrown = Color.fromARGB(255, 189, 166, 158);
    const secondaryBrown = Color.fromARGB(255, 109, 92, 90);
    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryBrown,
      primarySwatch: Colors.brown,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryBrown,
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: primaryBrown,
        selectedItemColor: Colors.black,
        elevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: secondaryBrown,
        elevation: 10,
      ),
      textTheme: const TextTheme(
          // headlineSmall, Medium, Large, 1-6:
          // bodySmall, Medium, Large, 1-3:
          ),
    );
  }
}