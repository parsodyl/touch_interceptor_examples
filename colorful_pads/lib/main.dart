import 'package:flutter/material.dart';
import 'package:touch_interceptor/touch_interceptor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Move over the pads'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TouchInterceptor(
        child: Wrap(
          children: List.generate(20, (_) => const _ColorfulPad()),
        ),
      ),
    );
  }
}

class _ColorfulPad extends StatefulWidget {
  const _ColorfulPad({Key? key}) : super(key: key);

  @override
  State<_ColorfulPad> createState() => _ColorfulPadState();
}

class _ColorfulPadState extends State<_ColorfulPad> {
  bool _highlighted = false;

  void _in() {
    if (_highlighted) return;
    setState(() => _highlighted = true);
  }

  void _out() {
    if (!_highlighted) return;
    setState(() => _highlighted = false);
  }

  @override
  Widget build(BuildContext context) {
    return TouchConsumer(
      onTouchDown: _in,
      onTouchUp: _out,
      onTouchEnter: _in,
      onTouchExit: _out,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: _highlighted ? Colors.green : Colors.purple,
          shape: BoxShape.circle,
        ),
        width: _highlighted ? 100 : 50,
        height: _highlighted ? 100 : 50,
      ),
    );
  }
}
