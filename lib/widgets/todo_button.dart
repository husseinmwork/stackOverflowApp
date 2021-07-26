import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/constants/dimens.dart';

class RoundedButton extends StatelessWidget {
  final Function onPressed;
  final Widget title;
  final bool isIcon;

  const RoundedButton({
    required this.onPressed,
    this.isIcon = false,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          minimumSize: Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.padding_small)),

          primary: Colors.white),
      onPressed: () {
        onPressed();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isIcon
              ? Icon(
                  Icons.email,
                )
              : SizedBox.shrink(),
          SizedBox(
            width: Dimens.padding_small,
          ),

            title,

        ],
      ),
    );
  }
}
