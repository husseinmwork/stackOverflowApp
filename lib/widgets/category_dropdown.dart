import 'package:flutter/material.dart';
import 'package:todo_app/constants/dimens.dart';

class CategoryDropDown extends StatelessWidget {
  final Function? onChange;
  final List<DropdownMenuItem<String>>? item;
  final String? value;
  final String hint;

  const CategoryDropDown({required this.hint ,this.onChange ,  this.item ,  this.value}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.padding_small),
      width: double.infinity,
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
        hint: Text(hint,
            style: Theme.of(context).textTheme.bodyText1),
        style: Theme.of(context).textTheme.bodyText1,
        items: item,
        onChanged: (String? value) {
         onChange!(value);
        },
      ),
    );
  }
}
