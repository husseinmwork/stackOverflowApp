import 'package:flutter/material.dart';
import 'package:todo_app/constants/dimens.dart';

class OutlinedButtonS extends StatelessWidget {
  final Function onPressed;
  final String title;
  final Color titleColor;
  final Color borderColor;

  const OutlinedButtonS({
    required this.onPressed,
    required this.title,
    required this.borderColor,
    required this.titleColor
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, 48),
        side: BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.padding_mini)),
      ),
      onPressed: () {
        onPressed();
      },
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .button
            ?.copyWith(color: titleColor),
      ),
    );
  }
}
