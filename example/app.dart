import 'dart:math';

import 'package:damath/damath.dart';
import 'package:datter/_mationani/_mationani.dart';
import 'package:datter/datter.dart';
import 'package:flutter/material.dart';

void main(List<String> arguments) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
      ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  bool _toggle = false;

  void _onPressed() {
    setState(() => _toggle = !_toggle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorScheme.inversePrimary,
        title: Text('hello'),
      ),
      // body: Center(
      // child: SizedBox.square(
      //   dimension: 200,
      //   child: ColoredBox(color: context.colorScheme.primary),
      // ),
      // ),
      body: Center(
        child: MationaniCuttingAnchored(
          ani: Ani.updateForwardOrReverse(),
          rotation: pi / 6 / DoubleExtension.radian_angle360,
          distance: 0.1,
          child: ColoredBox(
            color: context.colorScheme.primary,
            child: SizedBox.square(dimension: 100),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressed,
        child: Text(_toggle.toString()[0].toUpperCase()),
      ),
    );
  }
}
