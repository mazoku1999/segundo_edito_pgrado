import 'package:flutter/material.dart';

import 'package:syntax_highlight/syntax_highlight.dart';

class TextSpanTextFieldController extends TextEditingController {
  final Highlighter _dartDarkHighlighter;

  TextSpanTextFieldController({required Highlighter dartDarkHighlighter})
      : _dartDarkHighlighter = dartDarkHighlighter;

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    return _dartDarkHighlighter.highlight(text);
  }
}
