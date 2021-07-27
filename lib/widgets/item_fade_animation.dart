
import 'package:flutter/material.dart';

class ItemFader extends StatefulWidget {
  final Widget child;
  final int duration;

  const ItemFader({Key? key, required this.child, required this.duration})
      : super(key: key);

  @override
  _ItemFaderState createState() => _ItemFaderState();
}

class _ItemFaderState extends State<ItemFader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  double position = 1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    show();
  }

  void show() {
    setState(() => position = 1);
    _animationController.forward();
  }

  void hide() {
    setState(() => position = -1);
    _animationController.reverse();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, 64 * position * (1 - _animation.value)),
        child: Opacity(
          opacity: _animation.value,
          child: widget.child,
        ),
      ),
    );
  }
}
