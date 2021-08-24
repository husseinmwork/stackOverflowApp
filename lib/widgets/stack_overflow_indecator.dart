
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class StackOverFlowIndecator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitFoldingCube(color: Theme.of(context).accentColor);
  }
}