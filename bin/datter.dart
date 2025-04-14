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

class _MyHomeState extends State<MyHome> with OverlayStateMixin<MyHome> {
  bool _toggle = false;

  void _onPressed() {
    setState(() => _toggle = !_toggle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorScheme.inversePrimary,
        title: Text('data'),
      ),
      body: Center(
        child: Text('hello'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressed,
      ),
    );
  }
}
