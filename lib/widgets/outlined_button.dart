import 'package:flutter/material.dart';
import 'package:todo_app/constants/dimens.dart';

class OutlinedButtonS extends StatelessWidget {
  final Function onPressed;
  final String title;

  const OutlinedButtonS({
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, 48),
        side: BorderSide(color: Theme.of(context).accentColor),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.padding_small)),
      ),
      onPressed: () {
        onPressed();
      },
      child: Text(
        "Sign Up".toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .button
            ?.copyWith(color: Theme.of(context).accentColor),
      ),
    );
  }
}
