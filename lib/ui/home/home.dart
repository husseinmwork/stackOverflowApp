import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/model/get_question/get_question.dart';
import 'package:todo_app/store/home/home_store.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/ui/home/app_drawer.dart';
import 'package:todo_app/utils/locale/app_localization.dart';
import 'package:todo_app/utils/routes/routes.dart';
import 'package:todo_app/widgets/image_avatar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeStore _store;
  late ThemeStore _themeStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<HomeStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _store.getPrefUser();
    _store.updateScrolling();
    _store.getQuestion(0);
  }

  List _qustion = [
    for (int i = 0; i < 10; i++)
      {
        "id": 1,
        "question":
            '''Data are units of information, often numeric, that are collected through observation.[1] In a more technical sense, data are a set of values of qualitative or quantitative variables about one or 
      more persons or objects,[1]while a datum (singular of data) is a single value of a single variable.[2]
      Although the terms "data" and "information" are often
      used interchangeably, these terms have distinct meanings. 
      In some popular publications, data are sometimes said to be
      transformed into information when they are viewed in context or 
      in post-analysis.[3] However, in academic treatments of the subject data are simply units of information.
      Data are used in scientific research, businesses management (e.g., sales data, revenue, profits, stock price), finance, 
      governance (e.g., crime rates, unemployment rates, literacy rates), and in virtually every other form of human organizational
      activity (e.g., censuses of the number of homeless people by non-profit organizations).
      Data are measured, collected and reported, and analyzed, and from data visualizations such as graphs, tables or images are produced. 
      Data as a general concept refers to the fact that some existing information or knowledge is represented or coded in some form suitable 
      for better usage or processing. Raw data ("unprocessed data") is a collection of numbers or characters before it has been "cleaned"
      and corrected by researchers. Raw data needs to be corrected to remove outliers or obvious instrument or data entry errors (e.g., a 
      thermometer reading from an outdoor Arctic location recording a tropical temperature). Data processing commonly occurs by stages,
      and the "processed data" from one stage may be considered the "raw data" of the next stage. Field data is raw data that is collected 
      in an uncontrolled "in situ" environment. Experimental data is data that is generated within the context of a scientific investigation
      by observation and recording.''',
        "user_image": "image",
        "user_name": "user1",
      },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: _buildAppBar(),
      floatingActionButton: _buildFAB(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
        elevation: 0,
        title: Row(
          children: [
            Observer(

              builder: (_) => Text(_store.user?.fullName ?? "null user",
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        actions: [
          _buildThemeButton(),
          Container(
            padding: const EdgeInsets.only(
                right: Dimens.padding_mini, top: Dimens.padding_mini),
            margin: const EdgeInsets.only(
                right: Dimens.padding_mid, top: Dimens.padding_mini),
            child: Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: ImageAvatar(
                radius: 18,
                onTap: () {},
                image:
                    "https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg",
              ),
            ),
          ),
        ],
      );

  // Widget _buildFAB() {
  //   return FloatingActionButton(
  //     onPressed: () {
  //       // print(" add floatingActionButton");
  //       Navigator.of(context).pushNamed(Routes.create_tasks);
  //     },
  //     child: Icon(Icons.arrow_upward),
  //     elevation: 2.0,
  //   );
  // }

  Widget _buildFAB() => Observer(
        builder: (_) => AnimatedOpacity(
          child: FloatingActionButton(
            child: Icon(Icons.arrow_upward, color: Colors.black),
            elevation: 2.0,
            onPressed: () {
              _store.controller.animateTo(
                .0,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
              );
            },
          ),
          duration: Duration(milliseconds: 100),
          opacity: _store.fabIsVisible ? 1 : 0,
        ),
      );

  Widget _buildThemeButton() => Observer(
        builder: (context) {
          return IconButton(
            onPressed: () {
              _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
            },
            icon: Icon(
              _themeStore.darkMode ? Icons.brightness_5 : Icons.brightness_3,
            ),
          );
        },
      );

  Widget _buildBody() => Observer(
        builder: (_) => Column(
          children: [
            SizedBox(
              height: 80,
              width: double.infinity,
              child: Card(
                margin: EdgeInsets.symmetric(vertical: Dimens.padding_mini),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimens.padding_mid,
                      vertical: Dimens.padding_mid),
                  child: Row(
                    children: [
                      ImageAvatar(
                        radius: 18,
                        onTap: () {},
                        image:
                            "https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg",
                      ),
                      Expanded(
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "add Question",
                                hintStyle:
                                    Theme.of(context).textTheme.bodyText1),
                            // decoration: InputDecoration(
                            //     focusedBorder: OutlineInputBorder(
                            //         borderRadius:
                            //             BorderRadius.all(Radius.circular(20.0)),
                            //         borderSide: BorderSide(color: Colors.blue)),
                            //     enabledBorder: OutlineInputBorder(
                            //         borderRadius:
                            //             BorderRadius.all(Radius.circular(20.0)),
                            //         borderSide: BorderSide(color: Colors.blue))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _store.controller,
                itemCount: _store.question.length,
                itemBuilder: (context, index) => QuestionItem(
                  item: _store.question[index],
                ),
              ),
            ),
          ],
        ),
      );
}

class QuestionItem extends StatefulWidget {
  final List<Question> item;

  QuestionItem({required this.item});

  @override
  _QuestionItemState createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
  late ThemeStore _themeStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeStore = Provider.of<ThemeStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: Dimens.padding_mini),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimens.padding_mid, vertical: Dimens.padding_mid),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageAvatar(
                      radius: 18,
                      onTap: () {},
                      image:
                          "https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg"),
                  SizedBox(width: Dimens.padding_mini),
                  Text(
                    widget.item[0].userId!,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: _themeStore.darkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                  ),
                ],
              ),
              SizedBox(height: Dimens.padding_mid),
              //this regExp is remove space and order the any text get from api
              Text(
                widget.item[0].body
                    .toString()
                    .replaceAll(new RegExp(r"\n|\s\n"), ""),
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: _themeStore.darkMode ? Colors.white : Colors.black,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
