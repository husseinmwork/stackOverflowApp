import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/packages/textfield_tags.dart';
import 'package:todo_app/store/home/home_store.dart';
import 'package:todo_app/widgets/filter_dropdown.dart';
import 'package:todo_app/widgets/todo_button.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  //filter section
  String? _valueMinVotes;
  String? _valueMaxVotes;
  String? _valueMinViews;
  String? _valueMaxViews;

  final List<String> _minVotes = ['10', '20', '30', '40', '50'];
  final List<String> _maxVotes = ['100', '110', '120', '130', '140'];
  final List<String> _minViews = ['10', '20', '30', '40', '50'];
  final List<String> _maxViews = ['100', '110', '120', '130', '140'];

  ///tags
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  late PersistentBottomSheetController _controller;

  ///end tag

  late HomeStore _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<HomeStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: Dimens.padding_normal, horizontal: Dimens.padding_xxl),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  _buildTags(),
                  SizedBox(height: Dimens.padding_large),
                  _buildVotes(),
                  SizedBox(height: Dimens.padding_normal),
                  _buildViews(),
                  SizedBox(height: Dimens.padding_xxl),
                  _buildSelectCategory(),
                  SizedBox(height: Dimens.padding_xxl),
                ],
              ),
              RoundedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // _store.getQuestion(skip);
                    _store.pagingController.refresh();
                  },
                  title: 'Show Result')
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVotes() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Min Votes", style: Theme.of(context).textTheme.subtitle2),
              SizedBox(height: Dimens.padding_mini),
              FilterDropDown(
                items: [
                  ..._minVotes.map((e) {
                    return DropdownMenuItem(
                      child: Text(e.toString()),
                      value: e,
                    );
                  }).toList(),
                ],
                value: _valueMinVotes,
                hint: "1",
                onChanged: (value) {
                  setState(() {
                    _valueMinVotes = value;
                  });
                  _store.minVotes = int.parse("$_valueMinVotes");
                },
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Max Votes", style: Theme.of(context).textTheme.subtitle2),
              SizedBox(height: Dimens.padding_mini),
              FilterDropDown(
                items: [
                  ..._maxVotes.map((e) {
                    return DropdownMenuItem(
                      child: Text(e.toString()),
                      value: e,
                    );
                  }).toList(),
                ],
                value: _valueMaxVotes,
                hint: "1",
                onChanged: (value) {
                  setState(() {
                    _valueMaxVotes = value;
                  });
                  _store.maxVotes = int.parse("$_valueMaxVotes");
                },
              ),
            ],
          ),
        ],
      );

  Widget _buildViews() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Min Views", style: Theme.of(context).textTheme.subtitle2),
              SizedBox(height: Dimens.padding_mini),
              FilterDropDown(
                items: [
                  ..._minViews.map((e) {
                    return DropdownMenuItem(
                      child: Text(e.toString()),
                      value: e,
                    );
                  }).toList(),
                ],
                value: _valueMinViews,
                hint: "1",
                onChanged: (value) {
                  setState(() {
                    _valueMinViews = value;
                  });
                  _store.minViews = int.parse("$_valueMinViews");
                },
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Max Views", style: Theme.of(context).textTheme.subtitle2),
              SizedBox(height: Dimens.padding_mini),
              FilterDropDown(
                items: [
                  ..._maxViews.map((e) {
                    return DropdownMenuItem(
                      child: Text(e.toString()),
                      value: e,
                    );
                  }).toList(),
                ],
                value: _valueMaxViews,
                hint: "1",
                onChanged: (value) {
                  setState(() {
                    _valueMaxViews = value;
                  });
                  _store.maxViews = int.parse("$_valueMaxViews");
                },
              ),
            ],
          ),
        ],
      );

  Widget _buildTags() => Observer(
        builder: (_) => TagEditor(
          length: _store.tags.length,
          controller: _textEditingController,
          focusNode: _focusNode,
          delimiters: [',', ' '],
          hasAddButton: true,
          resetTextOnSubmitted: true,
          // This is set to grey just to illustrate the `textStyle` prop
          textStyle: const TextStyle(color: Colors.grey),
          onSubmitted: (outstandingValue) {
            if (_store.tags.length < 5) {
              setState(() {
                _store.tags.add(outstandingValue);
              });
            }
          },
          maxLength: 20,
          inputDecoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            hintText: 'Hint Text...',
            labelText: "Enter 5 tags or less",
            // errorText: "Please enter 5 tags or less"
          ),
          onTagChanged: (String newValue) {
            //  print("hhhhhhhhhhhhhh${newValue}");
            // if(_values.length < 5){
            //              setState(() {
            //                _values.add(newValue);
            //              });
            //
            // }
          },
          tagBuilder: (context, index) => Chip(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            labelPadding: EdgeInsets.zero,
            label: Text(_store.tags[index]),
            deleteIcon: const Icon(
              Icons.close,
              size: 18,
            ),
            onDeleted: () {
              setState(() {
                _store.tags.removeAt(index);
              });
            },
          ),
        ),
      );

  Widget _buildSelectCategory() => Visibility(
        visible: _store.category.isNotEmpty,
        child: Observer(
          builder: (_) => Container(
            padding: EdgeInsets.symmetric(horizontal: Dimens.padding_small),
            width: double.infinity,
            height: 37,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(Dimens.border_small),
            ),
            child: DropdownButton(
              value: _store.categoryId,
              icon: Icon(
                Icons.keyboard_arrow_down,
              ),
              underline: Text(""),
              isExpanded: true,
              hint: Text("Select Category",
                  style: Theme.of(context).textTheme.bodyText1),
              style: Theme.of(context).textTheme.bodyText1,
              items: [
                ..._store.category.map((e) {
                  return DropdownMenuItem<String>(
                    child: Text(e.name.toString()),
                    value: e.id,
                  );
                }).toList(),
              ],
              onChanged: (String? value) {
                _store.categoryId = value;
              },
            ),
          ),
        ),
      );
}
