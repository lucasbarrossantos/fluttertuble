import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fluttertube/api.dart';
import 'package:fluttertube/models/video.dart';

class VideosBloc implements BlocBase {
  Api api;
  List<Video> videos;

  final _videosController = StreamController<List<Video>>();
  Stream<List<Video>> get outVideos => _videosController.stream;

  final _searchController = StreamController<String>();
  // Para adicionar algum dado no searchController
  Sink<String> get inSearch => _searchController.sink;

  VideosBloc() {
    api = Api();

    _searchController.stream.listen(_search);
  }

  void _search(String search) async {
    if (search != null) {
      _videosController.sink.add([]); // Para refazer a tela com a lista vazia
      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }
    _videosController.sink.add(videos);
  }

  @override
  void addListener(listener) {}

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

  @override
  bool get hasListeners => null;

  @override
  void notifyListeners() {}

  @override
  void removeListener(listener) {}
}
