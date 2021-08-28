import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/packages/toast.dart';
import 'package:todo_app/store/answers/edit_answer/edit_answer_store.dart';
import 'package:todo_app/utils/device/device_utils.dart';
import 'package:todo_app/widgets/stack_overflow_indecator.dart';
import 'package:todo_app/widgets/user_image_avatar.dart';

class EditAnswerScreen extends StatefulWidget {
  final String userImage;
  final String bodyOfAnswer;
  final String answerId;

  EditAnswerScreen(
      {required this.answerId,
      required this.userImage,
      required this.bodyOfAnswer});

  @override
  _EditAnswerScreenState createState() => _EditAnswerScreenState();
}

class _EditAnswerScreenState extends State<EditAnswerScreen> {
  late EditAnswersStore _store;

  TextEditingController _controllerBody = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<EditAnswersStore>(context);
    _store.answerId = widget.answerId;
    _controllerBody.text = widget.bodyOfAnswer;
    _store.bodyAnswer = widget.bodyOfAnswer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: Text("Edit Answer",
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.white)),
      );

  Widget _buildBody() => Stack(
        children: [
          Observer(
            builder: (_) => Visibility(
              visible: _store.loading,
              child: StackOverFlowIndecator(),
              replacement: SizedBox.shrink(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.padding_normal,
                vertical: Dimens.padding_large),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: Dimens.padding_normal),
                        child: UserImageAvatar(
                            image: widget.userImage, onTap: () {})),
                    SizedBox(width: Dimens.padding_normal),
                    Expanded(
                        child: TextField(
                      minLines: 1,
                      maxLines: 4,
                      controller: _controllerBody,
                      onChanged: (value) {
                        _store.bodyAnswer = value;
                      },
                    ))
                  ],
                ),
                SizedBox(height: Dimens.padding_normal),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                          onPressed: () async {
                            DeviceUtils.hideKeyboard(context);
                            await _store.updateAnswer().then((value) {
                              Navigator.pop(context, true);
                            }).catchError((e) {
                              Toast.show(
                                  _store.errorStore.errorMessage, context,
                                  duration: 3);
                            });
                          },
                          child: Text("Update".toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  ?.copyWith(color: Colors.white))),

                    SizedBox(width: Dimens.padding_normal),
                    ElevatedButton(
                        onPressed: () {
                          DeviceUtils.hideKeyboard(context);

                          Navigator.pop(context);
                        },
                        child: Text("Cancel".toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .button
                                ?.copyWith(color: Colors.white))),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
}
