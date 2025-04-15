import 'dart:developer';

// import 'package:damath/damath.dart';

void main() {
  final list = List.of([1, 2], growable: false);
  list.removeAt(0);
  log(list.toString());
}
