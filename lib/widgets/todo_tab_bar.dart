import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/constants/dimens.dart';

class TodoTabBar extends StatelessWidget {

  final TabController tabController;
  final List<Widget> tabs;
  final List<Widget> children;

  const TodoTabBar({required this.tabController,required this.tabs,required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          width: double.infinity,
          child: TabBar(
            controller: tabController,
            labelColor: Colors.white,
            indicator: BoxDecoration(
              color:Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(Dimens.padding_xl),
            ),
            tabs: tabs
          ),
        ),
        Expanded(
          child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
            controller: tabController,
            children: children
          ),
        ),
      ],
    );
  }
}
