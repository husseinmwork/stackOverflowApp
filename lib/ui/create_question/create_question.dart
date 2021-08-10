import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/store/create_question/create_question_store.dart';
import 'package:todo_app/store/form/form_store.dart';
import 'package:todo_app/ui/home/home.dart';
import 'package:todo_app/utils/routes/routes.dart';
import 'package:todo_app/utils/todo/todo_utils.dart';
import 'package:todo_app/widgets/arrow_back_icon.dart';
import 'package:todo_app/widgets/category_dropdown.dart';
import 'package:todo_app/widgets/stack_overflow_indecator.dart';
import 'package:todo_app/widgets/tags_language.dart';
import 'package:todo_app/widgets/todo_button.dart';

class CreateQuestionScreen extends StatefulWidget {
  @override
  _CreateQuestionScreenState createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  TextEditingController _tagController = TextEditingController();

  List<Language> tags = [];

  late CreateQuestionStore _store;
  final _formStore = FormStore();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<CreateQuestionStore>(context);
    _store.getCategory(0);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _bodyController.dispose();
    _tagController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
      //todo change languages
      leading: ArrowBackIcon(),
      title: Text(
        "Ask Question",
        style: Theme.of(context).textTheme.headline6,
      ));

  Widget _buildBody() => Stack(
        children: [
          Center(
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
          ),
          Align(
            alignment: Alignment.center,
            child: Observer(
              builder: (_) => Visibility(
                visible: _store.loading,
                child: StackOverFlowIndecator(),
              ),
            ),
          ),
          Observer(builder: (_) {
            return _store.success
                ? _navigateToLoginScreen(context)
                : _buildClosed();
          }),
        ],
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
              onChange: () {
                _store.tags = tags;
              },
              selectedLanguages: tags,
            ),
          ],
        ),
      );

  Widget _buildSelectCategory() => Observer(
    builder: (_) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_large),
      child: CategoryDropDown(
        value: _store.categoryId,
        item: [
          ..._store.category.map((e) {
            return DropdownMenuItem<String>(
              child: Text(e.name.toString()),
              value: e.id,
            );
          }).toList(),
        ],
        onChange: (String? value){
          setState(() {
            _store.categoryId = value;
          });
        },
      ),
    ),
  );

  Widget _buildButton() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_large),
        child: RoundedButton(
            onPressed: () async {
              if (_formStore.canCreateQuestion == true) {
                await _store.createQuestion();
              } else {
                showErrorMessage('Please check all fields', context);
              }
            },
            title: "Create Question"),
      );

  ///this  Navigation to another page
  _buildClosed() {
    return SizedBox.shrink();
  }

  Widget _navigateToLoginScreen(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Navigator.of(context).pop();
      _store.loading = false;
    });
    _store.success = false;
    return Container();
  }
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
