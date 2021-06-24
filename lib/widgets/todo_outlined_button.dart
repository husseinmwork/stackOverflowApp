import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants/dimens.dart';

class TodoOutlinedButton extends StatelessWidget {
  final String title;
  final Function onTap;

  const TodoOutlinedButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimens.padding_mid, horizontal: Dimens.padding_mini),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: 2.0, color: Colors.blue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.borderButton),
          ),
        ),
        onPressed: () {
          onTap();
        },
        child:
            Text(title.toString(), style: Theme.of(context).textTheme.caption),
      ),
    );
  }
}
