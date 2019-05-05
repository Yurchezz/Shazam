import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_refactoring/MovieModal.dart';
import 'package:connectivity/connectivity.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(new MaterialApp(
      home: new MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
String huy = "Download";
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new AfterSplash(),
        title: new Text(
          'Welcome In SplashScreen',
          style: new TextStyle(color: Colors.white70,fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        backgroundColor: Color.fromRGBO(21, 21, 21, 1),
        styleTextUnderTheLoader: new TextStyle(),
        loaderColor: Colors.redAccent);
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Title",
      theme: new ThemeData(
        primaryColor: Color.fromRGBO(21, 21, 21, 1),
      ),
      home: MovieList(),
    );
  }
}

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  MovieModal _movieModal;
  var isConnected = true;

  final _movies = <MovieModal>[
    const MovieModal(name: "FilmName", genre: "adventure"),
    const MovieModal(name: "FilmName 1", genre: "adventure"),
    const MovieModal(name: "FilmName 2", genre: "adventure"),
    const MovieModal(name: "FilmName 3", genre: "adventure"),
    const MovieModal(name: "FilmName 4", genre: "adventure"),
    const MovieModal(name: "FilmName 5", genre: "adventure"),
    const MovieModal(name: "FilmName 6", genre: "adventure"),
    const MovieModal(name: "FilmName 7", genre: "adventure"),
    const MovieModal(name: "FilmName 8", genre: "adventure"),
    const MovieModal(name: "FilmName 9", genre: "adventure"),
    const MovieModal(name: "FilmName 10", genre: "adventure"),
    const MovieModal(name: "FilmName 11", genre: "adventure"),
    const MovieModal(name: "FilmName 12", genre: "adventure"),
    const MovieModal(name: "FilmName 13", genre: "adventure"),
    const MovieModal(name: "FilmName 14", genre: "adventure"),
    const MovieModal(name: "FilmName 15", genre: "adventure"),
    const MovieModal(name: "FilmName 16", genre: "adventure"),
    const MovieModal(name: "FilmName 17", genre: "adventure"),
    const MovieModal(name: "FilmName 18", genre: "adventure"),
    const MovieModal(name: "FilmName 19", genre: "adventure"),
    const MovieModal(name: "FilmName 20", genre: "adventure"),
    const MovieModal(name: "FilmName 21", genre: "adventure"),
    const MovieModal(name: "FilmName 22", genre: "adventure"),
  ];

  final Set<MovieModal> _downloaded = Set<MovieModal>();

  final _biggerFont = const TextStyle(fontSize: 18.0);

  _buildMovies() {
    return new Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(30, 30, 30, 1),
      ),
      child: ListView.separated(
        itemCount: _movies.length,
        itemBuilder: (context, i) {
          return _buildRow(_movies[i]);
        },
        separatorBuilder: (context, i) {
          return Divider(color: Color.fromRGBO(48, 48, 48, 1));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.archive),
            onPressed: _pushDownloaded,
          )
        ],
      ),
      body: _buildMovies(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => _buildAboutDialog(context),
          );
        },
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.sync),
        elevation: 10.0,
      ),
    );
  }

  Future<bool> _isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print("connected");
      return true;
    } else {
      print('Not connected');
      return false;
    }
  }

  void _build_audio_recording() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Name"),
          ),
          body: new Center(
            child: Text("NEW PAGE"),
          ),
        );
      }),
    );
  }

  Widget _buildRow(MovieModal movie) {
    return ListTile(
//        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        leading: new CircleAvatar(
          child: new Text(movie.name[0]),
          backgroundColor: Colors.redAccent,
        ),
        title: new Text(
          movie.name,
          style: TextStyle(color: Colors.white70, fontSize: 18.0),
        ),
        onTap: () {
          huy = "Download";
          setState(() {
            _build_detail_page(movie);
          });
        });
  }

  void _pushDownloaded() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        final Iterable<ListTile> tiles = _downloaded.map(
          (MovieModal movie) {
            final alreadyDownloaded = _downloaded.contains(movie);
            return ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              leading: new CircleAvatar(
                child: new Text(movie.name[0]),
                backgroundColor: Colors.redAccent,
              ),
              title: new Text(
                movie.name,
                style: TextStyle(color: Colors.white70, fontSize: 18.0),
              ),
              onTap: () {
                huy = "Remove";
                setState(() {
                  _build_detail_page(movie);
                });
              },
            );
          },
        );
        final List<Widget> divided = ListTile.divideTiles(
          color: Color.fromRGBO(48, 48, 48, 1),
          context: context,
          tiles: tiles,
        ).toList();
        return Scaffold(
          appBar: AppBar(
            title: Text("Archive"),
          ),
          body: new Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(30, 30, 30, 1),
              ),
              child: ListView(children: divided)),
        );
      }),
    );
  }

  void _build_detail_page(MovieModal movie) {
    final alreadyDownloaded = _downloaded.contains(movie);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ),
          ),
          body: new Stack(
            children: <Widget>[
              new Container(

                decoration: new BoxDecoration(

                  image:  new DecorationImage(
                    image:  new AssetImage("assets/Fury.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: new BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: new Container(
                    decoration: new BoxDecoration(
                      color: Colors.black.withOpacity(0.0),
                    ),
                  ),
                ),
              ),
              new SingleChildScrollView(
                child: new Container(

                  margin: const EdgeInsets.all(20.0),
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        alignment: Alignment.center,
                        child: new Container(

                          width: 400.0,
                          height: 400.0,
                        ),
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(10.0),
                          image:  new DecorationImage(
                            image:  new AssetImage("assets/Fury-2.jpg"),
                          ),
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.black,
                              blurRadius: 20.0,
                              offset: new Offset(0.0, 10.0),
                            )
                          ],
                        ),
                      ),
                      new Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 0.0),
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                              child: new Text(
                                movie.name,
//                              "Fury",
                                style: new TextStyle(
                                    color: Colors.white, fontSize: 30.0),
                              ),
                            ),
                            new Text(
                              "10/10",
                              style: new TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                      new Text(
                        "Lorem Ipsum is simply dummy text of the printing and "
                            "typesetting industry. Lorem Ipsum has been the industry's"
                            " standard dummy text ",
                        style: new TextStyle(color: Colors.white),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(10.0),
                      ),
                      new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new Container(
                              child: new InkWell(
                                onTap: () {
                                  if (alreadyDownloaded) {

                                    _downloaded.remove(movie);
                                    print("movie remover" + movie.name);

                                  } else {

                                    _downloaded.add(movie);
                                    print("movie added" + movie.name);
                                  }
                                },
                                child: new Container(

                                  padding: const EdgeInsets.all(16.0),
                                  alignment: Alignment.center,
                                  child: new Text(
                                    huy,
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.circular(10.0),
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _buildAboutDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Movie synchronization'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAboutText(),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text(
            'Okay, got it!',
            style: TextStyle(color: Colors.redAccent, fontSize: 18.0),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutText() {
    return new RichText(
      text: new TextSpan(
        text:
            'It can take about 20 seconds while application recognize your movie.\n\n',
        style: const TextStyle(color: Colors.black87, fontSize: 18.0),
        children: <TextSpan>[
          const TextSpan(
            text: 'Thanks for understanding.',
            style: const TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
