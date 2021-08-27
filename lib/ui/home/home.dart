import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:todo_app/constants/assets.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/packages/anim_search_widget.dart';
import 'package:todo_app/store/home/home_store.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/ui/create_question/create_question.dart';
import 'package:todo_app/ui/details_question/details_question.dart';
import 'package:todo_app/ui/home/question_item.dart';
import 'package:todo_app/utils/device/device_utils.dart';
import 'package:todo_app/utils/routes/routes.dart';
import 'package:todo_app/widgets/stack_overflow_indecator.dart';
import 'package:todo_app/widgets/user_image_avatar.dart';

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

  int _page = 0;

  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  TextEditingController searchController = TextEditingController();
  bool _showNameApp = true;
  bool _showSearchColor = false;
  bool _closeSearchBar = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<HomeStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    if (_store.sendRequest) {
      _store.getPrefUser();
      _store.getQuestion(_page);
      _store.sendRequest = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.refreshPage == true) {
      //return page 0 because onLoading function can send request again
      _page = 0;
      debugPrint("Pagination onRefresh");
      Future.delayed(Duration(milliseconds: 1000));
      _store.question.clear();
      _store.getQuestion(0);
      _store.refreshController.refreshCompleted();
    }
    return Scaffold(
      drawer: _buildDrawer(),
      appBar: _buildAppBar(),
      floatingActionButton: Observer(
          builder: (_) => (_store.showIconFilter && _store.tags.isEmpty)
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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(Routes.profile_screen);
      },
      child: UserAccountsDrawerHeader(
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
        currentAccountPicture: UserImageAvatar(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(Routes.profile_screen);
          },
          image: _store.user?.image ?? "null",
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
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.white),
                  ),
                  TextSpan(
                    text: "overflow",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Theme.of(context).accentColor),
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

  Widget _buildSearchIcon() => AnimSearchBar(
        closeSearch: _closeSearchBar,

        closeSearchOnSuffixTap: false,
        onTap: () async {
          await Future.delayed(
              Duration(milliseconds: _showNameApp == true ? 100 : 300));
          setState(() {
            _showSearchColor = !_showSearchColor;
            _showNameApp = !_showNameApp;
          });
        },
        autoFocus: true,
        color: Colors.black,
        width: MediaQuery.of(context).size.width * 0.75,
        textController: searchController,
        style: TextStyle(color: Colors.white, fontSize: 18),
        onChange: (value) {
          if (value != '') {
            _store.success = false;
            _store.question.clear();
            _store.body = value;
            _store.getQuestion(0);
          }
        },
        onSuffixTap: () {
          setState(() {
            searchController.clear();
          });
        },
      );

  Widget _buildFilterIcon() => IconButton(
        icon: Icon(Icons.filter_alt),
        onPressed: () async {
          Navigator.of(context).pushNamed(Routes.filter);
        },
      );

  Widget _buildRemoveFilterFAB() => FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () async {
          DeviceUtils.hideKeyboard(context);
          _closeSearchBar = true;
          searchController.clear();
          Future.delayed(Duration(milliseconds: 300), () {
            setState(() {
              _showNameApp = true;
            });
          });

          _store.success = false;
          _store.removeFilter();
          _page = 0;
          _store.question.clear();
          await _store.getQuestion(0);
          _store.refreshController.refreshCompleted();
          _closeSearchBar = false;
        },
        child: Icon(Icons.clear, color: Colors.white, size: Dimens.padding_xxl),
      );

  Widget _buildCreateQuestionFAB() => OpenContainer(
        transitionDuration: Duration(milliseconds: 500),
        transitionType: _transitionType,
        openBuilder: (BuildContext context, VoidCallback _) {
          return CreateQuestionScreen();
        },
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(_fabDimension / 2),
          ),
        ),
        onClosed: (result) async {
          if (result == true) {
            _store.success = false;
            _store.question.clear();
            await _store.getQuestion(0);
          }
        },
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

  Widget _buildBody() => Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Observer(
              builder: (_) => Visibility(
                visible: _store.success,
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: WaterDropMaterialHeader(
                    backgroundColor: Theme.of(context).appBarTheme.color,
                  ),
                  footer: CustomFooter(
                    builder: (BuildContext context, LoadStatus? mode) {
                      Widget body;
                      if (mode == LoadStatus.idle) {
                        body = Text("pull up load");
                      } else if (mode == LoadStatus.loading) {
                        body = CupertinoActivityIndicator();
                      } else if (mode == LoadStatus.failed) {
                        body = Text("Load Failed!Click retry!");
                      } else if (mode == LoadStatus.canLoading) {
                        body = Text("release to load more");
                      } else {
                        body = Text("No more Data");
                      }
                      return Container(
                        height: Dimens.paginationLoading,
                        child: Center(child: body),
                      );
                    },
                  ),
                  controller: _store.refreshController,
                  onRefresh: () async {
                    //return page 0 because onLoading function can send request again
                    _page = 0;
                    debugPrint("Pagination onRefresh");
                    await Future.delayed(Duration(milliseconds: 1000));
                    _store.question.clear();
                    await _store.getQuestion(0);
                    _store.refreshController.refreshCompleted();
                  },
                  onLoading: () async {
                    debugPrint("Pagination onLoading");
                    await Future.delayed(Duration(milliseconds: 1000));
                    if (!(_page >= _store.question.length) == true) {
                      _page += 6;
                      await _store.getQuestion(_page);
                      _store.refreshController.loadComplete();
                    } else {
                      _store.refreshController.loadComplete();
                    }
                  },
                  child: ListView.builder(
                    itemCount: _store.question.length,
                    itemBuilder: (_, index) => QuestionItem(
                        item: _store.question[index],
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailsQuestionScreen(
                                id: _store.question[index].id!,
                              ),
                            ),
                          );
                          if (result == true) {
                            _store.success = false;
                            _store.removeFilter();
                            _page = 0;
                            _store.question.clear();
                            await _store.getQuestion(0);
                            _store.refreshController.refreshCompleted();
                          }
                        }),
                  ),
                ),
                replacement: StackOverFlowIndecator(),
              ),
            ),
          ),
        ],
      );
}
