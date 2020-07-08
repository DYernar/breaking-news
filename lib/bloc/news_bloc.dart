import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/bloc/news_event.dart';
import 'package:flutter_news/bloc/news_state.dart';
import 'package:flutter_news/model/news.dart';
import 'package:http/http.dart' as http;

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  List<NewsCategory> cats = [];

  NewsBloc(NewsState initialState) : super(initialState);

  NewsState get initialState => LoadingNewsState();

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is LoadNewsEvent) {
      yield LoadingNewsState();
      await _getAllNews();
      yield LoadedNewsState(cats: this.cats);
    }
  }

  _getAllNews() async {
    const List<String> strCats = [
      'sports',
      'business',
      'science',
      'technology',
      'politics',
      'health',
    ];
    var client = new http.Client();
    List<NewsCategory> resp = [];
    for (var v in strCats) {
      var response = await client.get(
          'http://newsapi.org/v2/top-headlines?country=us&category=$v&apiKey=e06e9ee443d544c3a0d440b72b4b811a');
      var result = json.decode(response.body);
      List<News> newslist = [];
      if (result['status'] == 'ok') {
        NewsCategory singleCat = new NewsCategory(v, newslist);
        var lost = 0;
        for (var i = 0; i < 10 + lost && i < result['articles'].length; i++) {
          var temp = new News(
            result['articles'][i]['title'],
            result['articles'][i]['description'],
            result['articles'][i]['urlToImage'],
            result['articles'][i]['url'],
          );
          if (temp.img != null && temp.text != null && temp.title != null) {
            singleCat.news.add(temp);
          } else {
            lost++;
          }
        }
        resp.add(singleCat);
      }
    }

    var sources = ['techcrunch', 'CNN', 'business-insider', 'bbc-news'];

    for (var v in sources) {
      var response = await client.get(
          'http://newsapi.org/v2/top-headlines?sources=$v&apiKey=e06e9ee443d544c3a0d440b72b4b811a');
      var result = json.decode(response.body);
      List<News> newslist = [];
      if (result['status'] == 'ok') {
        NewsCategory singleCat = new NewsCategory(v, newslist);
        var lost = 0;
        for (var i = 0; i < 10 + lost && i < result['articles'].length; i++) {
          var temp = new News(
            result['articles'][i]['title'],
            result['articles'][i]['description'],
            result['articles'][i]['urlToImage'],
            result['articles'][i]['url'],
          );
          if (temp.img != null && temp.text != null && temp.title != null) {
            singleCat.news.add(temp);
          } else {
            lost++;
          }
        }
        resp.add(singleCat);
      }
    }
    cats = resp;
  }
}
