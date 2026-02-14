import 'package:damath/damath.dart';
import 'package:datter/damath.dart';

void main() {
  print(['1', '2'] == ['1', '2']);
  print(['1', '2'].isEqual(['1', '2']));
  print([1, 3, 5, 4].isOrdered2());
}