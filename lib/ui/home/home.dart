import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/assets.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/model/get_question/get_question.dart';
import 'package:todo_app/packages/anim_search_widget.dart';
import 'package:todo_app/store/home/home_store.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/ui/create_question/create_question.dart';
import 'package:todo_app/ui/details_question/details_question.dart';
import 'package:todo_app/ui/home/filter.dart';
import 'package:todo_app/ui/home/question_item.dart';
import 'package:todo_app/utils/device/device_utils.dart';
import 'package:todo_app/utils/routes/routes.dart';
import 'package:todo_app/widgets/stack_overflow_indecator.dart';

const double _fabDimension = 56.0;

class HomeScreen extends StatefulWidget {
  final bool? refreshPage;

  const HomeScreen({this.refreshPage});

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
    /* _store.updateScrolling();*/
    _store.pagingController.addPageRequestListener((pageKey) async {
      _fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.refreshPage == true) {
      Future.sync(() {
        _store.pagingController.refresh();
      });
    }
    return Scaffold(
      drawer: _buildDrawer(),
      appBar: _buildAppBar(),
      floatingActionButton: Observer(
          builder: (_) => _store.showIconFilter
              ? _buildCreateQuestionFAB()
              : _buildRemoveFilterFAB()),
      body: _buildBody(),
    );
  }

  ///drawer
  Widget _buildDrawer() => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createHeader(),
            _createDrawerItem(
                icon: Icons.view_list,
                text: 'My Question',
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(Routes.my_question);
                }),
            _createDrawerItem(
                icon: Icons.logout,
                text: 'Logout',
                onTap: () {
                  Navigator.of(context).pop();
                  _store.logout();
                  Navigator.of(context).pushReplacementNamed(Routes.login);
                }),
            _createDrawerItem(
                icon: Icons.settings,
                text: 'Settings',
                onTap: () {
                  Navigator.of(context).pop();
                }),
            Divider(color: Colors.white)
          ],
        ),
      );

  Widget _createHeader() {
    // onTap: () {
    //   Navigator.of(context).pop();
    //   Navigator.of(context).pushNamed(Routes.profile_screen);
    // },
    return UserAccountsDrawerHeader(
      accountName: Text(_store.user?.username ?? "null",
          style: Theme.of(context).textTheme.bodyText1),
      accountEmail: Text(_store.user?.email ?? "null",
          style: Theme.of(context).textTheme.subtitle1),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      otherAccountsPictures: [
        _buildThemeButton(),
      ],
      currentAccountPicture: CircleAvatar(
        radius: Dimens.imageDrawer,
        child: ClipOval(
          child: FadeInImage.assetNetwork(
            fit: BoxFit.cover,
            placeholder: Assets.placeHolder,
            height: double.infinity,
            width: double.infinity,
            image: _store.user?.image ?? "null",
            imageErrorBuilder: (_, __, ___) {
              return Image.asset(Assets.placeHolder, fit: BoxFit.cover);
            },
          ),
        ),
      ),
    );
  }

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

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon, color: _themeStore.darkMode ? Colors.white : Colors.black),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: _themeStore.darkMode ? Colors.white : Colors.black),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  ///End drawer

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

  Widget _buildRemoveFilterFAB() => Observer(
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
        onPressed: () async {
          await _store.getCategory(0);
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (_) => FilterBottomSheet());
        },
      );

/*  Widget _buildCreateQuestionFAB() => Observer(
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
  Widget _buildCreateQuestionFAB() => OpenContainer(
        transitionType: _transitionType,
        openBuilder: (BuildContext context, VoidCallback _) {
          return CreateQuestionScreen();
        },
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(_fabDimension / 2),
          ),
        ),
        closedColor: Theme.of(context).colorScheme.secondary,
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return SizedBox(
            height: _fabDimension,
            width: _fabDimension,
            child: Center(
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          );
        },
      );

  Widget _buildBody() => RefreshIndicator(
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
            itemBuilder: (context, item, index) => QuestionItem(
                item: item,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DetailsQuestionScreen(
                        id: item.id!,
                      ),
                    ),
                  );
                }),
          ),
        ),
      );
}
