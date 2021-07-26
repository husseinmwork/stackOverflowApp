import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/model/get_question/get_question.dart';
import 'package:todo_app/packages/anim_search_widget.dart';
import 'package:todo_app/store/home/home_store.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/ui/home/app_drawer.dart';
import 'package:todo_app/ui/home/question_item.dart';
import 'package:todo_app/utils/device/device_utils.dart';
import 'package:todo_app/utils/routes/routes.dart';
import 'package:todo_app/widgets/todo_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeStore _store;
  late ThemeStore _themeStore;

  final PagingController<int, Question> _pagingController =
      PagingController(firstPageKey: 0);
  RangeValues _currentRangeValues = const RangeValues(0, 200);
  TextEditingController searchController = TextEditingController();
  bool _showNameApp = true;
  bool _showSearchColor = false;

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
        title: Row(
          children: [
            Visibility(
              visible: _showNameApp == true,
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Stack",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  TextSpan(
                    text: "overflow",
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: /*_themeStore.darkMode? AppColors.lightPurple:*/ Colors
                            .amber),
                  ),
                ]),
              ),
            ),
          ],
        ),
        actions: [
          _buildSearchIcon(),
          _buildFilterIcon(),
        ],
      );

  Widget _buildFAB() => Observer(
        builder: (_) => Visibility(
          visible: _store.showIconFilter == false,
          child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                _store.removeFilter();
                _pagingController.refresh();
                DeviceUtils.hideKeyboard(context);
                // Navigator.of(context).pushNamed(Routes.create_question);
              },
              child: Icon(Icons.clear,
                  color: Colors.white, size: Dimens.padding_xxl)),
        ),
      );

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
              height: 350.0,
              color: Colors.transparent,
              //could change this to Color(0xFF737373),
              //so you don't have to change MaterialApp canvasColor
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) =>
                    Container(
                  height: double.infinity,
                  width: double.infinity,
                  // padding: EdgeInsets.symmetric(
                  //     horizontal: Dimens.padding_normal, vertical: Dimens.padding_xl),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Filter",
                          style: Theme.of(context).textTheme.headline6),
                      SizedBox(height: Dimens.padding_xxl),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.padding_normal),
                        child: Row(
                          children: [
                            Text("Votes",
                                style: Theme.of(context).textTheme.subtitle2),
                            Expanded(
                              child: RangeSlider(
                                values: _currentRangeValues,
                                min: 0,
                                max: 200,
                                divisions: 10,
                                labels: RangeLabels(
                                  _currentRangeValues.start.round().toString(),
                                  _currentRangeValues.end.round().toString(),
                                ),
                                onChanged: (RangeValues values) {
                                  setState(() {
                                    _currentRangeValues = values;
                                  });
                                  _store.minVotes =
                                      _currentRangeValues.start.toInt();
                                  _store.maxVotes =
                                      _currentRangeValues.end.toInt();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      RoundedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            // _store.getQuestion(skip);
                            _pagingController.refresh();
                          },
                          title: Text('Show Result'))
                    ],
                  ),
                ),
              ));
        });
  }

  Widget _buildSearchIcon() => AnimSearchBar(
        onTap: () async {
          await Future.delayed(
              Duration(milliseconds: _showNameApp == true ? 100 : 300));
          setState(() {
            _showSearchColor = !_showSearchColor;
            _showNameApp = !_showNameApp;
          });
        },
        autoFocus: true,
        color:_showSearchColor ?Colors.black: Colors.transparent,
        width: MediaQuery.of(context).size.width * 0.70,
        textController: searchController,
        onChange: (value) {
          print(value);
          _store.body = value;
          _pagingController.refresh();
        },
        onSuffixTap: () {
          setState(() {
            searchController.clear();
            _showNameApp = true;
          });
        },
      );

  Widget _buildFilterIcon() => IconButton(
        icon: Icon(Icons.filter_alt),
        onPressed: () {
          // SideSheet.right(body: _buildBodyFilter(), context: context);
          _modalBottomSheetMenu();
        },
      );

/*  Widget _buildFAB() => Observer(
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
      );*/


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
