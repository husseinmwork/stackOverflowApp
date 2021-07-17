import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/model/get_question/get_question.dart';
import 'package:todo_app/store/home/home_store.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/ui/home/app_drawer.dart';
import 'package:todo_app/widgets/image_avatar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeStore _store;
  late ThemeStore _themeStore;

  final PagingController<int, Question> _pagingController =
      PagingController(firstPageKey: 0);

  Future<void> _fetchPage(int pageKey) async {
    try {
      await _store.getQuestion(pageKey);
      final newItems = _store.question;
      // fixme this will make another unnecessary request
      final isLastPage = newItems.isEmpty;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
      debugPrint("$error");
    }
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) async {
      _fetchPage(pageKey);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<HomeStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _store.getPrefUser();
    _store.updateScrolling();
  }

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
            Text(
              //todo RichText and change color
              "Stackoverflow",
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        actions: [
          _buildThemeButton(),
        ],
      );

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

  Widget _buildBody() => _buildMainPaging();

  Widget _buildMainPaging() => RefreshIndicator(
        onRefresh: () async => await Future.sync(() {
          _pagingController.refresh();
        }),
        child: PagedListView(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Question>(
            firstPageProgressIndicatorBuilder: (_) =>
                SpinKitFoldingCube(color: Colors.purple[200]),
            noItemsFoundIndicatorBuilder: (_) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Dimens.padding_xl),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search, color: Colors.lightBlueAccent),
                    SizedBox(width: Dimens.padding_mini),
                    Text(
                      "no_result_found",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            itemBuilder: (context, item, index) => QuestionItem(
              // currentLocation: LatLng(position.latitude, position.longitude),
              // onLike: (bool isLiked) => onLikeButtonTapped(item.id, isLiked),
              item: item,
            ),
          ),
        ),
      );
}

class QuestionItem extends StatefulWidget {
  final Question item;

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
                    widget.item.userId!,
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
                widget.item.body
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
