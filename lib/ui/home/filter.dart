import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/store/home/home_store.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/widgets/category_dropdown.dart';
import 'package:todo_app/widgets/filter_dropdown.dart';
import 'package:todo_app/widgets/tags_language.dart';
import 'package:todo_app/widgets/todo_button.dart';

enum SortBy { NEWEST, OLDEST }

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late HomeStore _store;
  late ThemeStore _themeStore;

  String? _valueMinVotes;
  String? _valueMaxVotes;
  String? _valueMinViews;
  String? _valueMaxViews;
  final List<String> _minVotes = ['10', '20', '30', '40', '50'];
  final List<String> _maxVotes = ['100', '110', '120', '130', '140'];
  final List<String> _minViews = ['10', '20', '30', '40', '50'];
  final List<String> _maxViews = ['100', '110', '120', '130', '140'];
  TextEditingController _tagController = TextEditingController();
  List<Language> _tags = [];
  SortBy _defaultValue = SortBy.NEWEST;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<HomeStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _store.getCategory(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
      title: Text("Filter", style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white)));

  Widget _buildBody() => Container(
        padding: const EdgeInsets.symmetric(
            vertical: Dimens.padding_normal, horizontal: Dimens.padding_xl),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //todo work validation add max five tags
                  _buildFilterTags(),
                  _buildVotes(),
                  _buildViews(),
                  _buildSelectCategory(),
                  _buildSortedBy(),
                ],
              ),
            ),
            Observer(
              builder: (_) => RoundedButton(
                loading: _store.loading,
                onPressed: () async {
                  Future.delayed(Duration(milliseconds: 600));
                  await _store.getQuestion(0).then((value) {
                    _store.success = false;
                    _store.question.clear();
                    _store.getQuestion(0);
                    Navigator.of(context).pop();
                  }).catchError((e) {
                    debugPrint("error");
                  });
                },
                title: 'Show Result',
              ),
            )
          ],
        ),
      );

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

  Widget _buildFilterTags() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tags".toString(), style: Theme.of(context).textTheme.subtitle2),
          StackOverFlowTags(
            labelChipStyle: TextStyle(color: _themeStore.darkMode? Colors.black:Colors.white),

            controller: _tagController,
            onChange: () {
              for (var i in _tags) {
                _store.tags.add(i.name);
              }
            },
            selectedLanguages: _tags,
          ),
        ],
      );

  Widget _buildSelectCategory() => Observer(
        builder: (_) => CategoryDropDown(
          hint: "Select Category",
          value: _store.categoryId,
          item: [
            ..._store.category.map((e) {
              return DropdownMenuItem<String>(
                child: Text(e.name.toString()),
                value: e.id,
              );
            }).toList(),
          ],
          onChange: (String? value) {
            setState(() {
              _store.categoryId = value;
            });
          },
        ),
      );

  Widget _buildSortedBy() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Sorted By", style: Theme.of(context).textTheme.subtitle2),
          RadioListTile<SortBy>(
            value: SortBy.NEWEST,
            groupValue: _defaultValue,
            onChanged: (SortBy? c) {
              //because default value of  question sort is newest
              _store.oldest = null;
              setState(() {
                _defaultValue = c!;
              });
            },
            title: Text("Newest", style: Theme.of(context).textTheme.bodyText1),
          ),
          RadioListTile(
            value: SortBy.OLDEST,
            groupValue: _defaultValue,
            onChanged: (SortBy? c) {
              _store.oldest = 'OLDEST';
              setState(() {
                _defaultValue = c!;
              });
            },
            title: Text("Oldest", style: Theme.of(context).textTheme.bodyText1),
          )
        ],
      );
}
