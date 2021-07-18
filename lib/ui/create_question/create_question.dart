import 'package:flutter/material.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/widgets/arrow_back_icon.dart';
import 'package:todo_app/widgets/labeled_text_field.dart';

class CreateQuestionScreen extends StatefulWidget {
  @override
  _CreateQuestionScreenState createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  TextEditingController _tagController = TextEditingController();

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

  Widget _buildBody() => Center(
    child: SingleChildScrollView(
      child: Column(
            children: [
              _buildQuestionTitle(),
              SizedBox(height: Dimens.padding_large),
              _buildQuestionBody(),
              SizedBox(height: Dimens.padding_large),

              _buildQuestionTags(),
            ],
          ),
    ),
  );

  Widget _buildQuestionTitle() => TextFeildAddQuestion(
        controller: _titleController,
        maxLines: 1,
        hint:
            "e.g. there an R function for finding the index of element in a vector?",
        title: "Title",
        label:
            "Be specific and imagine you’re asking a question to another person",
      );

  Widget _buildQuestionBody() => TextFeildAddQuestion(
        controller: _bodyController,
        maxLines: 1,
        hint: "Enter question body",
        title: "Body",
        label:
            "Include all the information someone would need to answer your question",
      );

  Widget _buildQuestionTags() => TextFeildAddQuestion(
        controller: _tagController,
        maxLines: 1,
        hint: "e.g. (spring windows database)",
        title: "Tags",
        label:
            "Add up to 5 tags to describe what your question is about",
      );
}

class TextFeildAddQuestion extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final String? label;
  final String? title;
  final int? maxLines;

  const TextFeildAddQuestion({
    required this.controller,
    this.hint,
    this.label,
    this.title,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toString(), style: Theme.of(context).textTheme.subtitle2),
          Text(label.toString()),
          TextFormField(
            maxLines: maxLines,
            controller: controller,
            decoration: InputDecoration(
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
