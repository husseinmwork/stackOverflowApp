import 'package:flutter/material.dart';
import 'package:todo_app/constants/dimens.dart';

class SelectDateWidget extends StatelessWidget {
  /// hint is the upper text
  final String hint;
  /// the text is the text
  final Widget text;
  /// color is the color of [CircleAvatar] background
  final Color color;
  /// on tap action
  final Function onTap;

  const SelectDateWidget({
    required this.hint,
    required this.text,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor:color,
            child: Icon(Icons.date_range, color: Colors.white),
          ),
          SizedBox(width: Dimens.padding_normal),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hint,
                style: Theme.of(context).textTheme.overline,
              ),
              text,
            ],
          ),
        ],
      ),
    );
  }
}
