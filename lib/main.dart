import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Generation guesser'),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _name;
  final _textName = TextEditingController();
  final _textYear = TextEditingController();
  int? _birthYear;
  String _generation = '';
  bool _validateName = false;
  bool _validateYear = false;


  void _calculateGeneration() {
      setState(() {
        if (_birthYear != null && _textName.text.isNotEmpty) {
          if (_birthYear! < 1946) {
            _generation = 'I don\'t know';
          } else if (_birthYear! < 1965) {
            _generation = 'Baby Boomer Generation';
          } else if (_birthYear! < 1981) {
            _generation = 'Generation X';
          } else if (_birthYear! < 1997) {
            _generation = 'Generation Y';
          } else if (_birthYear! < 2013) {
            _generation = 'Generation Z';
          } else if (_birthYear! < 2026) {
            _generation = 'Generation Alpha';
          } else {
            _generation = 'I don\'t know';
          }
        }
      });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textName,
              decoration: InputDecoration(
                  hintText: "Enter your name",
                  errorText: _validateName ? 'Please insert your name' : null
              ),
              onChanged: (enteredText) {
                setState(() {
                  _name = enteredText;
                });
              },
              ),
            TextField(
              controller: _textYear,
              decoration: InputDecoration(
                  hintText: "Enter your birth year",
                  errorText: _validateYear ? 'Please insert your birth year' : null,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                  signed: false,
                  decimal: false
              ),
              
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]+'))
              ],
              onChanged: (enteredText) {
                setState(() {
                  _birthYear = int.tryParse(enteredText) ?? 0;
                });
              },
            ),
            const SizedBox(
              height: 8,
              ),
            ElevatedButton(
                onPressed: () {
                  _calculateGeneration();
                  _textName.text.isEmpty ? _validateName = true : _validateName = false;
                  _textYear.text.isEmpty ? _validateYear = true : _validateYear = false;
                },
                child: const Text('Calculate your generation')
            ),
        Expanded(child: Text('You belong to: $_generation'))

            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
