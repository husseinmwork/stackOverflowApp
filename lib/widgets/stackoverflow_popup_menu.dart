// This is the type used by the popup menu below.
import 'package:flutter/material.dart';
import 'package:todo_app/constants/dimens.dart';

enum question { delete, edit }

// This menu button widget updates a _selection field (of type WhyFarther,
// not shown here).
class PopUpMenuWidget extends StatefulWidget {
  final Function onSelected;

  PopUpMenuWidget({required this.onSelected});

  @override
  _PopUpMenuWidgetState createState() => _PopUpMenuWidgetState();
}

class _PopUpMenuWidgetState extends State<PopUpMenuWidget> {

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<question>(
      onSelected: (question result) {
        widget.onSelected(result);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<question>>[
        PopupMenuItem<question>(
          value: question.delete,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.delete),
              SizedBox(width: Dimens.padding_mini),
              Text('Delete')
            ],
          ),
        ),
        PopupMenuItem<question>(
          value: question.edit,
          child: Row(
            children: [
              Icon(Icons.edit),
              SizedBox(width: Dimens.padding_mini),
              Text('Edit')
            ],
          ),
        ),
      ],
    );
  }
}
