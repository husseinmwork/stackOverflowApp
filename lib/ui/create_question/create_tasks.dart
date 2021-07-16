// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:im_stepper/stepper.dart';
// import 'package:provider/provider.dart';
// import 'package:todo_app/constants/colors.dart';
// import 'package:todo_app/constants/dimens.dart';
// import 'package:todo_app/constants/gradient.dart';
// import 'package:todo_app/store/create_tasks/create_tasks_store.dart';
// import 'package:todo_app/store/theme/theme_store.dart';
// import 'package:todo_app/ui/create_tasks/select_date_widget.dart';
// import 'package:todo_app/utils/device/device_utils.dart';
// import 'package:todo_app/utils/locale/app_localization.dart';
// import 'package:todo_app/utils/routes/routes.dart';
// import 'package:todo_app/utils/todo/todo_utils.dart';
// import 'package:todo_app/widgets/arrow_back_icon.dart';
// import 'package:todo_app/widgets/labeled_text_field.dart';
// import 'package:todo_app/widgets/todo_button.dart';
//
// class CreateTasksScreen extends StatefulWidget {
//   @override
//   _CreateTasksScreenState createState() => _CreateTasksScreenState();
// }
//
// class _CreateTasksScreenState extends State<CreateTasksScreen> {
//   TextEditingController _taskTitleController = TextEditingController();
//   TextEditingController _subTaskTitleController = TextEditingController();
//   TextEditingController _noteController = TextEditingController();
//   TextEditingController _tagsController = TextEditingController();
//
//   // REQUIRED: USED TO CONTROL THE STEPPER.
//   int _activeStep = 0; // Initial step set to 0.
//
//   // OPTIONAL: can be set directly.
//   int _dotCount = 3;
//
//   late CreateTasksStore _store;
//   late ThemeStore _themeStore;
//   late AppLocalizations _appLocalizations;
//
//   late DateTime date;
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//
//     _store = Provider.of<CreateTasksStore>(context);
//     _themeStore = Provider.of<ThemeStore>(context);
//     _appLocalizations = AppLocalizations.of(context);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _taskTitleController.dispose();
//     _subTaskTitleController.dispose();
//     _noteController.dispose();
//     _tagsController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar,
//       body: _buildBody,
//     );
//   }
//
//   get _buildAppBar => AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//         leading: ArrowBackIcon(),
//         title: Text(
//           _appLocalizations.translate("create_tasks_title"),
//           style: Theme.of(context).textTheme.subtitle1?.copyWith(
//                 color: _themeStore.darkMode ? Colors.white : Colors.black,
//               ),
//         ),
//       );
//
//   get _buildBody => Stack(
//         children: [
//           SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: Dimens.padding_xl, vertical: Dimens.padding_xl),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildAddTitle(),
//                   SizedBox(
//                     height: Dimens.padding_xl,
//                   ),
//                   _buildAddSubTasks(),
//                   SizedBox(
//                     height: Dimens.padding_xl,
//                   ),
//                   _buildAddNote(),
//                   SizedBox(
//                     height: Dimens.padding_xl,
//                   ),
//                   _buildAddDate(),
//                   SizedBox(
//                     height: Dimens.padding_xxl,
//                   ),
//                   _buildAddPriority(),
//                   SizedBox(
//                     height: Dimens.padding_xxl,
//                   ),
//                   _buildAddTag(),
//                   SizedBox(
//                     height: Dimens.padding_xxl,
//                   ),
//                   _buildButtonCreate(),
//                 ],
//               ),
//             ),
//           ),
//
//           //todo this is false awy please change this way
//
//           Observer(builder: (_) {
//             return _store.success
//                 ? _navigateToLoginScreen(context)
//                 : _buildClosed();
//           }),
//
//           Align(
//             alignment: Alignment.center,
//             child: Observer(
//               builder: (_) => Visibility(
//                 visible: _store.loading,
//                 child: CircularProgressIndicator(),
//                 replacement: SizedBox.shrink(),
//               ),
//             ),
//           ),
//         ],
//       );
//
//   Widget _buildAddTitle() {
//     return LabeledTextField(
//       textController: _taskTitleController,
//       title: _appLocalizations.translate("create_tasks_text_field_title"),
//       hint: _appLocalizations.translate("create_tasks_text_field_title"),
//       onChanged: (value) {
//         _store.taskTitle = value;
//       },
//     );
//   }
//
//   Widget _buildAddSubTasks() {
//     return Column(
//       children: [
//         LabeledTextField(
//           isIcon: true,
//           icon: Icons.add,
//           textController: _subTaskTitleController,
//           title:
//               _appLocalizations.translate("create_tasks_text_field_sub_title"),
//           hint:
//               _appLocalizations.translate("create_tasks_text_field_sub_title"),
//           onTap: () {
//             if (_subTaskTitleController.text.isNotEmpty)
//               _store.subTask.add(_subTaskTitleController.text);
//             _subTaskTitleController.text = '';
//             DeviceUtils.hideKeyboard(context);
//           },
//         ),
//         Container(
//           alignment: Alignment.center,
//           width: double.infinity,
//           child: Observer(
//             builder: (_) => Column(
//               children: _store.subTask
//                   .map(
//                     (element) => Card(
//                       shape: RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.circular(Dimens.padding_large)),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Flexible(
//                               child: Text(
//                                 "${element.isEmpty ? "" : element}",
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .caption
//                                     ?.copyWith(color: Colors.white),
//                               ),
//                             ),
//                             SizedBox(
//                               width: Dimens.padding_mid,
//                             ),
//                             CloseIcon(onTap: () {
//                               _store.subTask
//                                   .removeWhere((tag) => tag == element);
//                               print(_store.taskTags.length);
//                             })
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                   .toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildAddNote() {
//     return LabeledTextField(
//       textController: _noteController,
//       isIcon: false,
//       title: _appLocalizations.translate("create_tasks_text_field_note"),
//       hint: _appLocalizations.translate("create_tasks_text_field_note"),
//       onChanged: (value) {
//         _store.taskNote = value;
//       },
//     );
//   }
//
//   Widget _buildAddDate() {
//     return Row(
//       children: [
//         Expanded(
//           child: Observer(
//             builder: (_) => SelectDateWidget(
//               color: AppColors.blue,
//               onTap: () async {
//                 DateTime? date = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime(2025),
//                 );
//                 if (date != null) _store.taskDate = date.changeFormat();
//               },
//               hint: _appLocalizations.translate("create_tasks_date"),
//               text: Text(
//                 _store.taskDate == null
//                     ? _appLocalizations.translate("create_tasks_selected_date")
//                     : "${_store.taskDate}",
//                 style: Theme.of(context).textTheme.bodyText2?.copyWith(
//                     color: _themeStore.darkMode ? Colors.white : Colors.black),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(width: Dimens.padding_normal),
//         Expanded(
//           child: Observer(
//             builder: (_) => SelectDateWidget(
//               color: AppColors.lightPurple,
//               onTap: () async {
//                 DateTime? deadline = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime.now().subtract(Duration(days: 0)),
//                   lastDate: DateTime(2025),
//                 );
//
//                 if (deadline != null) _store.taskDeadline = deadline;
//
//                 print(deadline);
//               },
//               hint: _appLocalizations.translate("create_tasks_deadline"),
//               text: Text(
//                 _store.taskDeadline == null
//                     ? _appLocalizations.translate("create_tasks_selected_date")
//                     : "${_store.taskDeadline?.changeFormat()}",
//                 style: Theme.of(context).textTheme.bodyText2?.copyWith(
//                     color: _themeStore.darkMode ? Colors.white : Colors.black),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildAddPriority() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           _appLocalizations.translate("create_tasks_priority").toUpperCase(),
//           style: Theme.of(context).textTheme.overline,
//         ),
//         DotStepper(
//           dotCount: _dotCount,
//           dotRadius: Dimens.padding_large,
//
//           /// THIS MUST BE SET. SEE HOW IT IS CHANGED IN NEXT/PREVIOUS BUTTONS AND JUMP BUTTONS.
//           activeStep: _activeStep,
//           shape: Shape.pipe,
//           spacing: Dimens.padding_mid,
//           indicator: Indicator.jump,
//
//           onDotTapped: (tappedDotIndex) {
//             setState(() {
//               _activeStep = tappedDotIndex;
//             });
//
//             _store.taskPriority = tappedDotIndex;
//           },
//
//           // DOT-STEPPER DECORATIONS
//           fixedDotDecoration: FixedDotDecoration(
//             color: _themeStore.darkMode ? Colors.white : Colors.black,
//           ),
//
//           indicatorDecoration: IndicatorDecoration(
//             // style: PaintingStyle.stroke,
//             // strokeWidth: 8,
//             color: _themeStore.darkMode
//                 ? AppColors.DarkPurple
//                 : AppColors.lightPurple,
//           ),
//           // lineConnectorDecoration: LineConnectorDecoration(
//           //   color: Colors.red,
//           //   strokeWidth: 0,
//           // ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildAddTag() {
//     return Column(
//       children: [
//         LabeledTextField(
//           isIcon: true,
//           textController: _tagsController,
//           title: _appLocalizations.translate("create_tasks_text_field_new_tag"),
//           hint: _appLocalizations.translate("create_tasks_text_field_new_tag"),
//           icon: Icons.add,
//           onTap: () {
//             if (_tagsController.text.isNotEmpty)
//               _store.taskTags.add(_tagsController.text);
//             _tagsController.text = '';
//             DeviceUtils.hideKeyboard(context);
//           },
//         ),
//         Container(
//           alignment: Alignment.center,
//           width: double.infinity,
//           child: Observer(
//             builder: (_) => Wrap(
//               children: _store.taskTags
//                   .map(
//                     (element) => Container(
//                       padding: EdgeInsets.only(
//                         left: Dimens.padding_mid,
//                         right: Dimens.padding_mini,
//                         bottom: Dimens.padding_mini,
//                         top: Dimens.padding_mini,
//                       ),
//                       margin: EdgeInsets.all(Dimens.padding_normal),
//                       decoration: BoxDecoration(
//                           gradient: AppGradient.purpleGradient,
//                           borderRadius:
//                               BorderRadius.circular(Dimens.padding_large)),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "${element.isEmpty ? "" : element}",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .caption
//                                 ?.copyWith(color: Colors.black),
//                           ),
//                           SizedBox(
//                             width: Dimens.padding_mid,
//                           ),
//                           CloseIcon(onTap: () {
//                             _store.taskTags
//                                 .removeWhere((tag) => tag == element);
//                             print(_store.taskTags.length);
//                           })
//                         ],
//                       ),
//                     ),
//                   )
//                   .toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildButtonCreate() {
//     return RoundedButton(
//       onPressed: () {
//         _store.createTask();
//       },
//       title: Text(
//         _appLocalizations.translate("create_tasks_title"),
//       ),
//     );
//   }
//
//   //todo  this function of navigator of screen
//   _buildClosed() {
//     return SizedBox.shrink();
//   }
//
//   Widget _navigateToLoginScreen(BuildContext context) {
//     Future.delayed(Duration.zero, () {
//       Navigator.of(context).pushReplacementNamed(Routes.home);
//       _store.loading = false;
//     });
//     _store.success = false;
//     return Container();
//   }
// }
//
// class CloseIcon extends StatelessWidget {
//   final Function onTap;
//
//   CloseIcon({required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         onTap();
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.black,
//           borderRadius: BorderRadius.circular(Dimens.border_image),
//         ),
//         child: Icon(Icons.clear, size: Dimens.padding_size_close_icon),
//       ),
//     );
//   }
// }
