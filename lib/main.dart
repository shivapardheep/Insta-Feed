import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_news/bloc/feeds/feeds_bloc.dart';
import 'package:insta_news/screens/home.dart';

void main() => runApp(
  BlocProvider(
    create: (_) => FeedsBloc(),
    child: MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()),
  ),
);
