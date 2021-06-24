
import 'package:flutter/material.dart';

class StaggeredRaindropAnimation {
  StaggeredRaindropAnimation(this.controller)
      : dropSize = Tween<double>(begin: 0, end: maximumDropSize).animate(
    CurvedAnimation(
      parent: controller,
      curve: Interval(0.0, 0.2, curve: Curves.easeIn),
    ),
  ),
        dropPosition =
        Tween<double>(begin: 0, end: maximumRelativeDropY).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.2, 0.5, curve: Curves.easeIn),
          ),
        ),
        holeSize = Tween<double>(begin: 0, end: maximumHoleSize).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.5, 1.0, curve: Curves.easeIn),
          ),
        ),
        dropVisible = Tween<bool>(begin: true, end: false).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.5, 0.5),
          ),
        ),
        textOpacity = Tween<double>(begin: 1, end: 0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.5, 0.7, curve: Curves.easeOut),
          ),
        );

  final AnimationController controller;

  final Animation<double> dropSize;
  final Animation<double> dropPosition;
  final Animation<bool> dropVisible;
  final Animation<double> holeSize;
  final Animation<double> textOpacity;

  static final double maximumDropSize = 20;
  static final double maximumRelativeDropY = 0.5;
  static final double maximumHoleSize = 10;
}

class AnimationScreen extends StatefulWidget {
  AnimationScreen({required this.color});

  final Color color;

  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  Size size = Size.zero;
  AnimationController? _controller;
  StaggeredRaindropAnimation? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _animation = StaggeredRaindropAnimation(_controller!);
    _controller!.forward();

    _controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    setState(() {
      size = MediaQuery.of(context).size;
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
              painter: HolePainter(
                  color: widget.color,
                  holeSize: _animation!.holeSize.value * size.width))),
      Positioned(
          top: _animation!.dropPosition.value * size.height,
          left: size.width / 2 - _animation!.dropSize.value / 2,
          child: SizedBox(
              width: _animation!.dropSize.value,
              height: _animation!.dropSize.value,
              child: CustomPaint(
                painter: DropPainter(visible: _animation!.dropVisible.value),
              ))),
      Padding(
          padding: EdgeInsets.only(bottom: 32),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Opacity(
                  opacity: _animation!.textOpacity.value,
                  child: Text(
                    'Raindrop Software',
                    style: TextStyle(color: Colors.white, fontSize: 32),
                  ))))
    ]);
  }

  @override
  void dispose() {
    super.dispose();

    _controller!.dispose();
  }
}

class DropPainter extends CustomPainter {
  DropPainter({this.visible = true});

  bool visible;

  @override
  void paint(Canvas canvas, Size size) {
    if (!visible) {
      return;
    }

    Path path = new Path();
    path.moveTo(size.width / 2, 0);
    path.quadraticBezierTo(0, size.height * 0.8, size.width / 2, size.height);
    path.quadraticBezierTo(size.width, size.height * 0.8, size.width / 2, 0);
    canvas.drawPath(path, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class HolePainter extends CustomPainter {
  HolePainter({
    required this.color,
    required this.holeSize,
  });

  Color color;
  double holeSize;

  @override
  void paint(Canvas canvas, Size size) {
    double radius = holeSize / 2;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    Rect outerCircleRect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius);
    Rect innerCircleRect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius / 2);

    Path transparentHole = Path.combine(
      PathOperation.difference,
      Path()..addRect(rect),
      Path()
        ..addOval(outerCircleRect)
        ..close(),
    );

    Path halfTransparentRing = Path.combine(
      PathOperation.difference,
      Path()
        ..addOval(outerCircleRect)
        ..close(),
      Path()
        ..addOval(innerCircleRect)
        ..close(),
    );

    canvas.drawPath(transparentHole, Paint()..color = color);
    canvas.drawPath(
        halfTransparentRing, Paint()..color = color.withOpacity(0.5));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
