import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/blocs/videos_bloc.dart';
import 'package:fluttertube/screens/home.dart';

import 'api.dart';

void main() {
  Api api = Api();
  api.search("Xiaomi A3");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => VideosBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FlutterTube',
        home: Home(),
      ),
    );
  }
}
