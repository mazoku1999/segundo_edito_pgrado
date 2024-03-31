import 'package:dart_eval/dart_eval.dart';
import 'package:dart_eval/dart_eval_bridge.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:segundo_editor_proyecto_grado/textspan_controller.dart';

// import 'package:proyecto_grado_editor_codigo/textspan_controller.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

late final Highlighter _dartDarkHighlighter;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the highlighter.
  await Highlighter.initialize(['dart', 'yaml', 'sql', 'serverpod_protocol']);
  var darkTheme = await HighlighterTheme.loadDarkTheme();
  _dartDarkHighlighter = Highlighter(
    language: 'dart',
    theme: darkTheme,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _dartCode = '''void main() async {
  for (var i = 0; i <= 10; i++) {
    await Future.delayed(Duration(milliseconds: 700));
    print('Josue: ' + i.toString());
  }
}''';
  final _code = '''import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';

import 'common/snippets.dart';
import 'common/themes.dart';
import 'constants.dart';
import 'widgets/dropdown_selector.dart';

const _defaultLanguage = 'dart';
const _defaultTheme = 'monokai-sublime';

const _defaultAnalyzer = DefaultLocalAnalyzer();
final _dartAnalyzer = DartPadAnalyzer();

const toggleButtonColor = Color.fromARGB(124, 255, 255, 255);
const toggleButtonActiveColor = Colors.white;

final _analyzers = [_defaultAnalyzer, _dartAnalyzer];

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _language = _defaultLanguage;
  String _theme = _defaultTheme;
  AbstractAnalyzer _analyzer = _defaultAnalyzer;

  bool _showNumbers = true;
  bool _showErrors = true;
  bool _showFoldingHandles = true;

  final _codeFieldFocusNode = FocusNode();
  late final _codeController = CodeController(
    language: builtinLanguages[_language],
    namedSectionParser: const BracketsStartEndNamedSectionParser(),
    text: dartSnippet,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themes[_theme]?['root']?.backgroundColor,
      appBar: AppBar(
        actions: [
          //
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                IconButton(
                  color: _showNumbers
                      ? toggleButtonActiveColor
                      : toggleButtonColor,
                  onPressed: () => setState(() {
                    _showNumbers = !_showNumbers;
                  }),
                  icon: const Icon(Icons.numbers),
                ),
                IconButton(
                  color:
                      _showErrors ? toggleButtonActiveColor : toggleButtonColor,
                  onPressed: () => setState(() {
                    _showErrors = !_showErrors;
                  }),
                  icon: const Icon(Icons.cancel),
                ),
                IconButton(
                  color: _showFoldingHandles
                      ? toggleButtonActiveColor
                      : toggleButtonColor,
                  onPressed: () => setState(() {
                    _showFoldingHandles = !_showFoldingHandles;
                  }),
                  icon: const Icon(Icons.chevron_right),
                ),
                const SizedBox(width: 20),
                DropdownSelector(
                  onChanged: _setLanguage,
                  icon: Icons.code,
                  value: _language,
                  values: languageList,
                ),
                const SizedBox(width: 20),
                DropdownSelector<AbstractAnalyzer>(
                  onChanged: _setAnalyzer,
                  icon: Icons.bug_report,
                  value: _analyzer,
                  values: _analyzers,
                  itemToString: (item) => item.runtimeType.toString(),
                ),
                const SizedBox(width: 20),
                DropdownSelector(
                  onChanged: _setTheme,
                  icon: Icons.color_lens,
                  value: _theme,
                  values: themeList,
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          CodeTheme(
            data: CodeThemeData(styles: themes[_theme]),
            child: CodeField(
              focusNode: _codeFieldFocusNode,
              controller: _codeController,
              textStyle: const TextStyle(fontFamily: 'SourceCode'),
              gutterStyle: GutterStyle(
                textStyle: const TextStyle(
                  color: Colors.purple,
                ),
                showLineNumbers: _showNumbers,
                showErrors: _showErrors,
                showFoldingHandles: _showFoldingHandles,
              ),
            ),
          ),
          Text(_codeController.text),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    _codeFieldFocusNode.dispose();

    for (final analyzer in _analyzers) {
      analyzer.dispose();
    }

    super.dispose();
  }

  void _setLanguage(String value) {
    setState(() {
      _language = value;
      _codeController.language = builtinLanguages[value];
      _analyzer = _defaultAnalyzer;

      _codeFieldFocusNode.requestFocus();
    });
  }

  void _setAnalyzer(AbstractAnalyzer value) {
    setState(() {
      _codeController.analyzer = value;
      _analyzer = value;
    });
  }

  void _setTheme(String value) {
    setState(() {
      _theme = value;
      _codeFieldFocusNode.requestFocus();
    });
  }
}
''';
  final _dartCode2 = '''
List<String> ciclo() {
  List<String> mensajes = [];
  for (var i = 0; i <= 10; i++) {
    // await Future.delayed(Duration(milliseconds: 700));
    mensajes.add('Josue: ' + i.toString());
  }
  // for (var mensaje in mensajes) {
  //   print(mensaje);
  // }
  return mensajes;
}
''';

  final _dartCode3 = '''
List<int> ciclo() {
  
  return [4,3,5];
}
''';

  List<String> ciclo() {
    List<String> mensajes = [];
    for (var i = 0; i <= 10; i++) {
      // await Future.delayed(Duration(milliseconds: 700));
      mensajes.add('Josue: ' + i.toString());
    }
    // for (var mensaje in mensajes) {
    //   print(mensaje);
    // }
    return mensajes;
  }

  final TextSpanTextFieldController _controlador = TextSpanTextFieldController(
    dartDarkHighlighter: _dartDarkHighlighter,
  );
  String object = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controlador.text = _dartCode;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ByteGenius'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Container(
              //   padding: const EdgeInsets.all(16),
              //   color: Colors.black,
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Text.rich(
              //       _dartDarkHighlighter.highlight(_dartCode),
              //       style: GoogleFonts.jetBrainsMono(
              //         fontSize: 14,
              //         height: 1.3,
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.black,
                child: TextField(
                  controller: _controlador,
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 14,
                    height: 1.3,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                // _controlador.text = _dartCode;
              },
              child: const Icon(Icons.change_circle_sharp),
            ),
            const SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              onPressed: () async {
                // setState(() {
                //   object = eval(object);
                // });
                // await eval(_dartCode, function: 'main');
                // eval(_controlador.text, function: "main");
                // eval(_dartCode2, function: "ciclo").forEach((element) {
                //   print(element);
                // });

                // final data = ciclo();
                // data.forEach((element) async {
                //   await Future.delayed(Duration(milliseconds: 700)).then(
                //     (value) {
                //       print(element);
                //     },
                //   );
                // });
              },
              child: const Icon(Icons.play_arrow),
            ),
          ],
        ),
      ),
    );
  }
}
