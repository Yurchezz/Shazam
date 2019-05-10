import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_refactoring/MovieModal.dart';
//import 'package:connectivity/connectivity.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MaterialApp(
      home: new MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
String downloadRemoveButtonTitle = "Download";
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new AfterSplash(),
        title: new Text(
          'Welcome In SplashScreen',
          style: new TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 20.0),
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
  var _movies = new List<MovieModal>();
  final Set<MovieModal> _downloaded = Set<MovieModal>();
  var isConnected = true;

  _getMovies() {
    API.getMovies().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        _movies = list.map((model) => MovieModal.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getMovies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _buildMovies() {
    return new Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(30, 30, 30, 1),
      ),
      child: ListView.separated(
        itemCount: _movies.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: new CircleAvatar(
              child: new Text(_movies[index].movieName[0]),
              backgroundColor: Colors.redAccent,
            ),
            title: Text(
              _movies[index].movieName,
              style: TextStyle(color: Colors.white70, fontSize: 18.0),
            ),
            onTap: () {
              downloadRemoveButtonTitle = "Download";
              setState(() {
                _build_detail_page(_movies[index]);
              });
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(color: Color.fromRGBO(48, 48, 48, 1));
        },
      ),
    );
  }

  void _pushDownloaded() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        final Iterable<ListTile> tiles = _downloaded.map(
          (MovieModal movie) {
            return ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              leading: new CircleAvatar(
                child: new Text(movie.movieName[0]),
                backgroundColor: Colors.redAccent,
              ),
              title: new Text(
                movie.movieName,
                style: TextStyle(color: Colors.white70, fontSize: 18.0),
              ),
              subtitle: new Text(
                movie.duration,
                style: TextStyle(color: Colors.white70, fontSize: 16.0),
              ),
              onTap: () {
                downloadRemoveButtonTitle = "Remove";
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
                                movie.movieName,
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
                                    print("movie remover" + movie.movieName);

                                  } else {

                                    _downloaded.add(movie);
                                    print("movie added" + movie.movieName);
                                  }
                                },
                                child: new Container(

                                  padding: const EdgeInsets.all(16.0),
                                  alignment: Alignment.center,
                                  child: new Text(
                                    downloadRemoveButtonTitle,
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

//  Future<bool> _isConnected() async {
//    var connectivityResult = await (Connectivity().checkConnectivity());
//    if (connectivityResult == ConnectivityResult.mobile ||
//        connectivityResult == ConnectivityResult.wifi) {
//      print("connected");
//      return true;
//    } else {
//      print('Not connected');
//      return false;
//    }
//  }

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
}

class API {
  static Future getMovies() {
    return http.get("https://shazam-api.herokuapp.com/sounds");
  }
}
