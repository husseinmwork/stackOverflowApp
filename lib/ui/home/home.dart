import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/dimens.dart';
import 'package:todo_app/model/get_category/get_category.dart';
import 'package:todo_app/model/get_question/get_question.dart';
import 'package:todo_app/packages/anim_search_widget.dart';
import 'package:todo_app/packages/textfield_tags.dart';
import 'package:todo_app/store/home/home_store.dart';
import 'package:todo_app/store/theme/theme_store.dart';
import 'package:todo_app/ui/details_question/details_question.dart';
import 'package:todo_app/ui/home/app_drawer.dart';
import 'package:todo_app/ui/home/question_item.dart';
import 'package:todo_app/utils/device/device_utils.dart';
import 'package:todo_app/utils/routes/routes.dart';
import 'package:todo_app/widgets/filter_dropdown.dart';
import 'package:todo_app/widgets/stack_overflow_indecator.dart';
import 'package:todo_app/widgets/todo_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeStore _store;
  late ThemeStore _themeStore;

  //filter section
  String? _valueMinVotes;
  String? _valueMaxVotes;
  String? _valueMinViews;
  String? _valueMaxViews;

  final List<String> _minVotes = ['10', '20', '30', '40', '50'];
  final List<String> _maxVotes = ['100', '110', '120', '130', '140'];
  final List<String> _minViews = ['10', '20', '30', '40', '50'];
  final List<String> _maxViews = ['100', '110', '120', '130', '140'];

  //tags
  bool selectedCategory = false;

  List<String> tags = [];
  List<String> options = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
  ];

  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  void _showMarkedAsDoneSnackbar(bool? isMarkedAsDone) {
    if (isMarkedAsDone ?? false)
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Marked as done!'),
      ));
  }

  //end filter section

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
    _store.getCategory(0);
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
            firstPageProgressIndicatorBuilder: (_) =>StackOverFlowIndecator(),

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
              closedBuilder: (BuildContext _, VoidCallback openContainer)=> QuestionItem(
                openContainer: (){
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

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return _buildContantSheetFilter();
        });
  }

  Widget _buildContantSheetFilter() => Container(
        height: MediaQuery.of(context).size.height * 0.60,
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(
            vertical: Dimens.padding_normal, horizontal: Dimens.padding_xxl),
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) => Container(
            height: double.infinity,
            width: double.infinity,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [

                    _buildTags(),
                    SizedBox(height: Dimens.padding_large),
                    _buildVotes(),
                    SizedBox(height: Dimens.padding_normal),
                    _buildViews(),
                    SizedBox(height: Dimens.padding_large),

                    _buildSelectCategory(),
                  ],
                ),
                SizedBox(
                  width: 250,
                  height: 40,
                  child: RoundedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // _store.getQuestion(skip);
                        _pagingController.refresh();
                      },
                      title: Text('Show Result')),
                )
              ],
            ),
          ),
        ),
      );

  Widget _buildVotes() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Min Votes", style: Theme.of(context).textTheme.subtitle2),
              SizedBox(height: Dimens.padding_mini),
              FilterDropDown(
                items: [
                  ..._minVotes.map((e) {
                    return DropdownMenuItem(
                      child: Text(e.toString()),
                      value: e,
                    );
                  }).toList(),
                ],
                value: _valueMinVotes,
                hint: "1",

                onChanged: (value) {
                  setState(() {
                    _valueMinVotes = value;
                  });
                  _store.minVotes = int.parse(_valueMinVotes!);
                },
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Max Votes", style: Theme.of(context).textTheme.subtitle2),
              SizedBox(height: Dimens.padding_mini),
              FilterDropDown(
                items: [
                  ..._maxVotes.map((e) {
                    return DropdownMenuItem(
                      child: Text(e.toString()),
                      value: e,
                    );
                  }).toList(),
                ],
                value: _valueMaxVotes,
                hint: "1",
                onChanged: (value) {
                  setState(() {
                    _valueMaxVotes = value;
                  });
                  _store.maxVotes = int.parse(_valueMaxVotes!);
                },
              ),
            ],
          ),
        ],
      );

  Widget _buildViews() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Min Views", style: Theme.of(context).textTheme.subtitle2),
              SizedBox(height: Dimens.padding_mini),
              FilterDropDown(
                items: [
                  ..._minViews.map((e) {
                    return DropdownMenuItem(
                      child: Text(e.toString()),
                      value: e,
                    );
                  }).toList(),
                ],
                value: _valueMinViews,
                hint: "1",

                onChanged: (value) {
                  setState(() {
                    _valueMinViews = value;
                  });
                  _store.minViews = int.parse(_valueMinVotes!);
                },
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Max Views", style: Theme.of(context).textTheme.subtitle2),
              SizedBox(height: Dimens.padding_mini),
              FilterDropDown(
                items: [
                  ..._maxViews.map((e) {
                    return DropdownMenuItem(
                      child: Text(e.toString()),
                      value: e,
                    );
                  }).toList(),
                ],
                value: _valueMaxViews,
                hint: "1",

                onChanged: (value) {
                  setState(() {
                    _valueMaxViews = value;
                  });
                  _store.maxViews = int.parse(_valueMaxViews!);
                },
              ),
            ],
          ),
        ],
      );

  Widget _buildTags() => TextFieldTags(
      tagsStyler: TagsStyler(
          tagTextStyle: TextStyle(fontWeight: FontWeight.normal),
          tagDecoration: BoxDecoration(
            color: Colors.blue[300],
            borderRadius: BorderRadius.circular(0.0),
          ),
          tagCancelIcon:
              Icon(Icons.cancel, size: 18.0, color: Colors.blue[900]),
          tagPadding: const EdgeInsets.all(6.0)),
      textFieldStyler: TextFieldStyler(
        helperText: "",
        hintStyle: TextStyle(color: Colors.white),
      ),
      onTag: (tag) {},
      onDelete: (tag) {
        _store.tags!.removeWhere((element) => element == tag);
        print(_store.tags);
      },
      validator: (tag) {
        _store.tags!.add(tag!);
        print(_store.tags);
        if (tag.length > 15) {
          return "hey that's too long";
        }
        return null;
      });

  Widget _buildSelectCategory() => Visibility(
        visible: _store.category.isNotEmpty,
        child:  Observer(
          builder:(_)=> Container(
            padding: EdgeInsets.symmetric(horizontal: Dimens.padding_small),
            width: double.infinity,
            height: 37,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(Dimens.border_small),
            ),
            child: DropdownButton(
              value: _store.categoryId,
              icon: Icon(
                Icons.keyboard_arrow_down,
              ),
              underline: Text(""),
              isExpanded: true,
              hint: Text(  "Select Category", style: Theme.of(context).textTheme.bodyText1),
              style: Theme.of(context).textTheme.bodyText1,
              items: [
                ..._store.category.map((e) {
                  return DropdownMenuItem<String>(
                    child: Text(e.name.toString()),
                    value: e.id,
                  );
                }).toList(),
              ],
              onChanged: (String? value)  {
              _store.categoryId = value;
              },
            ),
          )
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
        return  DetailsQuestion(id: id);
      },

      onClosed: onClosed,
        transitionDuration: Duration(milliseconds: 500),
      tappable: false,
      closedBuilder: closedBuilder,
      openColor: Theme.of(context).accentColor,
      closedColor: Theme.of(context).scaffoldBackgroundColor  );
  }
}





