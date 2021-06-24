import 'package:flutter/material.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/constants/gradient.dart';

class AllTags extends StatelessWidget {
  final List? taskTags;

  const AllTags({required this.taskTags});

  @override
  Widget build(BuildContext context) {
    return taskTags == null
        ? SizedBox.shrink()
        : Container(
            height: 30,
            width: double.infinity,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
                horizontal: Dimens.padding_mini, vertical: Dimens.padding_mini),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: taskTags!.length,
              itemBuilder: (_, index) => Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    horizontal: Dimens.padding_mini,
                    vertical: Dimens.padding_mini),
                padding: EdgeInsets.symmetric(horizontal: Dimens.padding_large),
                decoration: BoxDecoration(
                  gradient: AppGradient.purpleGradient,
                  borderRadius: BorderRadius.circular(Dimens.borderButton),
                ),
                child: Text("${taskTags![index].name}",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(color: Colors.white)),
              ),
            ),
          );
  }
}
