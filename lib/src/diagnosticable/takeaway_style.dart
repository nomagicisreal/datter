part of '../../datter.dart';

///
/// [KInterval]
/// [KMaskFilter]
/// [KScaffold]
///
/// [VPaintFill]
/// [VPaintStroke]
/// [VThemeData]
///
///

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
extension KMaskFilter on Paint {
  ///
  ///
  ///
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

  ///
  ///
  ///
  static const MaskFilter solid_05 = MaskFilter.blur(BlurStyle.solid, 0.5);
}

///
///
///
extension KScaffold on Scaffold {
  static const List<FloatingActionButtonLocation> fabLocations = [
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

///
///
///
extension VPaintStroke on Paint {
  static Paint get _stroke => Paint()..style = PaintingStyle.stroke;

  static Paint get capRound => _stroke..strokeCap = StrokeCap.round;

  static Paint get capSquare => _stroke..strokeCap = StrokeCap.square;

  static Paint get capButt => _stroke..strokeCap = StrokeCap.butt;
}

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