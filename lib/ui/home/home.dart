import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/model/get_question/get_question.dart';
import 'package:todo_app/packages/anim_search_widget.dart';
import 'package:todo_app/store/home/home_store.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/ui/details_question/details_question.dart';
import 'package:todo_app/ui/home/app_drawer.dart';
import 'package:todo_app/ui/home/filter.dart';
import 'package:todo_app/ui/home/question_item.dart';
import 'package:todo_app/utils/device/device_utils.dart';
import 'package:todo_app/widgets/stack_overflow_indecator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late HomeStore _store;
  late ThemeStore _themeStore;

  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  void _showMarkedAsDoneSnackbar(bool? isMarkedAsDone) {
    if (isMarkedAsDone ?? false)
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Marked as done!'),
      ));
  }

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
        _store.pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _store.pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _store.pagingController.error = error;
      debugPrint("$error");
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<HomeStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _store.getPrefUser();
    _store.updateScrolling();
    _store.getCategory(0);
    _store.pagingController.addPageRequestListener((pageKey) async {
      _fetchPage(pageKey);
    });
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
                _store.pagingController.refresh();
                DeviceUtils.hideKeyboard(context);
                // Navigator.of(context).pushNamed(Routes.create_question);
              },
              child: Icon(Icons.clear,
                  color: Colors.white, size: Dimens.padding_xxl)),
        ),
      );

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
        color: _showSearchColor ? Colors.black : Colors.transparent,
        width: MediaQuery.of(context).size.width * 0.70,
        textController: searchController,
        onChange: (value) {
          print(value);
          _store.body = value;
          _store.pagingController.refresh();
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

          showModalBottomSheet(
              context: context, builder: (_) => FilterBottomSheet());
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
          _store.pagingController.refresh();
        }),
        child: PagedListView(
          pagingController: _store.pagingController,
          builderDelegate: PagedChildBuilderDelegate<Question>(
            firstPageProgressIndicatorBuilder: (_) => StackOverFlowIndecator(),
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
            itemBuilder: (context, item, index) => _OpenContainerWrapper(
              id: item.id!,
              transitionType: _transitionType,
              onClosed: _showMarkedAsDoneSnackbar,
              closedBuilder: (BuildContext _, VoidCallback openContainer) =>
                  QuestionItem(
                openContainer: () {
                  openContainer();
                },
                // currentLocation: LatLng(position.latitude, position.longitude),
                // onLike: (bool isLiked) => onLikeButtonTapped(item.id, isLiked),
                item: item,
              ),
            ),
          ),
        ),
      );
}

class _OpenContainerWrapper extends StatelessWidget {
  const _OpenContainerWrapper({
    required this.closedBuilder,
    required this.transitionType,
    required this.onClosed,
    required this.id,
  });

  final String id;
  final CloseContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;
  final ClosedCallback<bool?> onClosed;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
        transitionType: transitionType,
        openBuilder: (BuildContext context, VoidCallback _) {
          return DetailsQuestionScreen(id: id);
        },
        onClosed: onClosed,
        transitionDuration: Duration(milliseconds: 500),
        tappable: false,
        closedBuilder: closedBuilder,
        openColor: Theme.of(context).accentColor,
        closedColor: Theme.of(context).scaffoldBackgroundColor);
  }
}
