import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/model/get_question/get_question.dart';
import 'package:todo_app/store/create_question/create_question_store.dart';
import 'package:todo_app/store/form/form_store.dart';
import 'package:todo_app/utils/todo/todo_utils.dart';
import 'package:todo_app/widgets/category_dropdown.dart';
import 'package:todo_app/widgets/tags_language.dart';
import 'package:todo_app/widgets/todo_button.dart';

class CreateQuestionScreen extends StatefulWidget {
  final bool? editQuestion;
  final Question? questionItem;
  final String? questionId;

  CreateQuestionScreen({this.questionId, this.editQuestion, this.questionItem});

  @override
  _CreateQuestionScreenState createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  TextEditingController _tagController = TextEditingController();

  List<Language> _tags = [];

  late CreateQuestionStore _store;
  final _formStore = FormStore();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<CreateQuestionStore>(context);
    _store.getCategory(0);
    if (widget.editQuestion == true) {
      _store.questionId = widget.questionId;
      _titleController.text = widget.questionItem!.title!;
      _bodyController.text = widget.questionItem!.body!;
      for (var i in widget.questionItem!.tags!) {
        _tags.add(Language(name: i));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
      leading: IconButton(
        onPressed: () {
          _store.loading = false;
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_outlined),
      ),
      title: Text(
          widget.editQuestion == true ? "Edit Question" : "Ask Question",
          style: Theme.of(context).textTheme.headline6));

  Widget _buildBody() => Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildQuestionTitle(),
              SizedBox(height: Dimens.padding_large),
              _buildQuestionBody(),
              SizedBox(height: Dimens.padding_large),
              _buildQuestionTags(),
              SizedBox(height: Dimens.padding_large),
              _buildSelectCategory(),
              SizedBox(height: Dimens.padding_large),
              _buildButton(),
            ],
          ),
        ),
      );

  Widget _buildQuestionTitle() => Observer(
        builder: (_) => TextFeildAddQuestion(
          errorText: _formStore.formErrorStore.questionTitle,
          onChanged: (value) {
            _formStore.setQuestionTitle(_titleController.text);
            _store.title = value;
          },
          controller: _titleController,
          maxLines: 2,
          hint:
              "e.g. there an R function for finding the index of element in a vector?",
          title: "Title",
          label:
              "Be specific and imagine you’re asking a question to another person",
        ),
      );

  Widget _buildQuestionBody() => Observer(
        builder: (_) => TextFeildAddQuestion(
          errorText: _formStore.formErrorStore.questionBody,
          onChanged: (value) {
            _formStore.setQuestionBody(_bodyController.text);
            _store.body = value;
          },
          controller: _bodyController,
          maxLines: 4,
          hint: "Enter question body",
          title: "Body",
          label:
              "Include all the information someone would need to answer your question",
        ),
      );

  Widget _buildQuestionTags() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tags".toString(),
                style: Theme.of(context).textTheme.subtitle2),
            StackOverFlowTags(
              controller: _tagController,
              onChange: () {
                _store.tags = _tags;
              },
              selectedLanguages: _tags,
            ),
          ],
        ),
      );

  Widget _buildSelectCategory() => Observer(
        builder: (_) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_large),
          child: CategoryDropDown(
            hint: widget.editQuestion == true
                ? widget.questionItem!.category!.name.toString()
                : "Select Category",
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
              if (widget.editQuestion == true) {
                setState(() {
                  value = widget.questionItem!.categoryId;
                  _store.categoryId = value;
                });
              }
              setState(() {
                _store.categoryId = value;
              });
            },
          ),
        ),
      );

  Widget _buildButton() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_large),
        child: Observer(
          builder: (_) => RoundedButton(
              loading: _store.loading,
              onPressed: widget.editQuestion == true
                  ? () async {
                      await _store.updateQuestion().then((value) {
                        Navigator.pop(context, true);
                      }).catchError((e) {
                        _store.loading = false;
                        print(e);
                      });
                    }
                  : () async {
                      if (_titleController.text.isEmpty &&
                          _bodyController.text.isEmpty) {
                        _formStore.setQuestionTitle(_titleController.text = '');
                        _formStore.setQuestionBody(_bodyController.text = '');
                      }
                      if (_formStore.canCreateQuestion == true) {
                        await _store.createQuestion().then((value) {
                          _store.loading = false;
                          Navigator.pop(context, true);
                        }).catchError((e) {
                          print(e);
                        });
                      } else {
                        showErrorMessage('Please check all fields', context);
                      }
                    },
              title: widget.editQuestion == true
                  ? "Edit Question"
                  : "Create Question"),
        ),
      );
}

class TextFeildAddQuestion extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final String? label;
  final String? title;
  final int? maxLines;
  final Function onChanged;
  final String? errorText;

  const TextFeildAddQuestion({
    required this.controller,
    required this.onChanged,
    this.errorText,
    this.hint,
    this.label,
    this.title,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toString(), style: Theme.of(context).textTheme.subtitle2),
          Text(label.toString()),
          TextFormField(
            onChanged: (value) {
              onChanged(value);
            },
            maxLines: maxLines,
            minLines: 1,
            controller: controller,
            decoration: InputDecoration(
                errorText: errorText,
                hintText: hint,
                hintStyle: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: Colors.grey),
                enabled: true),
          ),
        ],
      ),
    );
  }
}
