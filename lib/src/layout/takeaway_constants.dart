part of '../../datter.dart';

///
///
/// [KGeometry]
///
/// [KOffsetPermutation4]
///
///

///
/// [size_square_1], ...
/// [offset_square_1], ...
/// [radius_circular_1], ...
/// [edgeInsets_leftBottom_1], ...
/// [borderRadius_0], ...
///
extension KGeometry on Size {
  ///
  ///
  static const Size size_square_1 = Size.square(1);
  static const Size size_w1_h2 = Size(1, 2);
  static const Size size_w2_h3 = Size(2, 3);
  static const Size size_w3_h4 = Size(3, 4);
  static const Size size_w9_h16 = Size(9, 16);
  static const Size size_a4 = Size(21.0, 29.7); // in cm
  static const Size size_a3 = Size(29.7, 42.0);
  static const Size size_a2 = Size(42.0, 59.4);
  static const Size size_a1 = Size(59.4, 84.1);

  ///
  ///
  static const Offset offset_square_1 = Offset(1, 1);
  static const Offset offset_x_1 = Offset(1, 0);
  static const Offset offset_y_1 = Offset(0, 1);
  static const Offset offset_top = Offset(0, -1);
  static const Offset offset_left = Offset(-1, 0);
  static const Offset offset_right = offset_x_1;
  static const Offset offset_bottom = offset_y_1;
  static const Offset offset_center = Offset.zero;
  static const Offset offset_topLeft = Offset(-math.sqrt1_2, -math.sqrt1_2);
  static const Offset offset_topRight = Offset(math.sqrt1_2, -math.sqrt1_2);
  static const Offset offset_bottomLeft = Offset(-math.sqrt1_2, math.sqrt1_2);
  static const Offset offset_bottomRight = Offset(math.sqrt1_2, math.sqrt1_2);

  ///
  ///
  static const Radius radius_circular_1 = Radius.circular(1);
  static const Radius radius_ellipse_x1_y2 = Radius.elliptical(1, 2);
  static const Radius radius_ellipse_x1_y3 = Radius.elliptical(1, 3);
  static const Radius radius_ellipse_x1_y4 = Radius.elliptical(1, 4);
  static const Radius radius_ellipse_x1_y5 = Radius.elliptical(1, 5);
  static const Radius radius_ellipse_x2_y3 = Radius.elliptical(2, 3);

  ///
  ///
  static const EdgeInsets edgeInsets_leftBottom_1 =
  EdgeInsets.only(left: 1, bottom: 1);
  static const EdgeInsets edgeInsets_left_1 = EdgeInsets.only(left: 1);
  static const EdgeInsets edgeInsets_leftTop_1 = EdgeInsets.only(left: 1, top: 1);
  static const EdgeInsets edgeInsets_top_1 = EdgeInsets.only(top: 1);
  static const EdgeInsets edgeInsets_rightTop_1 =
  EdgeInsets.only(right: 1, top: 1);
  static const EdgeInsets edgeInsets_right_1 = EdgeInsets.only(right: 1);
  static const EdgeInsets edgeInsets_rightBottom_1 =
  EdgeInsets.only(right: 1, bottom: 1);
  static const EdgeInsets edgeInsets_bottom_1 = EdgeInsets.only(bottom: 1);
  static const EdgeInsets edgeInsets_horizontal_1 =
  EdgeInsets.symmetric(horizontal: 1);
  static const EdgeInsets edgeInsets_vertical_1 =
  EdgeInsets.symmetric(vertical: 1);
  static const EdgeInsets edgeInsets_all_1 = EdgeInsets.all(1);

  ///
  ///
  ///
  static const BorderRadius borderRadius_0 = BorderRadius.all(Radius.zero);
  static const BorderRadius borderRadius_circularAll_1 =
  BorderRadius.all(KGeometry.radius_circular_1);
  static const BorderRadius borderRadius_circularTopLeft_1 =
  BorderRadius.only(topLeft: KGeometry.radius_circular_1);
  static const BorderRadius borderRadius_circularTopRight_1 =
  BorderRadius.only(topRight: KGeometry.radius_circular_1);
  static const BorderRadius borderRadius_circularBottomLeft_1 =
  BorderRadius.only(bottomLeft: KGeometry.radius_circular_1);
  static const BorderRadius borderRadius_circularBottomRight_1 =
  BorderRadius.only(bottomRight: KGeometry.radius_circular_1);
  static const BorderRadius borderRadius_circularLeft_1 =
  BorderRadius.horizontal(left: KGeometry.radius_circular_1);
  static const BorderRadius borderRadius_circularTop_1 =
  BorderRadius.vertical(top: KGeometry.radius_circular_1);
  static const BorderRadius borderRadius_circularRight_1 =
  BorderRadius.horizontal(right: KGeometry.radius_circular_1);
  static const BorderRadius borderRadius_circularBottom_1 =
  BorderRadius.vertical(bottom: KGeometry.radius_circular_1);
}


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
