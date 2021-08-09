
import 'package:flutter/material.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:todo_app/constants/colors.dart';

class StackOverFlowTags extends StatelessWidget {

  final List<Language> selectedLanguages;
  final Function onChange;

  const StackOverFlowTags({required this.onChange,required this.selectedLanguages}) ;

  // final List<Language> _selectedLanguages = [];



  @override
  Widget build(BuildContext context) {
    return FlutterTagging<Language>(
        initialItems: selectedLanguages,
        textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Theme.of(context).appBarTheme.color,
            hintText: 'Search Tags',
            labelText: 'Select 5 Tags',
          ),
        ),
        findSuggestions: LanguageService.getLanguages,
        additionCallback: (value) {
          return Language(
            name: value,
            position: 0,
          );
        },
        onAdded:(language){
          // api calls here, triggered when add to tag button is pressed
          print(language);
          return Language(name: "name");
        },
        configureSuggestion: (lang) {
          return SuggestionConfiguration(
            title: Text(lang.name),
            subtitle: Text(lang.position.toString()),
            additionWidget: Chip(
              avatar: Icon(
                Icons.add_circle,
                color: Colors.white,
              ),
              label: Text('Add New Tag'),
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
              ),
              backgroundColor: Colors.green,
            ),
          );
        },
        configureChip: (lang) {

          return ChipConfiguration(
            deleteIcon: Icon(Icons.cancel , color:  Theme.of(context).appBarTheme.color),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            label: Text(lang.name),
            backgroundColor: AppColors.secondaryColor,
            labelStyle: TextStyle(color: Colors.black),
            deleteIconColor: Colors.white,

          );
        },
        onChanged: () {
          onChange();

        }
    );
  }
}




/// LanguageService
class LanguageService {
  /// Mocks fetching language from network API with delay of 500ms.
  static Future<List<Language>> getLanguages(String query) async {
    await Future.delayed(Duration(milliseconds: 500), null);
    return <Language>[
      Language(name: 'JavaScript', position: 1),
      Language(name: 'Python', position: 2),
      Language(name: 'Java', position: 3),
      Language(name: 'PHP', position: 4),
      Language(name: 'C#', position: 5),
      Language(name: 'C++', position: 6),
    ].where((lang) => lang.name.toLowerCase().contains(query.toLowerCase())).toList();
  }
}

/// Language Class
class Language extends Taggable {
  ///
  final String name;

  ///
  final int? position;

  /// Creates Language
  Language({
    required this.name,
    this.position,
  });

  @override
  List<Object> get props => [name];

  /// Converts the class to json string.
  String toJson() => '''  {
    "name": $name,\n
    "position": $position\n
  }''';
}