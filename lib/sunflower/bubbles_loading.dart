import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vector;

const mainColor = Color(0xFF5112AA);
const secColor = Color(0xFFBC53FA);
const bgColor = Color(0xFFfce7fe);

enum BubbleState {
  initial,
  start,
  end,
}

const d500 = Duration(milliseconds: 500);

class BubblesHome extends StatefulWidget {
  const BubblesHome({super.key});

  @override
  State<BubblesHome> createState() => _BubblesHomeState();
}

class _BubblesHomeState extends State<BubblesHome>
    with SingleTickerProviderStateMixin {
  //
  //
  late AnimationController animCtrl;
  late Animation<double> progressAnim;
  late Animation<double> cloudAnim;
  late Animation<double> endAnim;

  BubbleState currentState = BubbleState.initial;

  void onAnimStart() {
    animCtrl.forward();
  }

  @override
  void initState() {
    super.initState();
    animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    );

    progressAnim = CurvedAnimation(
      parent: animCtrl,
      curve: const Interval(
        0.0,
        0.65,
      ),
    );

    cloudAnim = CurvedAnimation(
      parent: animCtrl,
      curve: const Interval(
        0.7,
        0.85,
      ),
    );

    endAnim = CurvedAnimation(
      parent: animCtrl,
      curve: const Interval(
        0.8,
        1.0,
      ),
    );
  }

  @override
  void dispose() {
    animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: bgColor,
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Stack(
            children: [
              //
              if (currentState == BubbleState.end)
                Expanded(
                  child: TweenAnimationBuilder(
                    tween: Tween(
                      begin: 0.0,
                      end: 1.0,
                    ),
                    duration: d500,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: child,
                      );
                    },
                    child: Column(
                      children: [
                        Text('🦄'),
                        ProgressCounter(progressAnim),
                      ],
                    ),
                  ),
                ),
              //
              if (currentState != BubbleState.end)
                Expanded(
                  child: TweenAnimationBuilder(
                    tween: Tween(
                      begin: 1.0,
                      end: currentState != BubbleState.initial ? 0.0 : 1.0,
                    ),
                    duration: d500,
                    onEnd: () {
                      setState(() {
                        currentState = BubbleState.end;
                      });
                    },
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0.0, 50 * value),
                          child: child,
                        ),
                      );
                    },
                    child: Text('🦖'),
                  ),
                ),

              //
              Container(
                alignment: Alignment.bottomCenter,
                child: AnimatedSwitcher(
                  duration: d500,
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        currentState = BubbleState.start;
                      });
                      onAnimStart();
                    },
                    child: currentState == BubbleState.initial
                        ? const Text('Hello')
                        : const Text('BubbleBubbleBubble'),
                  ),
                ),
              ),

              //
              CloudBurst(
                progressAnim: progressAnim,
                cloudAnim: cloudAnim,
              ),

              //
              End(endAnim)
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressCounter extends AnimatedWidget {
  const ProgressCounter(Animation<double> anim, {super.key})
      : super(listenable: anim);

  double get value => (listenable as Animation).value;

  @override
  Widget build(BuildContext context) {
    return Text(
      (value * 100).truncate().toString(),
    );
  }
}

class Bubble {
  final Color color;
  final double direction;
  final double speed;
  final double size;
  final double initialpos;

  Bubble({
    required this.color,
    required this.direction,
    required this.speed,
    required this.size,
    required this.initialpos,
  });
}

class CloudBurst extends StatelessWidget {
  final Animation<double> progressAnim, cloudAnim;

  CloudBurst({
    super.key,
    required this.progressAnim,
    required this.cloudAnim,
  });

  final bubbles = List<Bubble>.generate(
      500,
      (index) => Bubble(
            color: math.Random().nextBool() ? mainColor : secColor,
            direction: math.Random().nextInt(250) *
                (math.Random().nextBool() ? 1 : -1),
            speed: math.Random().nextInt(50) + 1,
            size: math.Random().nextInt(20) + 5,
            initialpos: index * 10,
          ));

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([progressAnim, cloudAnim]),
      builder: (context, child) {
        final queryData = MediaQuery.of(context).size;
        final size = queryData.width * 0.5;
        final circleSize = size * (progressAnim.value + 1);
        final topPosition = queryData.height * 0.45;
        final centerMargin = queryData.width - circleSize;
        final leftSize = size * 0.6 * (1 - progressAnim.value);
        final rightSize = size * 0.7 * (1 - progressAnim.value);
        final leftMargin = queryData.width / 2 - leftSize;
        final rightMargin = queryData.width / 2 - rightSize;

        return Positioned(
          left: 0,
          right: 0,
          top: topPosition,
          height: size,
          child: Stack(
            children: [
              Positioned(
                height: rightSize,
                width: rightSize,
                bottom: 0,
                right: rightMargin / 2,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                ),
              ),
              Positioned(
                height: leftSize,
                width: leftSize,
                bottom: 0,
                left: leftMargin / 2,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                ),
              ),
              Positioned(
                height: circleSize,
                width: circleSize,
                left: centerMargin / 2,
                child: ClipOval(
                  child: CustomPaint(
                    foregroundPainter: CloudPainter(progressAnim, bubbles),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CloudPainter extends CustomPainter {
  CloudPainter(this.cloudAnim, this.bubbles) : super(repaint: cloudAnim);

  final Animation<double> cloudAnim;
  final List<Bubble> bubbles;

  @override
  void paint(Canvas canvas, Size size) {
    bubbles.forEach((b) {
      final offset = Offset(
        size.width / 2 + b.direction * cloudAnim.value,
        size.height * 1.2 * (1 - cloudAnim.value) -
            b.speed * cloudAnim.value +
            b.initialpos * (1 - cloudAnim.value),
      );
      canvas.drawCircle(offset, b.size, Paint()..color = b.color);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class End extends AnimatedWidget {
  const End(Animation<double> endAnim, {super.key})
      : super(listenable: endAnim);

  Animation<double> get anim => (listenable as Animation<double>);

  @override
  Widget build(BuildContext context) {
    return anim.value > 0
        ? SafeArea(
            child: Column(
              children: [
                SizedBox(height: 200),
                const Text('Completed'),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Cancel'),
                ),
                CustomPaint(
                  foregroundPainter: TikTok(anim),
                  child: Container(
                    height: 200,
                    width: 200,
                  ),
                )
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}

class TikTok extends CustomPainter {
  TikTok(this.anim) : super(repaint: anim);

  final Animation<double> anim;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = mainColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final circlePath = Path();
    circlePath.addArc(
      Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: size.width,
          height: size.height),
      vector.radians(-90.0),
      vector.radians(360 * anim.value),
    );

    final leftLine = size.width * 0.2;
    final rightLine = size.width * 0.3;

    final leftPercent = anim.value > 0.5 ? 1.0 : anim.value / 0.5;
    final rightPercent = anim.value < 0.5 ? 0.0 : (anim.value - 0.5) / 0.5;

    canvas.save();

    canvas.translate(size.width / 3, size.height / 2);
    canvas.rotate(vector.radians(-45));

    canvas.drawLine(Offset.zero, Offset(0, leftLine * leftPercent), paint);
    canvas.drawLine(
        Offset(0, leftLine), Offset(rightLine * rightPercent, leftLine), paint);

    canvas.restore();

    canvas.drawPath(circlePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
