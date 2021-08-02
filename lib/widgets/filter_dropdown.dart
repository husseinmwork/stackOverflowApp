import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/constants/dimens.dart';

class FilterDropDown extends StatelessWidget {
  final String? value;
  final String hint;
  final Function onChanged;
  final double width;
  final List<DropdownMenuItem<String>>? items;

  FilterDropDown(
      {required this.hint,
        required this.onChanged,
        this.value,
      this.width = 120,
        required this.items
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.padding_small),
      width: width,
      height: 37,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(Dimens.border_small),
      ),
      child: DropdownButton(
        value: value,
        icon: Icon(
          Icons.keyboard_arrow_down,

        ),
        underline: Text(""),
        isExpanded: true,
        hint: Text(hint , style: Theme.of(context).textTheme.bodyText1),
        style: Theme.of(context).textTheme.bodyText1,
        items: items,
        onChanged: (value) => onChanged(value),
      ),
    );
  }
}