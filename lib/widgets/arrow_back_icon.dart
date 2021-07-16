import 'package:flutter/material.dart';
import 'package:todo_app/constants/dimens.dart';

class ArrowBackIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFF5E6272),
            ),
            borderRadius: BorderRadius.circular(Dimens.borderIcon)),
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
