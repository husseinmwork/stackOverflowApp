import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/constants/dimens.dart';

class RoundedButton extends StatelessWidget {
  final Function onPressed;
  final String title;

  final bool? loading;

  const RoundedButton(
      {required this.onPressed, required this.title, this.loading});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          minimumSize: Size(double.infinity, 48),
          primary: Colors.white),
      onPressed: () {
        onPressed();
      },
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(color: Colors.black),
            ),
            loading == true
                ? SizedBox(
                    width: Dimens.padding_small,
                  )
                : SizedBox.shrink(),
            Visibility(
              visible: loading == true,
              child: SizedBox(
                  height: 28,
                  width: 28,
                  child: CircularProgressIndicator(backgroundColor: Colors.black)),
            )
          ],
        ),

    );
  }
}
