import 'package:flutter/material.dart';
import 'package:todo_app/constants/dimens.dart';

class OutlinedButtonS extends StatelessWidget {
  final Function onPressed;
  final Widget title;

  const OutlinedButtonS({
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(double.infinity, 48),
          side: BorderSide(color: Colors.amber),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.padding_small)),
        ),
        onPressed: () {
          onPressed();
        },
        child: title);
  }
}
