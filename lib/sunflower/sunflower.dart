// Copyright 2019 the Dart project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file.

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

const Color primaryColor = Colors.orange;
const TargetPlatform platform = TargetPlatform.android;

class SunflowerPainter extends CustomPainter {
  static const seedRadius = 2.0;
  static const scaleFactor = 4;
  static const tau = math.pi * 2;

  static final inv_phi = 1 / ((math.sqrt(5) + 1) / 2);

  final int seeds;
  final double turns;

  SunflowerPainter(this.seeds, this.turns);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.width / 2;

    for (var i = 0; i < seeds; i++) {
      final theta = i * tau * turns;
      final r = math.sqrt(i) * scaleFactor;
      final x = center + r * math.cos(theta);
      final y = center - r * math.sin(theta);
      final offset = Offset(x, y);
      if (!size.contains(offset)) {
        continue;
      }
      drawSeed(canvas, x, y);
    }
  }

  @override
  bool shouldRepaint(SunflowerPainter oldDelegate) {
    return oldDelegate.seeds != seeds;
  }

  // Draw a small circle representing a seed centered at (x,y).
  void drawSeed(Canvas canvas, double x, double y) {
    final paint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.fill
      ..color = primaryColor;
    canvas.drawCircle(Offset(x, y), seedRadius, paint);
  }
}

class Sunflower extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SunflowerState();
  }
}

class _SunflowerState extends State<Sunflower> {
  double seeds = 100.0, turns = 0.6281;

  int get seedCount => seeds.floor();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        platform: platform,
        brightness: Brightness.dark,
        sliderTheme: SliderThemeData.fromPrimaryColors(
          primaryColor: primaryColor,
          primaryColorLight: primaryColor,
          primaryColorDark: primaryColor,
          valueIndicatorTextStyle: const DefaultTextStyle.fallback().style,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Sunflower"),
        ),
        drawer: Drawer(
          child: ListView(
            children: const [
              DrawerHeader(
                child: Center(
                  child: Text(
                    "Sunflower 🌻",
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                  ),
                ),
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: CustomPaint(
                    painter: SunflowerPainter(seedCount, turns),
                  ),
                ),
              ),
              Text("Showing $seedCount seeds"),
              ConstrainedBox(
                constraints: const BoxConstraints.tightFor(width: 300),
                child: Slider.adaptive(
                  min: 20,
                  max: 1000,
                  value: seeds,
                  onChanged: (newValue) {
                    setState(() {
                      seeds = newValue;
                    });
                  },
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints.tightFor(width: 300),
                child: Slider.adaptive(
                  min: 0,
                  max: 1,
                  value: turns,
                  onChanged: (newValue) {
                    setState(() {
                      turns = newValue;
                    });
                  },
                ),
              ),
              Text("Showing $turns turns"),

              //Button
              // SnakeButton(
              //   child: Text('I am Snake'),
              //   onTap: () {},
              //   snakeColor: Color.fromARGB(255, 138, 229, 117),
              //   borderColor: Color.fromARGB(255, 229, 229, 229),
              // ),
              SizedBox(height: 10),

              SnakeButton(child: Text('Hello'), onTap: () {}),

              //HeatingProgress
            ],
          ),
        ),
      ),
    );
  }
}

class SnakeButton extends StatefulWidget {
  const SnakeButton({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 1),
    this.snakeColor = Colors.purple,
    this.borderColor = Colors.white,
    this.borderWidth = 6.0,
    required this.onTap,
  });

  final Widget child;
  final Duration duration;
  final Color snakeColor;
  final Color borderColor;
  final double borderWidth;
  final VoidCallback onTap;

  @override
  State<SnakeButton> createState() => _SnakeButtonState();
}

class _SnakeButtonState extends State<SnakeButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: CustomPaint(
        painter: SnakePainter(
            animation: _controller,
            borderColor: widget.borderColor,
            borderWidth: widget.borderWidth,
            snakeColor: widget.snakeColor),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: widget.child,
              )),
        ),
      ),
    );
  }
}

class SnakePainter extends CustomPainter {
  final Animation animation;
  final Color snakeColor;
  final Color borderColor;
  final double borderWidth;

  SnakePainter({
    this.snakeColor = Colors.purple,
    this.borderColor = Colors.white,
    this.borderWidth = 4.0,
    required this.animation,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final paint = Paint()
      ..shader = SweepGradient(
        colors: [
          snakeColor,
          Colors.transparent,
        ],
        stops: const [
          0.7,
          1.0,
        ],
        startAngle: 0,
        endAngle: vector.radians(180),
        transform: GradientRotation(vector.radians(360.0 * animation.value)),
      ).createShader(rect);

    final path = Path.combine(
      PathOperation.xor,
      Path()..addRect(rect),
      Path()
        ..addRect(
          rect.deflate(borderWidth),
        ),
    );

    canvas.drawRect(
      rect.deflate(borderWidth / 2),
      Paint()
        ..color = borderColor
        ..strokeWidth = borderWidth
        ..style = PaintingStyle.stroke,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
