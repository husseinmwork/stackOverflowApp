
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

//////////////tag_editor.dart
/// A [Widget] for editing tag similar to Google's Gmail
/// email address input widget in the iOS app.
class TagEditor extends StatefulWidget {
  const TagEditor({
    required this.length,
    this.minTextFieldWidth = 160.0,
    this.tagSpacing = 4.0,
    required this.tagBuilder,
    required this.onTagChanged,
    Key? key,
    this.focusNode,
    this.hasAddButton = true,
    this.delimiters = const [],
    this.icon,
    this.enabled = true,
    this.maxLength = 30,
    // TextField's properties
    this.controller,
    this.textStyle,
    this.inputDecoration = const InputDecoration(),
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.readOnly = false,
    this.autofocus = false,
    this.autocorrect = false,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.resetTextOnSubmitted = false,
    this.onSubmitted,
    this.keyboardAppearance,
  }) : super(key: key);

  /// The number of tags currently shown.
  final int length;

  /// The minimum width that the `TextField` should take
  final double minTextFieldWidth;

  /// The spacing between each tag
  final double tagSpacing;

  /// Builder for building the tags, this usually use Flutter's Material `Chip`.
  final Widget Function(BuildContext, int) tagBuilder;

  /// Show the add button to the right.
  final bool hasAddButton;

  /// The icon for the add button enabled with `hasAddButton`.
  final IconData? icon;

  /// Callback for when the tag changed. Use this to get the new tag and add
  /// it to the state.
  final ValueChanged<String> onTagChanged;

  /// When the string value in this `delimiters` is found, a new tag will be
  /// created and `onTagChanged` is called.
  final List<String> delimiters;

  /// Reset the TextField when `onSubmitted` is called
  /// this is default to `false` because when the form is submitted
  /// usually the outstanding value is just used, but this option is here
  /// in case you want to reset it for any reasons (like converting the
  /// outstanding value to tag).
  final bool resetTextOnSubmitted;

  /// Called when the user are done editing the text in the [TextField]
  /// Use this to get the outstanding text that aren't converted to tag yet
  /// If no text is entered when this is called an empty string will be passed.
  final ValueChanged<String>? onSubmitted;

  /// Focus node for checking if the [TextField] is focused.
  final FocusNode? focusNode;

  /// [TextField]'s properties.
  ///
  /// Please refer to [TextField] documentation.
  final TextEditingController? controller;
  final bool enabled;
  final TextStyle? textStyle;
  final InputDecoration inputDecoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool autofocus;
  final bool autocorrect;
  final bool enableSuggestions;
  final int maxLines;
  final int maxLength;
  final bool readOnly;
  final Brightness? keyboardAppearance;

  @override
  _TagsEditorState createState() => _TagsEditorState();
}

class _TagsEditorState extends State<TagEditor> {
  /// A controller to keep value of the [TextField].
  late TextEditingController _textFieldController;

  /// A state variable for checking if new text is enter.
  var _previousText = '';

  /// A state for checking if the [TextFiled] has focus.
  var _isFocused = false;

  /// Focus node for checking if the [TextField] is focused.
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _textFieldController = (widget.controller ?? TextEditingController());
    _focusNode = (widget.focusNode ?? FocusNode())
      ..addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _onTagChanged(String string) {
    if (string.isNotEmpty) {
      widget.onTagChanged(string);
      _resetTextField();
    }
  }

  /// This function is still ugly, have to fix this later
  void _onTextFieldChange(String string) {
    final previousText = _previousText;
    _previousText = string;

    if (string.isEmpty || widget.delimiters.isEmpty) {
      return;
    }

    // Do not allow the entry of the delimters, this does not account for when
    // the text is set with `TextEditingController` the behaviour of TextEditingContoller
    // should be controller by the developer themselves
    if (string.length == 1 && widget.delimiters.contains(string)) {
      _resetTextField();
      return;
    }

    if (string.length > previousText.length) {
      // Add case
      final newChar = string[string.length - 1];
      if (widget.delimiters.contains(newChar)) {
        final targetString = string.substring(0, string.length - 1);
        if (targetString.isNotEmpty) {
          _onTagChanged(targetString);
        }
      }
    }
  }

  void _onSubmitted(String string) {
    widget.onSubmitted?.call(string);
    if (widget.resetTextOnSubmitted) {
      _resetTextField();
    }
  }

  void _resetTextField() {
    _textFieldController.text = '';
    _previousText = '';
  }

  /// Shamelessly copied from [InputDecorator]
  Color _getDefaultIconColor(ThemeData themeData) {
    if (!widget.enabled) {
      return themeData.disabledColor;
    }

    switch (themeData.brightness) {
      case Brightness.dark:
        return Colors.white70;
      case Brightness.light:
        return Colors.black45;
    }
  }

  /// Shamelessly copied from [InputDecorator]
  Color _getActiveColor(ThemeData themeData) {
    if (_focusNode.hasFocus) {
      switch (themeData.brightness) {
        case Brightness.dark:
          return themeData.accentColor;
        case Brightness.light:
          return themeData.primaryColor;
      }
    }
    return themeData.hintColor;
  }

  Color _getIconColor(ThemeData themeData) {
    final themeData = Theme.of(context);
    final activeColor = _getActiveColor(themeData);
    return _isFocused ? activeColor : _getDefaultIconColor(themeData);
  }

  @override
  Widget build(BuildContext context) {
    final decoration = widget.hasAddButton
        ? widget.inputDecoration.copyWith(
        suffixIcon: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            _onTagChanged(_textFieldController.text);
          },
          child: const Icon(Icons.add),
        ))
        : widget.inputDecoration;

    final tagEditorArea = Container(
      child: TagLayout(
        delegate: TagEditorLayoutDelegate(
          length: widget.length,
          minTextFieldWidth: widget.minTextFieldWidth,
          spacing: widget.tagSpacing,
        ),
        children: List<Widget>.generate(
          widget.length,
              (index) => LayoutId(
            id: TagEditorLayoutDelegate.getTagId(index),
            child: widget.tagBuilder(context, index),
          ),
        ) +
            <Widget>[
              LayoutId(
                id: TagEditorLayoutDelegate.textFieldId,
                child: TextField(
                  style: widget.textStyle,
                  focusNode: _focusNode,
                  enabled: widget.enabled,
                  controller: _textFieldController,
                  keyboardType: widget.keyboardType,
                  keyboardAppearance: widget.keyboardAppearance,
                  textCapitalization: widget.textCapitalization,
                  textInputAction: widget.textInputAction,
                  autocorrect: widget.autocorrect,
                  textAlign: widget.textAlign,
                  textDirection: widget.textDirection,
                  readOnly: widget.readOnly,
                  autofocus: widget.autofocus,
                  enableSuggestions: widget.enableSuggestions,
                  maxLines: widget.maxLines,
                  decoration: decoration,
                  onChanged: _onTextFieldChange,
                  onSubmitted: _onSubmitted,
                  maxLength: widget.maxLength,
                ),
              )
            ],
      ),
    );

    return widget.icon == null
        ? tagEditorArea
        : Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.zero,
            child: IconTheme.merge(
              data: IconThemeData(
                color: _getIconColor(Theme.of(context)),
                size: 18.0,
              ),
              child: Icon(widget.icon),
            ),
          ),
          Expanded(child: tagEditorArea),
        ],
      ),
    );
  }
}

/////////////tag_editor_layout_delegate.dart

class TagEditorLayoutDelegate extends MultiChildLayoutDelegate {
  TagEditorLayoutDelegate({
    required this.length,
    required this.minTextFieldWidth,
    required this.spacing,
  });

  static const tagId = 'tag_';
  static const textFieldId = 'text_field';

  final int length;
  final double minTextFieldWidth;
  final double spacing;

  /// This is used for
  Size parentSize = Size.zero;

  static String getTagId(int id) {
    return '$tagId$id';
  }

  static bool _isOverflow({
    required double childWidth,
    required double parentWidth,
    required List<Size> tagSizes,
    required double spacing,
  }) {
    final tagsWidth = tagSizes.fold<double>(0, (result, tag) {
      return result + tag.width;
    });
    final spacingWidth = spacing * max(tagSizes.length - 1, 0);

    return childWidth + tagsWidth + spacingWidth > parentWidth;
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // * Just putting in 0 to avoid the assert error
    return Size(constraints.maxWidth, 0);
  }

  @override
  void performLayout(Size size) {
    var cursor = Offset.zero;
    var tagSizes = <Size>[];
    //* Layout all the tags here
    for (final index in Iterable<int>.generate(length).toList()) {
      final tagId = getTagId(index);
      if (hasChild(getTagId(index))) {
        final childSize = layoutChild(
          tagId,
          BoxConstraints.loose(
            //* Let child specify it's own heigh so use infinity here
            Size(size.width, double.infinity),
          ),
        );

        //* Check if overflowing
        if (_isOverflow(
          childWidth: childSize.width,
          parentWidth: size.width,
          tagSizes: tagSizes,
          spacing: spacing,
        )) {
          //* Push the cursor down and back to the left
          cursor = Offset(0, cursor.dy + childSize.height);

          //* Reset the tagSizes for this roll
          tagSizes = <Size>[];
        }

        positionChild(tagId, cursor);
        // * Update cursor to the next position
        cursor = Offset(cursor.dx + childSize.width + spacing, cursor.dy);
        // * Push the size to tagSizes
        tagSizes.add(childSize);
      }
    }

    var textFieldSize = Size.zero;

    //* Layout the textbox
    if (hasChild(textFieldId)) {
      final currentRowWidth = tagSizes.fold<double>(0, (result, tag) {
        return result + tag.width;
      });
      final spacingWidth = spacing * max(tagSizes.length - 1, 0);
      final leftOverWidth = size.width - currentRowWidth - spacingWidth;
      final textWidth = max(leftOverWidth, minTextFieldWidth);
      //* Check if Textbox is overflowing
      //* Check if overflowing
      if (_isOverflow(
        childWidth: textWidth,
        parentWidth: size.width,
        tagSizes: tagSizes,
        spacing: spacing,
      )) {
        textFieldSize = layoutChild(
          textFieldId,
          BoxConstraints.loose(Size.fromWidth(size.width)),
        );
        //* Push the cursor down and back to the left
        cursor = Offset(0, cursor.dy + textFieldSize.height);

        //* Reset the tagSizes for this roll
        tagSizes = <Size>[];
      } else {
        textFieldSize = layoutChild(
          textFieldId,
          BoxConstraints.loose(Size.fromWidth(textWidth)),
        );
      }
      positionChild(textFieldId, cursor);
    }

    //* Set parent height so that [TagsRenderLayoutBox] can use it to set the parentHeight
    parentSize = Size(size.width, cursor.dy + textFieldSize.height);
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}


////////////////tag_layout.dart

/// This is just a normal [CustomMultiChildLayout] with
/// overrided [createRenderObject] to use custom [RenderCustomMultiChildLayoutBox]
class TagLayout extends CustomMultiChildLayout {
  TagLayout({
    Key? key,
    required TagEditorLayoutDelegate delegate,
    List<Widget> children = const <Widget>[],
  }) : super(key: key, children: children, delegate: delegate);

  @override
  TagRenderLayoutBox createRenderObject(BuildContext context) {
    return TagRenderLayoutBox(delegate: delegate as TagEditorLayoutDelegate);
  }
}
///////////tag_render_layout_box.dart

/// Got inspiration from below, but did not want to override a bunch of things
/// https://gist.github.com/slightfoot/0ddf14dd0f77e5be4c6b8904d3a2df67
class TagRenderLayoutBox extends RenderCustomMultiChildLayoutBox {
  TagRenderLayoutBox({
    List<RenderBox>? children,
    required TagEditorLayoutDelegate delegate,
  }) : super(children: children, delegate: delegate);

  @override
  void performLayout() {
    super.performLayout();

    //* Set the parent size here
    size = (delegate as TagEditorLayoutDelegate).parentSize;
  }
}