import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fluttertube/models/video.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc extends BlocBase {
  Map<String, Video> _favorites = {};

  final _favController = BehaviorSubject<Map<String, Video>>.seeded({});

  Stream<Map<String, Video>> get outFav => _favController.stream;
  Sink<Map<String, Video>> get inFav => _favController.sink;

  FavoriteBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains("favorites")) {
        _favorites =
            json.decode(prefs.getString("favorites")).map((key, value) {
          return MapEntry(key, Video.formJson(value));
        }).cast<String, Video>();

        inFav.add(_favorites);
      }
    });
  }

  void toggleFavotire(Video video) {
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id] = video;
    }

    inFav.add(_favorites);
    _saveFav();
  }

  void _saveFav() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("_favorites", json.encode(_favorites));
    });
  }

  @override
  void dispose() {
    _favController.close();
    super.dispose();
  }
}
