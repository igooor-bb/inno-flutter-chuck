import 'package:chuck/networking/api.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/joke.dart';
import 'about.dart';
import 'dart:math';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _searchController = TextEditingController();
  final _client = ApiService();

  late Future<List<Joke>> _jokesFuture;

  List<Joke> _jokes = [];
  String? _currentCategory;
  int _currentPage = 0;
  bool _flip = false;

  @override
  void initState() {
    _jokesFuture = _client.getRandomJoke(_currentCategory);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  _launchURL() async {
    if (_currentPage < _jokes.length) {
      var url = _jokes[_currentPage].url;
      if (await canLaunch(url)) {
        await launch(url);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text("Chuck Jokes"), actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const About();
                      });
                },
                child: const Icon(
                  Icons.person,
                  size: 26.0,
                ),
              )),
        ]),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      const SectionLabel("search"),
                      const SizedBox(width: 16),
                      Flexible(
                          child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                  hintText: "query",
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .primaryColor))))),
                    ]),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SectionLabel("category"),
                        const SizedBox(width: 16),
                        FutureBuilder<List<String>>(
                            future: _client.getCategories(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<String>> snapshot) {
                              List<DropdownMenuItem<String>> children = [];
                              if (snapshot.hasData) {
                                children = (["all"] + snapshot.data!)
                                    .map((s) => DropdownMenuItem(
                                        value: s, child: Text(s)))
                                    .toList();
                              }
                              return DropdownButton(
                                  value: _currentCategory,
                                  hint: const Text("all"),
                                  items: children,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _currentCategory =
                                          newValue == "all" ? null : newValue;
                                    });
                                  });
                            }),
                        const Spacer(),
                        OutlinedButton(
                            style: TextButton.styleFrom(
                                primary: Theme.of(context).primaryColor),
                            onPressed: () {
                              setState(() {
                                final q = _searchController.text;
                                _currentPage = 0;
                                _flip = !_flip;
                                if (q.isNotEmpty) {
                                  _jokesFuture =
                                      _client.getJokes(q, _currentCategory);
                                } else {
                                  _jokesFuture =
                                      _client.getRandomJoke(_currentCategory);
                                }
                              });
                            },
                            child: const Text("Find Jokes")),
                      ],
                    ),
                    const SizedBox(height: 16),
                    FutureBuilder<List<Joke>>(
                        future: _jokesFuture,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Joke>> snapshot) {
                          List<Text> textItems = [];

                          if (snapshot.hasData) {
                            _jokes = snapshot.data!;
                            textItems =
                                _jokes.map((s) => Text(s.value)).toList();
                          }

                          if (textItems.isEmpty) {
                            return Text("No jokes found :(",
                                style: Theme.of(context).textTheme.caption);
                          } else {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Text(
                                        "Joke ${_currentPage + 1} / ${textItems.length}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption),
                                    const Spacer(),
                                    (() {
                                      if (textItems.length > 1) {
                                        return Text("swipe text back and forth",
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption);
                                      } else {
                                        return const SizedBox();
                                      }
                                    }())
                                  ]),
                                  (() {
                                    if (textItems.length > 1) {
                                      return Column(children: [
                                        const SizedBox(height: 12),
                                        LinearProgressIndicator(
                                            color:
                                                Theme.of(context).primaryColor,
                                            backgroundColor: Colors.black26,
                                            value: (_currentPage + 1) /
                                                textItems.length),
                                      ]);
                                    } else {
                                      return const SizedBox(height: 12);
                                    }
                                  }()),
                                  TextButton.icon(
                                      style: TextButton.styleFrom(
                                          primary:
                                              Theme.of(context).primaryColor,
                                          padding: EdgeInsets.zero,
                                          alignment: Alignment.centerLeft),
                                      icon: const Icon(Icons.link),
                                      label: const Text("Open in browser"),
                                      onPressed: () {
                                        _launchURL();
                                      }),
                                  SizedBox(
                                      height: 220,
                                      child: PageView(
                                          children: textItems,
                                          onPageChanged: (page) {
                                            setState(() {
                                              _currentPage = page;
                                            });
                                          })),
                                ]);
                          }
                        }),
                    const Spacer(),
                    Center(
                        child: SizedBox(
                            child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(_flip ? pi : 0),
                                child: const Image(
                                    image: AssetImage('assets/chuck.png'))),
                            height: 250)),
                  ])),
        ));
  }
}

class SectionLabel extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const SectionLabel(this.text);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 21,
        constraints: const BoxConstraints(minWidth: 80),
        color: Theme.of(context).secondaryHeaderColor,
        child: Text(text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1));
  }
}
