import 'dart:math';

import 'package:flutter/material.dart';

abstract class Shape {
  Path build({Rect rect, double scale});
}

abstract class BorderShape {
  void drawBorder(Canvas canvas, Rect rect);
}

class ShapeOfViewBorder extends ShapeBorder {
  final Shape? shape;

  ShapeOfViewBorder({this.shape}) : assert(shape != null);

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(0);
  }

  @override
  ShapeBorder scale(double t) => this;


  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return null!;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return shape!.build(rect: rect, scale: 1);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (shape is BorderShape) {
      (shape as BorderShape).drawBorder(canvas, rect);
    }
  }

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) return false;
    final ShapeOfViewBorder typedOther = other;
    return shape == typedOther.shape;
  }

  @override
  int get hashCode => shape.hashCode;

  @override
  String toString() {
    return '$runtimeType($shape)';
  }
}

class ShapeOfView extends StatelessWidget {
  final Widget? child;
  final Shape? shape;
  final double elevation;
  final Clip clipBehavior;
  final double? height;
  final double? width;

  ShapeOfView({

    this.child,
    this.elevation = 4,
    this.shape,
    this.clipBehavior = Clip.antiAlias,
    this.width,
    this.height,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: ShapeOfViewBorder(shape: this.shape),
      clipBehavior: this.clipBehavior,
      elevation: this.elevation,
      child: Container(
        height: this.height,
        width: this.width,
        child: this.child,
      ),
    );
  }
}






class PolygonShape extends Shape {
  final int numberOfSides;

  PolygonShape({this.numberOfSides = 5}) : assert(numberOfSides >= 3);

  @override
  Path build({Rect? rect, double? scale}) {
    return generatePath(rect: rect!);
  }

  Path generatePath({bool? useBezier, Rect? rect}) {
    final height = rect!.height;
    final width = rect.width;

    final double section = (2.0 * pi / numberOfSides);
    final double polygonSize = min(width, height);
    final double radius = polygonSize / 2;
    final double centerX = width / 2;
    final double centerY = height / 2;

    final Path polygonPath = new Path();
    polygonPath.moveTo(
        (centerX + radius * cos(0)), (centerY + radius * sin(0)));

    for (int i = 1; i < numberOfSides; i++) {
      polygonPath.lineTo((centerX + radius * cos(section * i)),
          (centerY + radius * sin(section * i)));
    }

    polygonPath.close();
    return polygonPath;
  }
}