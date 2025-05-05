import 'package:damath/damath.dart';

void main() {
  final hello = Hello(['123', 'abc']);
  final world = hello.call();
  world.doSomething();
  print(hello.value);
  print(hello.value == world.value);
  print(['1', '2'] == ['1', '2']);
  print(['1', '2'].isEqualTo(['1', '2']));
}


class Hello {
  final List<String> value;
  const Hello(this.value);

  World call() => World(value);
}

class World {
  final List<String> value;
  const World(this.value);
  void doSomething() => value..add('value');
}