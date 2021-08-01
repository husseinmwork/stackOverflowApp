import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/constants/dimens.dart';

class FilterDropDown extends StatelessWidget {
  final String? value;
  final String hint;
  final List list;
  final Function onChanged;

  FilterDropDown(
      {required this.hint,
        required this.list,
        required this.onChanged,
        this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.padding_small),
      width: 120,
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
        items: [
          ...list.map((e) {
            return DropdownMenuItem(
              child: Text(e.toString()),
              value: e,
            );
          }).toList(),
        ],
        onChanged: (value) => onChanged(value),
      ),
    );
  }
}