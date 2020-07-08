import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_news/model/news.dart';

abstract class NewsState extends Equatable {}

class LoadedNewsState extends NewsState {
  final List<NewsCategory> cats;

  LoadedNewsState({@required this.cats});

  @override
  List<Object> get props => [cats];
}

class LoadingNewsState extends NewsState {
  @override
  List<Object> get props => [props];
}
